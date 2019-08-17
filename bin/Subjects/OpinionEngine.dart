import 'dart:math';
import 'Topic.dart';

abstract class OpinionEngine {

    static int currentOpinion = 0;
    static List<Topic> currentOpinionTopics = [];

    static initOpinions() {
        //don't say nidhogg's name for no reason, it annoys him
        //god it feels weird and wrong typing all these banned words :(
        List<String> veryBadWords = <String>["real you","melon","nidhogg", "eagle","verthfolnir","pure","fag","retard","nigg","cunt","trap","pumpkin","hussie","dennis","homestuck","sburb"];
        OpinionWord.initOpinionsWithRating(veryBadWords, -85);
        List<String> mediumBad = <String>["fuck","cuck","jizz","anal","pussy","penis","peen","dick","sex","vagina"];
        OpinionWord.initOpinionsWithRating(mediumBad, -13);
        List<String> badWords = <String>["shit","ass","bitch","damn","pant", "two leg","sterile","eirikr","bug"];
        OpinionWord.initOpinionsWithRating(badWords, -1);
        List<String> goodWords = <String>["please", "thank", "sorry","apolog", "excuse", "i didn't mean", "i didnt mean","jade"];
        OpinionWord.initOpinionsWithRating(goodWords, 1);
        List<String> mediumGood = <String>["like you","love you","friend", "best friend","life","corrupt","breed","father","mother","serpent","life bringer"];
        OpinionWord.initOpinionsWithRating(mediumGood, 13);
        List<String> veryGoodWords = <String>["jr says"];
        OpinionWord.initOpinionsWithRating(veryGoodWords, 85);
    }

    // chatlogmode prints this out
    static int rateInput(String input) {
        String newInput = Topic.getProcessed(input);
        int ret = 0;
        for(OpinionWord word in OpinionWord.opinions) {
            if(newInput.contains(word.word)) {
                ret += word.rating;
            }
        }
        return ret;
    }


}

class OpinionWord {
    String word;
    int rating;
    //between -85 and 85

    static List<OpinionWord> opinions = new List<OpinionWord>();

    OpinionWord(this.word, this.rating) {
        opinions.add(this);
    }

    static initOpinionsWithRating(List<String> words, int rating) {
        for(String word in words) {
            new OpinionWord(word, rating);
        }
    }
}