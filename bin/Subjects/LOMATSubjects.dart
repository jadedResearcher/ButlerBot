import 'package:CommonLib/Collection.dart';
import 'package:CommonLib/Random.dart';

import 'Subject.dart';

abstract class SecretSubjects extends Subject {
   static Map<String, List<String>> responses = new Map<String, List<String>>();

    static void initResponses() {
        responses["gull"] =<String>["isn't that some kind of puzzle?", "i don't think that really matters here."];
        responses["fenrir"] =<String>["i don't know what that is.", "it sounds like a land."];
        responses["grave"] =<String>["i don't know who that is.", "they sound nice, whoever they are"];
        responses["wagon"] =<String>["i don't know who that is.", "they sound nice, whoever they are"];
        responses["yn"] =<String>["i don't know who that is.", "they sound nice, whoever they are"];
        responses["loki"] =<String>["i don't know who that is.", "they sound nice, whoever they are"];
        responses["lil scumbag"] =<String>["i don't know who that is.", "they sound nice, whoever they are"];
        responses["grim reaper"] =<String>["i don't know who that is.", "they sound nice, whoever they are"];
        responses["city"] =<String>["junior seems to somehow be involved in the creation of this game", "junior makes weird podcasts", "junior is a 'waste of mind', whatever that means"];
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


    //gull fenrir grave city wagon yn loki lil scumbag grim reaper
    static List<String> getSubjects(String input) {
        String processed = Subject.getProcessed(input);
        List<String> ret = new List<String>();


        if (processed.contains("grim") || processed.contains("reaper")) {
            ret.add("grim reaper");
        }

        if (processed.contains("possum") || processed.contains("scumbag")) {
            ret.add("lil scumbag");
        }

        if (processed.contains("loki") || processed.contains("leprechaun")) {
            ret.add("loki");
        }

        if (processed.contains("yn") || processed.contains("yearnfulNode") || processed.contains("rogue") || processed.contains("hope")) {
            ret.add("yn");
        }

        if (processed.contains("wagon") || processed.contains("boat")) {
            ret.add("wagon");
        }

        if (processed.contains("who is shogun")) {
            ret.add("shogun");
        }

        if (processed.contains("city") || processed.contains("town") || processed.contains("burg")) {
            ret.add("city");
        }

        if (processed.contains("grave") || processed.contains("tombstone") || processed.contains("bury") || processed.contains("dead")) {
            ret.add("grave");
        }

        if (processed.contains("fenrir") || processed.contains("denizen") || processed.contains("titan") || processed.contains("dog") || processed.contains("wolf") || processed.contains("dick")) {
            ret.add("fenrir");
        }

        if (processed.contains("gull") || processed.contains("bird") || processed.contains("consort") || processed.contains("skele")) {
            ret.add("gull");
        }

        return ret;
    }
}