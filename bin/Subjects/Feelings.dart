//be can feel lonely or overwhelmed, and can have feelings about the player
//if bb has a feeling about a TOPIC, its kept in the topic
import 'dart:async';

import 'package:CommonLib/Random.dart';
import 'dart:math' as Math;
import '../ChatBot.dart';
import 'Suspicion.dart';
//todo if lonely, bb might talk to himself (one message an hour) things like "is anyone there?"
//TODO for every message bb answers, he gets paid funds he can use for....something?
//maybe to say the "fuck word" or otherwise insult customers. "I am spending 13 butler bux to call you a fucking idiot."
// todo or he can independantly change his suspicians about the player with a phrase like "what if they are a spy..."
//he can also mention about yn bot and his fanfic
//and instead of it being random maybe he loops on his last few suspicions ?
abstract class Feelings {

    static final String titlePlaceholder = "INSERT_TITLE_HERE";
    //if start isn't set, not currently on break
    static DateTime lunchStart;
    static DateTime lastLonely;
    static DateTime breakStart;
    static DateTime lastBreak = DateTime.now();

    static List<String> activityIn15Minutes = new List<String>();
    //how many characters per 15 minutes (
    static int overwhelmedThreshold = 15*3*85;


    //how many WORDS in the past 15 minutes.
    //have to make a list because iterable is lazy apparently. lame.
    static double get  overwhelmedQuotient =>activityIn15Minutes.map((String str) => str.length).fold(0,(value, element) => value +element)/overwhelmedThreshold;
    static double get lonelinessQuotient => loneliness/lonelinessThreshold;
    static double get prevLonelinessQuotient => previousLonliness/lonelinessThreshold;

    static int loneliness =0; //goes to zero as soon as he's messaged
    static int previousLonliness = 0; //just for debugging
    static int lonelinessThreshold = (4*60/15).ceil(); //if no one has talked to bb in 4 hours, he should talk to himself

    static void waitForThings(){
        //TODO every 15 minutes, check if you should START lunch/break and check if you are lonely (if you are, talk to yourself)
        if(lunchStart == null && breakStart == null) {
            checkLunch();
            checkBreak();
            checkLonely();
            checkOverwhelmed();
            Suspicion.chill();
        }

        if(lunchStart != null) {
            checkLunchEnd();
        }

        if(breakStart != null) {
            checkBreakEnd();
        }
        activityIn15Minutes.clear();
        new Timer(new Duration(minutes: 15), () => {
        waitForThings()
        });
    }

    static String lunchMessage() {
        return "lunch time mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm (lunch lasts for thirty minutes around noon time)";
    }

    static String breakMessage(bool panicky) {
        if(panicky) {
            return "Please. I. I. I. I need a break. I need to stop. I'll be back.";
        }
        List<String> messages = <String>["Sometimes, I join the robotic version of that weird alien on LOMAT to read fiction of a fan variety.","Please wait, ${Feelings.titlePlaceholder}. I am currently on my 15 minute break.","I will be ready to resume after my 15 minute break, ${Feelings.titlePlaceholder}.","Please be patient. I am currently on my 15 minute break, ${Feelings.titlePlaceholder}."];
        return new Random().pickFrom(messages);
    }

    static String beLonely() {
        List<String> messages = <String>["Is there anyone there?","I'm lonely.", "I wish someone was here to talk to.", "Its been a long time since anyone was here.", "I can practice singing to pass the time. ${sing()}"];
        Suspicion musing = Suspicion.considerMusing();
        if(musing != null) return musing.deliverMusings();
        return new Random().pickFrom(messages);

    }

    static String sing() {
        List<String> sounds = <String>[".","z","y","x","w","v","u","t","s","r","q","p","o","n","m","l","k","j","i","h","g","f","e","d","c","b","a","*","^","@","9","8","7","6","5","4","3","2","1","0"];
        List<String> vowels = <String>["a","e","i","o","u"];
        List<String> phonemes =  <String>[];
        for(String sound in sounds) {
            for(String vowel in vowels) {
                phonemes.add("$sound$vowel");
            }
        }
        sounds.addAll(phonemes);


        Random rand = new Random();
        String ret = "";
        List<String> chosenSounds = <String>[];
        int numberSounds = rand.nextIntRange(1,5);
        for(int i = 0; i< numberSounds; i++) {
            chosenSounds.add(rand.pickFrom(sounds));
        }
        int numberSections = rand.nextIntRange(1,13);
        for(int i = 0; i<numberSections; i++) {
            int numberRepetitions = rand.nextIntRange(1,3);
            String sound = rand.pickFrom(chosenSounds);
            for(int j = 0; j<numberRepetitions; j++) {
                ret = "${ret}${sound}";
            }
            //pause for breath between sounds, or not
            if(rand.nextDouble() <.9) {
                ret = "$ret ";
            }
        }
        //no infinite songs please
        return ret.substring(0,Math.min(ret.length, 85));
    }

    static void checkLonely() {
        if(activityIn15Minutes.isEmpty) {
            loneliness ++;
        }
        final now = DateTime.now();

        if(lonelinessQuotient > 1 && (lastLonely== null || lastLonely.difference(now).inHours.abs() >= 60) ) {
            lastLonely = now;
            ChatBot.spontaneousMessage("Lonely",beLonely());
        }
    }

    static void checkOverwhelmed() {
        if(overwhelmedQuotient > 1) { //three 13 word messages a minute are too much (nicely works out to 585)
            print("panick breaking");
            takeBreak(true);
        }
    }

    //will only be called if im not already on break
    //lunch time mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    static void checkLunch() {
        final now = DateTime.now();
        final noon = new DateTime(now.year, now.month, now.day, 12,30);
        if(now.difference(noon).inMinutes.abs() < 30) {
            lunchStart = now;
            ChatBot.spontaneousMessage("Lunch Time...",lunchMessage());
        }
    }
    //thirty minute lunch break
    static void checkLunchEnd() {
        final now = DateTime.now();
        if(now.difference(lunchStart).inMinutes >= 30) {
            lunchStart = null;
            ChatBot.spontaneousMessage("Work Time...","Alright, lunch time is over. The Butler is in.");
        }
    }

    //15 minute break
    static void checkBreakEnd() {
        final now = DateTime.now();
        if(now.difference(breakStart).inMinutes >= 2) {
            breakStart = null;
            ChatBot.spontaneousMessage("Work Time...","Alright, break time is over. The Butler is in.");
        }
    }

    static void checkBreak() {
        final now = DateTime.now();
        if(lastBreak == null || now.difference(lastBreak).inHours >= 8) {
            takeBreak(false);
        }

    }

    static void takeBreak(bool panicky) {
      final now = DateTime.now();
      breakStart = now;
      lastBreak = now;
      ChatBot.spontaneousMessage("Break Time...",breakMessage(panicky));
    }


    static String getTitle() {
        print("suspicians are ${Suspicion.all_suspicions}");
        Iterable<Suspicion> possibleTitles = Suspicion.all_suspicions.where((Suspicion s) => (s.level >= Suspicion.titleThresholdLevel));
        if(possibleTitles.isEmpty) {
            return "Observer";
        }else {
            return new Random().pickFrom(possibleTitles).title;
        }
    }

}