import 'package:TextEngine/TextEngine.dart';

/*
textengine file name
text engine header name for likes
text engine header name for neutral
text engine header name for dislikes (all three can be the same)
integer value between -85 and 85 representing how much he currently likes the subject.
 */

/*
    TODO: actually wire this in along side subjects (erase subjects as you mimik them)
 */
class Topic {
    static Map<String, Topic> allTopics = new Map<String,Topic>();
    static String textEngineFileName = "indepth_topics";
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
        textEngine = new TextEngine();
        await textEngine.loadList(textEngineFileName);
    }

    Topic(String this.topicName) {
        allTopics[topicName] = this;
    }

    String  response() {
        if(opinion > maxOpinion/2) {
            return textEngine.phrase(likeHeader);
        }else if(opinion < maxOpinion/2) {
            return textEngine.phrase(dislikeHeader);
        }else {
            return textEngine.phrase(neutralHeader);
        }
    }



}