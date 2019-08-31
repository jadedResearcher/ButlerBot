import 'package:CommonLib/Collection.dart';
import 'package:CommonLib/Random.dart';

import 'Feelings.dart';
import 'Subject.dart';

abstract class PleasantrySubjects extends Subject {
   static Map<String, List<String>> responses = new Map<String, List<String>>();

   static List<String> getSubjectList() {
       if(responses.isEmpty) initResponses();
       return responses.keys.toList();
   }

    static void initResponses() {
        responses["greeting"] =<String>["hello", "greetings", "salutations"];
        responses["farewell"] =<String>["thank you for talking with me", "goodbye", "dont be a stranger", "it was nice talking with you"];
        responses["status"] =<String>["I'm alright, I suppose.", "i've been better", "I'm okay", "Things are mostly fine","I wish I had more people to talk to"];
        responses["polite"] =<String>["i really do appreciate you being polite.", "it means a lot that you're polite even to a robotic butler", "thank you for being polite","i appreciate you being polite"];
    }

    static String getResponse(String subject) {
        if(responses.isEmpty) initResponses();
        Random rand = new Random();
        if(subject == "time") {
            DateTime now = new DateTime.now();
            //TODO raise the chance of them being a time player
            return "${now.hour}:${now.minute}, the last time I checked, ${Feelings.titlePlaceholder}";
        }else if(responses.containsKey(subject)){
            return rand.pickFrom(responses[subject]);
        }else{
            return null;
        }
    }


    static List<String> getSubjects(String input) {
        String processed = Subject.getProcessed(input);
        List<String> ret = new List<String>();
        if(processed.contains("what time is it") || processed.contains("what is the time") || processed.contains("current time")) {
            ret.add('time');
        }
        if (processed.contains("greeting") || processed.contains("hello") || processed.contains("hey") || processed.contains("salutations") || processed.contains("sup")) {
            ret.add("greeting");
        }
        if(processed.contains("thank") || processed.contains("please") || processed.contains("sir") || processed.contains("maam")) {
            ret.add("polite");
        }

        if(processed.contains("bye") || processed.contains("cya") || processed.contains("later")) {
            ret.add('goodbye');
        }

        if(processed.contains("how are you") || processed.contains("how's it going") || processed.contains("what's up")) {
            ret.add("status");
        }

        return ret;
    }
}