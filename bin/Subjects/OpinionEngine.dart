import 'dart:math';
import 'Topic.dart';

abstract class OpinionEngine {

    static int currentOpinion = 0;
    static List<Topic> currentOpinionTopics = [];
    static List<String> veryBadWords = <String>["real you","real player","true player","melon","nidhogg","nidhog", "eagle","verthfolnir","pure","fag","retard","nigg","cunt","trap","pumpkin","hussie","dennis","homestuck","sburb", "andrew","cuck","jizz","anal","pussy","penis","peen","dick","sex","vagina","fuck"];
    static List<String> mediumBad = <String>["shit","ass","bitch","damn","daddy","mommy","bee","bees","vanessa","bloome","princess and the pea", "black and yellow","barry","jock","vannie","navy","seal"];

    static initOpinions() {
        //in addition to changing BB's overall opinion based on what you say and how you say it,
        // it gives it tendencies towards opinions about topics
        //don't say nidhogg's name for no reason, it annoys him
        //god it feels weird and wrong typing all these banned words :(
        OpinionWord.initOpinionsWithRating(veryBadWords, -85);
        OpinionWord.initOpinionsWithRating(mediumBad, -13);
        List<String> badWords = <String>["pant", "two leg","sterile","eirikr","bug","mom","dad","eirikr","pp","pompousPsycho","psycho","pompous","kharun"];
        OpinionWord.initOpinionsWithRating(badWords, -1);
        List<String> goodWords = <String>["please", "thank", "sorry","apolog", "excuse", "i didn't mean", "i didnt mean","jade","coin","bye","seeya","cya","i have to go","despap","sysadmin","good"];
        OpinionWord.initOpinionsWithRating(goodWords, 1);
        List<String> mediumGood = <String>["do you want","like you","love you","friend", "best friend","life","corrupt","breed","father","mother","serpent","life bringer","about you","you like","segundia","how are you", "how's it going","how have you been","are you okay","sir"];
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