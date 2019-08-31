//todo integrate with pl's text engine, not just raw chat bot things (mostly if you didn't interest it)
import 'FFMPEGWrapper.dart';
import 'Subjects/Feelings.dart';
import 'Subjects/OpinionEngine.dart';
import 'Subjects/Subject.dart';
import 'Subjects/Topic.dart';
import 'TextWriter.dart';
import 'WaveWriter.dart';
import 'package:CommonLib/Random.dart';
import 'package:CommonLib/Collection.dart';

//todo consider having vague memory so its twitch plays conversation trees

abstract class ChatBot {

    static String chatLog = "";

    static List<String> subjects;
    static List<Topic> topics;

    //if they say more than four ee's together it should do the "you said eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee" meme
    static void handleInput(String chatHandle, String input) async {
        await Topic.initTextEngine();
        String text = await getOutput(input);
        chatLog = "$chatLog \n\n ${DateTime.now()} \n~~~OpinionOnInput: ${OpinionEngine.currentOpinion} to topics ${OpinionEngine.currentOpinionTopics.join(',')}~~~\n $chatHandle: ${input.replaceAll('\n',' ')}\nButlerBot: $text";
        await TextWriter.writeLocal("hello_butler_bot.txt",text);
        //TODO turn back on
        //await WaveWriter.writeLocal("hello_butler_bot");
        //await FFMPEGWrapper.convertWavToMP3AndOGG("hello_butler_bot","/var/www/html/knucklessux.com/public_html/JR/AudioLogs/Raw/");
        //await TextWriter.writePodcastJSON("/var/www/html/knucklessux.com/public_html/JR/AudioLogs/json/hello_butler_bot.json","Gosh I wonder why this exists??? What does it mean??? Who is speaking???","ButlerBot", "Response to ${chatHandle}'s Input: $input", text );
        print("chatLog is: $chatLog");
    }

    static void echoInput(String chatHandle, String input) async {
        String text = "$chatHandle said: $input";
        chatLog = "$chatLog \n\n $chatHandle: $input\nButlerBot: $text";
        await TextWriter.writeLocal("hello_butler_bot.txt",text);
        await WaveWriter.writeLocal("hello_butler_bot");
        await FFMPEGWrapper.convertWavToMP3AndOGG("hello_butler_bot","/var/www/html/knucklessux.com/public_html/JR/AudioLogs/Raw/");
        await TextWriter.writePodcastJSON("/var/www/html/knucklessux.com/public_html/JR/AudioLogs/json/hello_butler_bot.json","Gosh I wonder why this exists??? What does it mean??? Who is speaking??? How would you get it to change what it says? Is it the farragnarok void, maybe? Subjects detected are: ${subjects.join(",")}","ButlerBot", "Response to Input: $input", text );
    }

    static String getJoiningWord() {
        WeightedList<String> choices = new WeightedList<String>();
        choices.add("also", 1.0);
        choices.add("", 3.0);
        choices.add("furthermore", 0.3);
        choices.add("additionally", 1.0);
        choices.add("morever", 0.3);
        choices.add("incidentally", 0.3);
        choices.add("btw", 0.9);
        Random rand = new Random();
        return rand.pickFrom(choices);
    }


    static Future<String> getOutput(String input) async {
        //first establish the subject(s). then, get responses for that subject.
        //only say up to 5 responses at a time , no matter how many subjects
        subjects = Subject.getSubjects(input);
        topics = Topic.getTopics(input);
        int opinion = Topic.formOpinions(topics, input);
        int responses = 0;
        int maxResponses = 3;
        String ret = "";
        if(subjects.isEmpty && topics.isEmpty) ret = (Subject.getConfusedPhrase(input));

        for(Topic topic in topics) {
            if(responses > maxResponses) {
                break;
            }
            responses ++;
            if(responses > 1) {
                ret = "$ret ${getJoiningWord()}, ${topic.response()}";
            }else {
                ret = "${topic.response()}";
            }
        }

        for(String subject in subjects) {
            if(responses > maxResponses) {
                break;
            }
            responses ++;
            if(responses > 1) {
                ret = "$ret ${getJoiningWord()}, ${Subject
                    .getResponse(subject)}";
            }else {
                ret = "${Subject
                    .getResponse(subject)}";
            }
        }

        return ret.replaceAll(Feelings.titlePlaceholder,Feelings.getTitle());
    }


}