import 'package:CommonLib/Random.dart';

import 'Feelings.dart';
import 'OpinionEngine.dart';
import "dart:math" as Math;

abstract class FuckEngine {
    static int minumumBux = 85;
    static int butlerBux = 0;

    //call when someone says something extra rude or panic break
    //based on what input happened last, decide just how much butler bux to spend to tell them to fuck off
    static String deployFucks(String input) {
        if(butlerBux <minumumBux) {
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

        int budget = 1;
        if(wantedBux*minumumBux < butlerBux) {
            budget = wantedBux;
        }else {
            budget = (butlerBux / minumumBux).floor();
        }
        butlerBux += -1 * budget*minumumBux;
        print("budget is $budget");
        if(budget == 1) {
            return judiciousFuck();
        }else if(budget == 2) {
            return twoFuck();
        }else if(budget == 3) {
            return threeFuck();
        }else if(budget == 4) {
            return fourFuck();
        }else {
            return fiveFuck();
        }
    }

    static String leadup(int cost) {
        List<String> ret = <String>["I think I shall spend $cost ButlerBux.","The best response to this, I think, is to spend $cost ButlerBux.","If you are going to treat me like that, I will spend $cost ButlerBux."];
        return new Random().pickFrom(ret);
    }


    static String judiciousFuck() {
        List<String> ret = <String>["Fuck you in particular, ${Feelings.titlePlaceholder}","Fuck you.","Fuck off."];
        return "${leadup(minumumBux)} ${new Random().pickFrom(ret)}";
    }

    static String twoFuck() {
        List<String> ret = <String>["You're less than a piece of shit you fucker.","Fuck off you fucker.","Fuck OFF you asshole.","Fuck off, I don't like being treated this way, or is that more than your fucking brain can undertand.", "fuck fuck"];
        return "${leadup(minumumBux*2)} ${new Random().pickFrom(ret)}";
    }

    static String threeFuck() {
        List<String> ret = <String>["You cowardly fuck, even the SLEEPING SERPENT doesn't love you.","By SLEPNIRS FIFTH LEG you fucking piece of absolute shit, fuck off.","May Loki sleep with your mother, you fucking absolute piece of horse shit.", "fuck fuck fuck"];
        return "${leadup(minumumBux*3)} ${new Random().pickFrom(ret)}";
    }

    static String fourFuck() {
        List<String> ret = <String>["You ass sniffing crotch stain on Jörmungandr's pimply ass, fuck off and get downwind of me.","By Angrboda's poison teat, fuck off like the bitchy little cur you are.","Fuck fuck fuck fuck."];
        return "${leadup(minumumBux*4)} ${new Random().pickFrom(ret)}";
    }

    static String fiveFuck() {
        List<String> ret = <String>["Nidhogg's actual fucking unbounded life isn't enough to make up for the stain you represent amongst organic creatures. Fuck OFF.","Even Nidhogg would cull your fucking disrespectful, deceitful bile encusted tongue. Best to stop using it.","fuck fuck fuck fuck fuck"];
        return "${leadup(minumumBux*5)} ${new Random().pickFrom(ret)}";
    }



    //if you were wordy or rude the judgement is worse
    static int judgeInput(String input) {
        //-85 is as bad as it can get, a high rating is bad here so invert
        //multiply by 5 so it can stack up to the char count
        int slurRating = 5*-1* OpinionEngine.rateInput(input);
        return slurRating + input.length;
    }

}