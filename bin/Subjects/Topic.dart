import 'dart:io';
import 'dart:math';

import 'package:TextEngine/TextEngine.dart';

import 'OpinionEngine.dart';

/*
textengine file name
text engine header name for likes
text engine header name for neutral
text engine header name for dislikes (all three can be the same)
integer value between -85 and 85 representing how much he currently likes the subject.
 */

/*
    TODO: topic list
    underlings
    gulls
    beavers
    trees
 */

class Topic {
    static Map<String, Topic> allTopics = new Map<String,Topic>();
    static String textEngineFileName = "topicResponses";
    String topicName;
    List<String> keywords;
    String get likeHeader => "${topicName}Like";
    String get neutralHeader => "${topicName}Neutral";
    String get dislikeHeader => "${topicName}Dislike";
    static int maxOpinion = 85;
    static int minOpinion = -85;
    static TextEngine textEngine;
    int _rating = 0; //every time guide bot restarts he gets amnesia
    int get rating => max(min(maxOpinion, _rating),minOpinion);

    static RegExp punctuationpattern = new RegExp("[.,\/#!%\^&\*;:{}=\-_`~\(\)]");

    static List<Topic> getTopics(String input) {
        List<Topic> ret = new List<Topic>();
        String newInput = getProcessed(input);
        for(Topic topic in allTopics.values) {
            if(topic.inputIsHit(newInput)) {
                ret.add(topic);
            }
        }
        return ret;
    }

    static int formOpinions(List<Topic> topics, String input) {
        int rating = OpinionEngine.rateInput(input);
        if(topics.isNotEmpty) {
            topics.forEach((Topic topic) => topic.changeOpinionByAmount(rating));
        }else {
            //no topic chosen, oh well, looks like we're applying it in tiny form across the board
            allTopics.values.forEach((Topic topic) => topic.changeOpinionByAmount((rating/allTopics.values.length).ceil()));
        }
        OpinionEngine.currentOpinion = rating;
        OpinionEngine.currentOpinionTopics = topics;
        return rating;
    }

    static String getProcessed(String input) {
        return input.toLowerCase().replaceAll(
            punctuationpattern, " ");
    }

    static void initTextEngine() async {
        textEngine = new TextEngine(null,"${Uri.file(Directory.current.path).toFilePath()}/bin/wordlists");
        await textEngine.loadList(textEngineFileName);
    }

    Topic(String this.topicName, List<String> this.keywords) {
        allTopics[topicName] = this;
    }

    void changeOpinionByAmount(int amount) {
        //important, it means even the true _rating doesn't get much above/below 85
        _rating = rating + amount;
    }

    bool inputIsHit(String input) {
        for(String word in keywords) {
            if(input.contains(word)) return true;
        }
        return false;
    }

    String  response() {
        if(rating > maxOpinion/2) {
            return textEngine.phrase(likeHeader);
        }else if(rating < minOpinion/2) {
            return textEngine.phrase(dislikeHeader);
        }else {
            return textEngine.phrase(neutralHeader);
        }
    }

    String toString() => "[$topicName: $rating]";

    static void initTopics() {
        OpinionEngine.initOpinions();
        new Topic("test", ["test"]);
        new Topic("bug", ["monster","underling","bug","caterpillar","butterfly","moth","insect","ant","worm","larva","maggot"]);

    }

}
