//be can feel lonely or overwhelmed, and can have feelings about the player
//if bb has a feeling about a TOPIC, its kept in the topic
import 'dart:async';

import 'package:CommonLib/Random.dart';

import 'Suspicion.dart';
//todo if lonely, bb might talk to himself (one message an hour) things like "is anyone there?"
// todo or he can independantly change his suspicians about the player with a phrase like "what if they are a spy..."
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
    static int overwhelmed = 0;

    static Future<Null> waitForThings(){
        activityIn15Minutes.clear();
        //TODO every 15 minutes, check if you should START lunch/break and check if you are lonely (if you are, talk to yourself)
        if(lunchStart == null && breakStart == null) {
            checkLunch();
            checkBreak();
            checkLonely();
        }
        new Timer(new Duration(minutes: 15), () => {
        waitForThings()
        });
    }

    static String lunchMessage() {
        return "lunch time mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm";
    }

    static String breakMessage() {
        List<String> messages = <String>["Please wait, ${Feelings.titlePlaceholder}. I am currently on my 15 minute break.","I will be ready to resume after my 15 minute break, ${Feelings.titlePlaceholder}.","Please be patient. I am currently on break, ${Feelings.titlePlaceholder}."];
        return new Random().pickFrom(messages);
    }

    static void checkLonely() {
        if(activityIn15Minutes.isEmpty) {
            loneliness ++;
        }
        if(loneliness > loneliness) {
            //TODO send lonely message (possibly changing suspicions)
        }
    }

    //lunch time mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    static void checkLunch() {
        //TODO lunch time is between noon and noon thirty
        //TODO if you were NOT on lunch break and now you are, you need to tell the user y ou're going on break
    }

    static void checkBreak() {
        //TODO breaks are every 8 hours.
        //TODO if you were NOT on  break and now you are, you need to tell the user y ou're going on break
    }


    static String getTitle() {
        //TODO go through all suspicians. pick the highest one over a threshold and use that title
        return "Observer";
    }

}