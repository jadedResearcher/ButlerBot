import 'package:CommonLib/Random.dart';

import 'SecretSubjects.dart';

abstract class Subject {
    static RegExp punctuationpattern = new RegExp("[.,\/#!%\^&\*;:{}=\-_`~\(\)]");

    static String getProcessed(String input) {
        return input.toLowerCase().replaceAll(
            punctuationpattern, " ");
    }

    static String getResponse(String subject) {
        String response = SecretSubjects.getResponse(subject);
        if(response != null) return response;

        if(response == null) { //this shouldn't happen but handle it anyways
            return "Wait. I am confused. Were we talking about $subject?";
        }
    }

    static String getConfusedPhrase() {
        return "It seems you have asked about PP's automatic victory assuring robotic doppelganger.. This is an installation designed to surpass PP's entirely abysmal motivation, competance, intelligence, personality, and substance of character while he is away drinking ill advised honey based soda products. The algorithms are guaranteed to be ${90+new Random().nextDoubleRange(0,10)} distinguishable from PP's native neurological responses, based on some statistical analysis I basically just pulled out of my ass right now.";
    }

    static List<String> getSubjects(String input) {
        List<String> ret = new List<String>();
        ret.addAll(SecretSubjects.getSubjects(input));
        return ret;
    }

}