import 'package:CommonLib/Collection.dart';
import 'package:CommonLib/Random.dart';

import 'Subject.dart';

abstract class GuideSubjects extends Subject {
   static Map<String, List<String>> responses = new Map<String, List<String>>();

    static void initResponses() {
        responses["player"] =<String>["while i do indeed 'play' LOMAT, i am not its player, no.", "I care deeply about each and every consort on LOMAT, but alas, as I am not their Player they have no bond to me", "Fenrir is needlessly cruel in pointing out that I am not his assigned Player"];
        responses["guide"] =<String>["While a Guide leads, a Butler serves.", "A Guide of Void is meant to lead others towards their aspect.", "I might be a Guide at heart, but I have Chosen to be a Butler. How may I serve you?", "Once I found a podcast by a different sort of GuideBot. They were so angry at eggs."];
        responses["PP"] =<String>["pompousPsycho is the paldemic handle of my organic dopelganger", "pompousPsycho is a useless, hedonistic layabout, and i don't want to discuss him", "PP chose his chat handle to both emphasize his upcoming role on LOMAT, and to hate flirt with YY.", "As a tail-less lamia, PP did not have the right to have his lands mythological name in his chat handle."];
        responses["Eirikr"] =<String>["Eirikr...means well. And I understand that a lack of agency breeds lack of motivation and discontent. But he can't both refuse to do his job AND complain I exist. ", "Eirikr is a burgundy blooded tail-disadvantaged lamia, and proud of it. His rebelious nature is why I exist.", "I exist because Eirikr refuses to do the job he was grown to do."];
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

        if (processed.contains("pp") || processed.contains("pompousPsycho")) {
            ret.add("PP");
        }

        if (processed.contains("Eirikr")) {
            ret.add("Eirikr");
        }

        if (processed.contains("guide") || processed.contains("void")) {
            ret.add("guide");
        }

        if (processed.contains("play") || processed.contains("game")) {
            ret.add("player");
        }

        return ret;
    }
}