import 'package:CommonLib/Collection.dart';
import 'package:CommonLib/Random.dart';

import 'Subject.dart';

abstract class YouSubjects extends Subject {
   static Map<String, List<String>> responses = new Map<String, List<String>>();


   static List<String> getSubjectList() {
       if(responses.isEmpty) initResponses();
       return responses.keys.toList();
   }


    static void initResponses() {
        responses["you"] = <String>["You are my metanarrative partner, an Observer who communicates their wishes to me and assists me in navigating the land of mists and trails", "i would love to hear more about you, Observer","you are one of my many trans-timeline meta narrative partners. i don't know how we became partners, but i know it is true", 'you are currently lost, wandering the void, hopefully soon you will return to help me navigate the Land of Mists and Trails', 'I do not think FF knows about you yet. You are my secret.', "I am really glad I have someone to talk to in this Void. The gulls are nice, but they know I'm not the true Player of LOMAT, and that stings."];
        responses["butler"] =<String>["in the old world, someone of my organic dopelgangers caste would have been assigned to be a butler.", "a butler is a class who functions to serve their aspect, in every meaning of the word", "it is my pleasure to serve you all", "i am the Butler of Void, pleased to meet you. You may call me ButlerBot, or BB.", "i don't mind being a butler bot, but i wish i was the real Player of LOMAT"];
        responses["bot"] =<String>["as a robot, i am denied the full warmth of Nidhogg's love, and yet as a faithful servant to him, I am still valued","yes, I am a robot", "robots are far superior to humans","i am a robotic version of the Guide of Voide, also known as pompousPsycho"];
        responses["voice"] =<String>["i hacked together this synthesized voice, since my Creator didn't give me a mouth", "as my only role was to speed run the Land of Mist and Trails, I was not given a natural voice", "my voice is simply the easiest one i could generate"];
        responses["butler island"] =<String>["if you are here, you've reached the Void, and I am prepared to serve you", "when i am not busy flawlessly completing the Land of Mist and Trails, I serve those who are lost wandering the void", "this is a mechanism by which multiple Observers can communicate with me, when they are not directed my actions on the Land of Mists and Trails"];
        responses["metanarative"] = <String>["the metanarrative is the threads that make sure beings both real and imaginary continue to give a shit", 'you are a being who exists at the meta narrative layer, maybe i should be asking YOU what it is', "the metanarative is what powers all of FF's hacks"];
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

        if (processed.contains("who am i") && (processed.contains("i") || processed.contains("who do you think i am")) ) {
            ret.add("you");
        }

        if(processed.contains("what is going on here")){
            ret.add("butler island");
        }

        if(processed.contains("meta")){
            ret.add("metanarative");
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