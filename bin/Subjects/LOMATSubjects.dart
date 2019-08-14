import 'package:CommonLib/Collection.dart';
import 'package:CommonLib/Random.dart';

import 'Subject.dart';

abstract class LOMATSubjects extends Subject {
   static Map<String, List<String>> responses = new Map<String, List<String>>();

    static void initResponses() {
        List<String> gulls = <String>["Ebony", "Skoll", "Nut", "Geb", "The Kid", "Hajala", "Fenrir Junior", "Sans", "Roger Koon"];
        String favGull = new Random().pickFrom(gulls);
        responses["gull"] =<String>["i love each and every one of those sqwawking birds.", "my favorite gull is $favGull", "It really is a shame what fenrir did to them.", "I hope the gulls can find peace. Even if I'd be lonely after."];
        responses["fenrir"] =<String>["i wish he'd stop rubbing my non player status in.", "fenrir really upset all those gulls", "fenrir is so entitled. what an asshole."];
        responses["grave"] =<String>["rest in peace.", "some graves have hidden messages on them"];
        responses["wagon"] =<String>["After PP crashed his boat, I converted it into a more suitable form.", "there is something satisfying about transporting small parties over long distances in a wagon", "PP would be so pissed if he realized what I did to his boat"];
        responses["yn"] =<String>["I don't think he knows what is going on.", "It sounds like he knows exactly what is going on.", "i don't think he's a lamia."];
        responses["loki"] =<String>["I don't know who loki is.", "I only know the name 'loki', nothing more."];
        responses["sandwich"] =<String>["I don't know why the land of mist and trials is covered in half eaten sandwiches. I only know I don't like it.", "As a superior robot, I do not eat."];
        responses["lil scumbag"] =<String>["i don't know what kind of consort the trash gobling is, but they are cute", "even though i don't need trash, every time i see lil scumbag i am happy"];
        responses["grim reaper"] =<String>["Once, the grim reaper told me that he was happy to have help. I don't know how I helped him.", "One of the gulls really likes the grim reaper."];
        responses["city"] =<String>["You get used to not being able to leave towns normally.", "The way city names works makes a lot of sense to me.", "Have you ever been to hot pinkgard?"];
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