//todo integrate with pl's text engine, not just raw chat bot things (mostly if you didn't interest it)
import 'FFMPEGWrapper.dart';
import 'Subjects/Subject.dart';
import 'TextWriter.dart';
import 'WaveWriter.dart';
import 'package:CommonLib/Random.dart';
import 'package:CommonLib/Collection.dart';

abstract class ChatBot {

    //if they say more than four ee's together it should do the "you said eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee" meme
    static void handleInput(String input) async {
        String text = await getOutput(input);
        await TextWriter.writeLocal("hello_butler_bot.txt",text);
        await WaveWriter.writeLocal("hello_butler_bot");
        await FFMPEGWrapper.convertWavToMP3AndOGG("hello_butler_bot","/var/www/html/knucklessux.com/public_html/JR/AudioLogs/Raw/");
        await TextWriter.writePodcastJSON("/var/www/html/knucklessux.com/public_html/JR/AudioLogs/json/hello_butler_bot.json","Gosh I wonder why this exists??? What does it mean??? Who is speaking???","ButlerBot", "Response to Input: $input", text );
    }

    static void echoInput(String input) async {
        String text = input;
        await TextWriter.writeLocal("hello_butler_bot.txt",text);
        await WaveWriter.writeLocal("hello_butler_bot");
        await FFMPEGWrapper.convertWavToMP3AndOGG("hello_butler_bot","/var/www/html/knucklessux.com/public_html/JR/AudioLogs/Raw/");
        await TextWriter.writePodcastJSON("/var/www/html/knucklessux.com/public_html/JR/AudioLogs/json/hello_butler_bot.json","Gosh I wonder why this exists??? What does it mean??? Who is speaking???","ButlerBot", "Response to Input: $input", text );
    }

    static String getJoiningWord() {
        WeightedList<String> choices = new WeightedList<String>();
        choices.add("Also", 1.0);
        choices.add("", 3.0);
        choices.add("Furthermore", 0.3);
        choices.add("Additionally", 1.0);
        choices.add("Morever", 0.3);
    }

    static String getSubjectPhrase(String subject) {
        WeightedList<String> choices = new WeightedList<String>();
        choices.add("It seems you have asked about $subject. ", 3.0);
        choices.add("Do you mean $subject? ", 1.0);
        choices.add("", 13);
        choices.add("We are now talking about $subject.", 0.5);
        choices.add("The ALL FATHER allows me to speak of $subject", 0.3);
    }

    static Future<String> getOutput(String input) async {
        //TODO first establish the subject(s). then, get responses for that subject.
        //TODO only say up to 5 responses at a time , no matter how many subjects
        List<String> subjects = Subject.getSubjects(input);
        int responses = 0;
        int maxResponses = 5;
        String ret = "";
        for(String subject in subjects) {
            if(responses > maxResponses) {
                break;
            }
            //TODO add a joining word here
            responses ++;
            if(responses > 1) {
                ret = "$ret ${getJoiningWord()}, ${getSubjectPhrase()} ${Subject
                    .getResponse(subject)}";
            }else {
                ret = "${getSubjectPhrase(subject)} ${Subject
                    .getResponse(subject)}";
            }
        }
        return ret;
    }


}