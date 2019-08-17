import 'dart:io';

import 'package:TextEngine/TextEngine.dart';

/*
textengine file name
text engine header name for likes
text engine header name for neutral
text engine header name for dislikes (all three can be the same)
integer value between -85 and 85 representing how much he currently likes the subject.
 */

/*
    TODO take in a list of keywords too
    TODO text engine can't actually work server side because it uses logger and the loader lib extensively uses dart:html
 */

class Topic {
    static Map<String, Topic> allTopics = new Map<String,Topic>();
    static String textEngineFileName = "topicResponses";
    String topicName;
    String get likeHeader => "${topicName}Like";
    String get neutralHeader => "${topicName}Neutral";
    String get dislikeHeader => "${topicName}Dislike";
    static int maxOpinion = 85;
    static int minOpinion = -85;
    static TextEngine textEngine;
    int opinion = 0; //every time guide bot restarts he gets amnesia

    static RegExp punctuationpattern = new RegExp("[.,\/#!%\^&\*;:{}=\-_`~\(\)]");

    static String getProcessed(String input) {
        return input.toLowerCase().replaceAll(
            punctuationpattern, " ");
    }

    static void initTextEngine() async {
        textEngine = new TextEngine(null,"${Uri.file(Directory.current.path).toFilePath()}/bin/wordlists");
        await textEngine.loadList(textEngineFileName);
    }

    Topic(String this.topicName) {
        allTopics[topicName] = this;
    }

    String  response() {
        if(opinion > maxOpinion/2) {
            return textEngine.phrase(likeHeader);
        }else if(opinion < minOpinion/2) {
            return textEngine.phrase(dislikeHeader);
        }else {
            return textEngine.phrase(neutralHeader);
        }
    }



}
