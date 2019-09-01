//be can feel lonely or overwhelmed, and can have feelings about the player
//if bb has a feeling about a TOPIC, its kept in the topic
import 'dart:async';

import 'package:CommonLib/Random.dart';

import '../ChatBot.dart';
import 'Suspicion.dart';
//todo if lonely, bb might talk to himself (one message an hour) things like "is anyone there?"
//TODO for every message bb answers, he gets paid funds he can use for....something?
//maybe to say the "fuck word" or otherwise insult customers. "I am spending 13 butler bux to call you a fucking idiot."
// todo or he can independantly change his suspicians about the player with a phrase like "what if they are a spy..."
//he can also mention about yn bot and his fanfic
//and instead of it being random maybe he loops on his last few suspicions ?
abstract class Feelings {

    static final String titlePlaceholder = "<INSERT_TITLE_HERE>";
    //if start isn't set, not currently on break
    static DateTime lunchStart;
    static DateTime breakStart;
    static DateTime lastBreak;

    static List<String> activityIn15Minutes = new List<String>();
    static List<Suspicion> all_suspicions = new List<Suspicion>();
    static int loneliness =0; //goes to zero as soon as he's messaged
    static int lonelinessThreshold = (4*60/15).ceil(); //if no one has talked to bb in 4 hours, he should talk to himself

    static void waitForThings(){
        //TODO every 15 minutes, check if you should START lunch/break and check if you are lonely (if you are, talk to yourself)
        if(lunchStart == null && breakStart == null) {
            checkLunch();
            checkBreak();
            checkLonely();
            checkOverwhelmed();
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
        List<String> messages = <String>["Please wait, ${Feelings.titlePlaceholder}. I am currently on my 15 minute break.","I will be ready to resume after my 15 minute break, ${Feelings.titlePlaceholder}.","Please be patient. I am currently on my 15 minute break, ${Feelings.titlePlaceholder}."];
        return new Random().pickFrom(messages);
    }

    static void checkLonely() {
        if(activityIn15Minutes.isEmpty) {
            loneliness ++;
        }
        if(loneliness > lonelinessThreshold) {
            //TODO send lonely message (possibly changing suspicions)
        }
    }

    static void checkOverwhelmed() {
        if(activityIn15Minutes.length > 15*3) { //three messages a minute are too much
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
        //TODO go through all suspicians. pick the highest one over a threshold and use that title
        return "Observer";
    }

}