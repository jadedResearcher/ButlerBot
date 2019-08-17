//todo integrate with pl's text engine, not just raw chat bot things (mostly if you didn't interest it)
import 'FFMPEGWrapper.dart';
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

    //if they say more than four ee's together it should do the "you said eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee" meme
    static void handleInput(String chatHandle, String input) async {
        await Topic.initTextEngine();
        new Topic("test");
        String text = await getOutput(input);
        text = "${Topic.allTopics["test"].response()} $text";
        chatLog = "$chatLog \n\n ${DateTime.now()} $chatHandle: $input\nButlerBot: $text";
        await TextWriter.writeLocal("hello_butler_bot.txt",text);
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

    static String getSubjectPhrase(String subject) {
        WeightedList<String> choices = new WeightedList<String>();
        choices.add("it seems you have asked about $subject. ", 3.0);
        choices.add("do you mean $subject? ", 1.0);
        choices.add("", 13);
        choices.add("we are now talking about $subject.", 0.5);
        choices.add("the ALL FATHER allows me to speak of $subject", 0.3);
        choices.add("my SYSADMIN allows me to speak of $subject", 0.3);
        Random rand = new Random();
        return rand.pickFrom(choices);
    }

    static Future<String> getOutput(String input) async {
        //first establish the subject(s). then, get responses for that subject.
        //only say up to 5 responses at a time , no matter how many subjects
        subjects = Subject.getSubjects(input);
        int responses = 0;
        int maxResponses = 3;
        String ret = "";
        if(subjects.isEmpty) ret = (Subject.getConfusedPhrase(input));
        for(String subject in subjects) {
            if(responses > maxResponses) {
                break;
            }
            responses ++;
            if(responses > 1) {
                ret = "$ret ${getJoiningWord()}, ${getSubjectPhrase(subject)} ${Subject
                    .getResponse(subject)}";
            }else {
                ret = "${getSubjectPhrase(subject)} ${Subject
                    .getResponse(subject)}";
            }
        }
        return ret;
    }


}