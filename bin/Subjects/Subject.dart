import 'package:CommonLib/Random.dart';

import 'GuideSubjects.dart';
import 'LOMATSubjects.dart';
import 'LamiaSubjects.dart';
import 'PleasantrySubjects.dart';
import 'SecretSubjects.dart';
import 'YouSubjects.dart';

abstract class Subject {
    static RegExp punctuationpattern = new RegExp("[.,\/#!%\^&\*;:{}=\-_`~\(\)]");

    static String getProcessed(String input) {
        return input.toLowerCase().replaceAll(
            punctuationpattern, " ");
    }

    static String getResponse(String subject) {
        String response = PleasantrySubjects.getResponse(subject);
        if(response != null) return response;

        response = LamiaSubjects.getResponse(subject);
        if(response != null) return response;

        response = LOMATSubjects.getResponse(subject);
        if(response != null) return response;

        response = GuideSubjects.getResponse(subject);
        if(response != null) return response;

        response = YouSubjects.getResponse(subject);
        if(response != null) return response;

        response = SecretSubjects.getResponse(subject);
        if(response != null) return response;

        if(response == null) { //this shouldn't happen but handle it anyways
            return "Wait. I am confused. Were we talking about $subject?";
        }
    }

    static String getConfusedPhrase(String input) {
        List<String> words = input.split(" ");
        List<String> choices = ["I would need to query my SysAdmin for permission to discuss that.","The AllFather has not cleared me to discuss that.","No. I don't talk about that.","I don't understand.", "I am confused.", "I mostly only know about the Land of Mists and Trails.", "Why do you want to know about '${new Random().pickFrom(words)}'"];
        return new Random().pickFrom(choices);
    }

    static List<String> getSubjects(String input) {
        List<String> ret = new List<String>();
        ret.addAll(PleasantrySubjects.getSubjects(input));
        ret.addAll(LamiaSubjects.getSubjects(input));
        ret.addAll(LOMATSubjects.getSubjects(input));
        ret.addAll(GuideSubjects.getSubjects(input));
        ret.addAll(YouSubjects.getSubjects(input));
        ret.addAll(SecretSubjects.getSubjects(input));

        return ret;
    }

}