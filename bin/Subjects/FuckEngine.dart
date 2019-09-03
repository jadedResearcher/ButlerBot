import 'Feelings.dart';
import 'OpinionEngine.dart';
import "dart:math" as Math;

abstract class FuckEngine {
    static int minumumBux = 85;
    //call when someone says something extra rude or panic break
    //based on what input happened last, decide just how much butler bux to spend to tell them to fuck off
    static String deployFucks(String input) {
        if(Feelings.butlerBux <minumumBux) {
            return "I apologize, ${Feelings.titlePlaceholder}, but I have insufficient ButlerBux to respond correctly to your query.";
        }

        int verdict = judgeInput(input);
        print("verdict is $verdict");
        int wantedBux = 0;
        //425 is the max slur rating and 500 is the max word rating
        if(verdict > 900) {
            wantedBux = 5;
        }else if (verdict > 750) {
            wantedBux = 4;
        }else if (verdict > 500) {
            wantedBux = 3;
        }else if (verdict > 250) {
            wantedBux = 2;
        }else {
            //a judicious and single fuck was had
            wantedBux = 1;
        }

        int budget = Math.min(Feelings.butlerBux, wantedBux * minumumBux);
        print("budget is $budget");


    }

    //if you were wordy or rude the judgement is worse
    static int judgeInput(String input) {
        //-85 is as bad as it can get, a high rating is bad here so invert
        //multiply by 5 so it can stack up to the char count
        int slurRating = 5*-1* OpinionEngine.rateInput(input);
        return slurRating + input.length;
    }

}