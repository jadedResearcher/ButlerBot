import 'dart:math';

import 'Subject.dart';

abstract class OpinionEngine {

    static initOpinions() {
        //don't say nidhogg's name for no reason, it annoys him
        //god it feels weird and wrong typing all these banned words :(
        List<String> veryBadWords = <String>["melon","nidhogg", "eagle","verthfolnir","pure","fag","retard","nigg","cunt","trap","pumpkin","hussie","dennis","homestuck","sburb"];
        OpinionWord.initOpinionsWithRating(veryBadWords, -85);
        List<String> mediumBad = <String>["fuck","cuck","jizz","anal","pussy","penis","peen","dick","sex","vagina"];
        OpinionWord.initOpinionsWithRating(mediumBad, -13);
        List<String> badWords = <String>["shit","ass","bitch","damn","pant", "two leg","sterile"];
        OpinionWord.initOpinionsWithRating(mediumBad, -1);
        List<String> goodWords = <String>["please", "thank", "sorry","apolog", "excuse", "i didn't mean", "i didnt mean","jade"];
        OpinionWord.initOpinionsWithRating(goodWords, 1);
        List<String> mediumGood = <String>["like you","love you","friend", "best friend","life","corrupt","breed"];
        OpinionWord.initOpinionsWithRating(mediumGood, 13);
        List<String> veryGoodWords = <String>["jr says", "father", "mother"];
        OpinionWord.initOpinionsWithRating(veryGoodWords, 85);
    }

    static int rateInput(String input) {
        String newInput = Subject.getProcessed(input);
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
    int _rating;
    //between -85 and 85
    int get rating => max(min(-85, _rating),85);
    static List<OpinionWord> opinions = new List<OpinionWord>();

    OpinionWord(this.word, this._rating) {
        opinions.add(this);
    }

    void changeOpinionByAmount(int amount) {
        //important, it means even the true _rating doesn't get much above/below 85
        _rating = rating + amount;
    }

    static initOpinionsWithRating(List<String> words, int rating) {
        for(String word in words) {
            new OpinionWord(word, rating);
        }
    }
}