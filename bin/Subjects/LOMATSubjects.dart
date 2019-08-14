import 'package:CommonLib/Collection.dart';
import 'package:CommonLib/Random.dart';

import 'Subject.dart';

abstract class SecretSubjects extends Subject {
   static Map<String, List<String>> responses = new Map<String, List<String>>();

    static void initResponses() {
        responses["triple surprise noodle"] =<String>["isn't that some kind of puzzle?", "i don't think that really matters here."];
        responses["loras"] =<String>["i don't know what that is.", "it sounds like a land."];
        responses["shogun"] =<String>["i don't know who that is.", "they sound nice, whoever they are"];
        responses["junior"] =<String>["junior seems to somehow be involved in the creation of this game", "junior makes weird podcasts", "junior is a 'waste of mind', whatever that means"];
    }

    static String getResponse(String subject) {
        if(responses.isEmpty) initResponses();
        Random rand = new Random();
        if(responses.containsKey(subject)){
            return rand.pickFrom(responses[subject]);
        }else{
            return null;
        }
    }


    static List<String> getSubjects(String input) {
        String processed = Subject.getProcessed(input);
        List<String> ret = new List<String>();

        if (processed.contains("better than expected") ||
            processed.contains("[???]") || processed.contains("???")) {
            ret.add( "triple surprise noodle");
        }
        if (processed.contains("better than expected") || processed.contains("[???]") || processed.contains("???")) {
            ret.add("triple surprise noodle");
        }

        if (processed.contains("loras") || processed.contains("janus") || processed.contains("rods")) {
            ret.add("loras");
        }

        if (processed.contains("who is shogun")) {
            ret.add("shogun");
        }

        if (processed.contains("jr") || processed.contains("jadedResearcher") || processed.contains("waste of mind") || processed.contains("junior")) {
            ret.add("junior");
        }
        return ret;
    }
}