import 'package:CommonLib/Collection.dart';
import 'package:CommonLib/Random.dart';

import 'Subject.dart';

abstract class YouSubjects extends Subject {
   static Map<String, List<String>> responses = new Map<String, List<String>>();

    static void initResponses() {
        responses["creator"] =<String>["FF made me to help LOMAT be completed on schedule", "Despap Citato made technology to help all the Players complete their lands on schedule, including me.","FF designed me to use your input to better complete LOMAT."];
        responses["you"] = <String>["You are my metanarrative partner, an Observer who communicates their wishes to me and assists me in navigating the land of mists and trails", "i would love to hear more about you, Observer","you are one of my many trans-timeline meta narrative partners. i don't know how we became partners, but i know it is true", 'you are currently lost, wandering the void, hopefully soon you will return to help me navigate the Land of Mists and Trails', 'I do not think FF knows about you yet. You are my secret.', "I am really glad I have someone to talk to in this Void. The gulls are nice, but they know I'm not the true Player of LOMAT, and that stings."];
        responses["me"] =<String>["It seems you have asked about PP's automatic victory assuring robotic doppelganger.. This is an installation designed to surpass PP's entirely abysmal motivation, competance, intelligence, personality, and substance of character while he is away drinking ill advised honey based soda products. The algorithms are guaranteed to be ${90+new Random().nextDoubleRange(0,10)}% distinguishable from PP's native neurological responses, based on some statistical analysis I basically just pulled out of my ass right now.","i am just a humble butler bot. i buttle.","i am a superior replica of the Guide of Void, who refuses to play his own game.", "i am a metanarrative hacking device created by FF to succesfully play the Land of Mists and Trails.", "i am the robotic player of the land of mists and trails, it has defined me since my inception, in a very real sense, i am the land of mist and trails"];
        responses["butler"] =<String>["in the old world, someone of my organic dopelgangers caste would have been assigned to be a butler.", "a butler is a class who functions to serve their aspect, in every meaning of the word", "it is my pleasure to serve you all", "i am the Butler of Void, pleased to meet you. You may call me ButlerBot, or BB.", "i don't mind being a butler bot, but i wish i was the real Player of LOMAT"];
        responses["bot"] =<String>["yes, I am a robot", "robots are far superior to humans","i am a robotic version of the Guide of Voide, also known as pompousPsycho"];
        responses["voice"] =<String>["i hacked together this synthesized voice, since my Creator didn't give me a mouth", "as my only role was to speed run the Land of Mist and Trails, I was not given a natural voice", "my voice is simply the easiest one i could generate"];
        responses["butler island"] =<String>["if you are here, you've reached the Void, and I am prepared to serve you", "when i am not busy flawlessly completing the Land of Mist and Trails, I serve those who are lost wandering the void", "this is a mechanism by which multiple Observers can communicate with me, when they are not directed my actions on the Land of Mists and Trails"];

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

        if (processed.contains("who") && (processed.contains("you") || processed.contains("butler") || processed.contains("bot"))) {
            ret.add("me");
        }

        if (processed.contains("who") && (processed.contains("i") || processed.contains("me")) ) {
            ret.add("you");
        }

        if(processed.contains("what is going on here")){
            ret.add("butler island");
        }

        if (processed.contains("creat") || processed.contains("FF") || processed.contains("Despap") || processed.contains("foreverFon") || processed.contains("admin")) {
            ret.add("creator");
        }

        if (processed.contains("butler") || processed.contains("maid") || processed.contains("serve")) {
            ret.add("butler");
        }

        if (processed.contains("voice") || processed.contains("sound") || processed.contains("talk") || processed.contains("speak")) {
            ret.add("voice");
        }

        if (processed.contains("bot") || processed.contains("artificial") || processed.contains("metal") ||processed.contains("droid") ) {
            ret.add("bot");
        }

        return ret;
    }
}