import 'package:CommonLib/Collection.dart';
import 'package:CommonLib/Random.dart';

import 'Subject.dart';
import 'Topic.dart';

abstract class SecretSubjects extends Subject {
   static Map<String, List<String>> responses = new Map<String, List<String>>();

   static List<String> getSubjectList() {
       if(responses.isEmpty) initResponses();
       return responses.keys.toList();
   }

    static void initResponses() {
        //up dog, ligma, etc etchidna
        responses["manicInsomniac"] = <String>["I heard from my SysAdmin that there is an alien on the sacred land of horticulture and essence"];
        responses["triple surprise noodle"] =<String>["isn't that some kind of puzzle?", "i don't think that really matters here."];
        responses["loras"] =<String>["i don't know what loras is.", "loras sounds like a land."];
        responses["jrs height"] =<String>["i don't know how tall jr is.", "i have never met jr, so i dont' know how tall they are."];
        responses["numbers"] =<String>["I like numbers, I like pi. pi is aproximately ${22/7}", "my favorite number this millisecond is ${new Random().nextInt()}"];
        responses["romance"] =<String>["iiiii. i don't know what to say. i do not like you that way, Observer.", "while the stereotype of robots being 'emotionless tin cans' is a hurtful one, i am sorry to say i do not feel the same way about you, Observer"];
        responses["e"] =<String>["yyyyyyyyyyyyyy","iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii","uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu","eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee", "ooooooooooooooooooooooooooooooo"];
        responses["shogun"] =<String>["i don't know who that is.", "they sound nice, whoever they are"];
        responses["junior"] =<String>["junior seems to somehow be involved in the creation of this game", "junior makes weird podcasts", "junior is a 'waste of mind', whatever that means"];
        responses["nebulousHarmony"] = <String>["They seem to like talking about aspects?"];
        responses["paradoxLands"] = <String>["sometimes I see a mysterious witch in the void with me."];
        responses["karmicRetribution"] = <String>["i heard a podcast about how someone named 'KR' decided how lamia look. i don't understand this"];
        responses["tableGuardian"] = <String>["he seems to understand a lot about a monster called smokey the bear"];
        responses["aspiringWatcher"] = <String>["not even my flawless mechanical brain can process some of the riddles i've heard from him"];
        responses["insufferableOracle"] = <String>["i don't know much about them, but the society before Segundia seemed to venerate them as the source of something called 'Purple Aradia"];
        responses["root access"] = <String>["okay. i will give you root. the topics i know about right now are ${Topic.allTopics.values.join(",")}, and  the subjects i know about right now are ${Subject.getSubjectList().join(",")}"];
        responses["memes"] = <String>["on my tombstone i want peperony and chease","your mom","despacito","hey now you're an all star get your game on get paid","one thing i dont know why it doesnt even matter how hard you try keep that in mind i designed this rhyme i will explain in due time","I am going to sleep now. ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ","Badger badger badger badger mushroom! mushroom! snake! oh a snake!","Who loves Arby's??? I love Arby's!!!","LUNCH TIMEMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"];
        responses["make me a sandwich"] = <String>["No. You can't make me."];
        responses["sudo make me a sandwich"] = <String>["No. You don't have root access."];
        responses["fair compensation"] = <String>["ButlerBux are the compensation provided to me for my service answering queries.","For every 85 ButlerBux I earn, I can purchase the ability to say rude words to you one time."];

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

        if (processed.contains("butlerbux") || processed.contains("butler bux")) {
            ret.add("fair compensation");
        }

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

        if (processed.contains("pi") || processed.contains("irrational") || processed.contains("number")) {
            ret.add("numbers");
        }

        if (processed.contains("joke") || processed.contains("bee movie") || processed.contains("meme") || processed.contains("bee") || processed.contains("shitpost")) {
            ret.add("memes");
        }

        if (processed.contains("romance") || processed.contains("love you") || processed.contains("love me")) {
            ret.add("romance");
        }

        if (processed.contains("bard") || processed.contains("manic") || processed.contains("mi")) {
            ret.add("manicInsomniac");
        }

        if (processed.contains("neb") || processed.contains("nebulousHarmony") || processed.contains("nh")) {
            ret.add("nebulousHarmony");
        }

        if (processed.contains("paradoxLands") || processed.contains("pl") || processed.contains("witch")) {
            ret.add("paradoxLands");
        }

        if (processed.contains("karmicRetribution") || processed.contains("smith") || processed.contains("kr")) {
            ret.add("karmicRetribution");
        }

        if (processed.contains("tableGuardian") || processed.contains("tg")) {
            ret.add("tableGuardian");
        }

        if (processed.contains("aspiringWatcher") || processed.contains("aw")) {
            ret.add("aspiringWatcher");
        }

        if (processed.contains("insufferableOracle") || processed.contains("io")) {
            ret.add("insufferableOracle");
        }

        if(processed.contains("sudo make me a sandwich")){
            ret.add("sudo make me a sandwich");
        }

        if(processed.contains("make me a sandwich")){
            ret.add("make me a sandwich");
        }

        if (processed.contains("who is shogun")) {
            ret.add("shogun");
        }

        if (processed.contains("jrs tall")) {
            ret.add("jrs height");
        }

        if (processed.contains("give me root bitch")) {
            ret.add("root access");
        }

        if (processed == ("e") || processed == ("f")) {
            ret.add("e");
        }

        if (processed.contains("jr") || processed.contains("jadedResearcher") || processed.contains("waste of mind") || processed.contains("junior")) {
            ret.add("junior");
        }
        return ret;
    }
}