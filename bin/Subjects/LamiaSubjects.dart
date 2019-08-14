import 'package:CommonLib/Collection.dart';
import 'package:CommonLib/Random.dart';

import 'Subject.dart';

abstract class LamiaSubjects extends Subject {
   static Map<String, List<String>> responses = new Map<String, List<String>>();

   static List<String> getSubjectList() {
       if(responses.isEmpty) initResponses();
       return responses.keys.toList();
   }

    static void initResponses() {
        responses["snake"] =<String>["Lamia society is divided into the proper tailed lamia, and the unfortunate leg lamia.", "In order to do full tree breeding, lamia require proper tails, which can split into roots.","Leg Lamia are more expendable than tail lamia, since their breeding methods are as slow as whatever their host species is.", "Since tail lamia breed faster, the Father values them more."];
        responses["fruit"] =<String>["All Lamia are born either from fruit, or from a host species.", "Growing fruit is the highest calling of any Lamia, and my organic dopelganger despises that caste."];
        responses["caste"] =<String>["While lamia blood color does matter, as I explained to that Bard for her CaseStudy, tail status matters far more.", "As a robot, my caste is Leg-Blue."];
        responses["corruption"] =<String>["The unending will to live is the call of the Father/Mother.", "Nidhogg's will is that we spread and thrive.", "Life is Power. Power corrupts. But would you really prefer death?"];
        responses["purification"] =<String>["As a meta-narrative bot, I am aware of multiple timelines and am deeply concerned about purification.", "So called purification appears to make lamia obsessed with death, to the point of trying to kill a Universe.", "Nidhogg isn't meant to be purified. Don't destroy life."];
        responses["segundia"] = <String>["Segundia is the most succesful Empire in the universe, spaning multiple galaxies throughout each version of Alternia reachable through the TIMEHOLE", "Segundia is the mighty empire founded by Nidhogg, the AllMother and AllFather", "I only briefly was on Segundia before being sent to the Land of Mists and Trails along with the Guide.", "Segundia is a shining example of what caring about all of its citizen's Life can achieve", "without the TIMEHOLE, Segundia would not exist", "without the timehole, segundia would not be able to spread past a single timeline", "segundia spans every alternate version of what was once Alternia, but still is only a single universe", "Once a truly new universe can be accessed, Segundia can be spread past simply being in remixes of the same universe "];
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


    //snake, fruit, corruption, purification, caste
    static List<String> getSubjects(String input) {
        String processed = Subject.getProcessed(input);
        List<String> ret = new List<String>();
        if (processed.contains("snake") || processed.contains("lamia") || processed.contains("leg")) {
            ret.add("snake");
        }
        if (processed.contains("fruit") || processed.contains("tree") || processed.contains("nidhogg") || processed.contains("father")) {
            ret.add("fruit");
        }
        if (processed.contains("corrupt")) {
            ret.add("corruption");
        }

        if (processed.contains("segundia") || processed.contains("alternia") || processed.contains("empire")) {
            ret.add("segundia");
        }
        if (processed.contains("purification") || processed.contains("pure")) {
            ret.add("purification");
        }
        if (processed.contains("caste") || processed.contains("blood") || processed.contains("color")) {
            ret.add("caste");
        }

        return ret;
    }
}