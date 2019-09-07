//todo integrate with pl's text engine, not just raw chat bot things (mostly if you didn't interest it)
import 'FFMPEGWrapper.dart';
import 'StatusQuery.dart';
import 'Subjects/Feelings.dart';
import 'Subjects/FuckEngine.dart';
import 'Subjects/OpinionEngine.dart';
import 'Subjects/Subject.dart';
import 'Subjects/Topic.dart';
import 'TextWriter.dart';
import 'WaveWriter.dart';
import 'package:CommonLib/Random.dart';
import 'package:CommonLib/Collection.dart';

//todo consider having vague memory so its twitch plays conversation trees

abstract class ChatBot {
    static List<StatusQuery> statusQueries = new List<StatusQuery>();

    static String chatLog = "";

    static List<String> subjects;
    static List<Topic> topics;


    //if they say more than four ee's together it should do the "you said eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee" meme
    static Future<void> handleInput(String chatHandle, String input) async {
        await Topic.initTextEngine();
        int hatred = FuckEngine.judgeInput(input);
        print("rating is $hatred");
        String text;
        if(hatred * Feelings.overwhelmedQuotient > 50) {
            text = FuckEngine.deployFucks(input);
        }else {
            text = await getOutput(input);
        }
        text = text.replaceAll(Feelings.titlePlaceholder,Feelings.getTitle());
        if(Feelings.breakStart ==  null && Feelings.lunchStart == null) {
            Feelings.activityIn15Minutes.add(input);
            Feelings.checkOverwhelmed();
            if(Feelings.breakStart != null) return; //emergency break
        }else {
        }
        FuckEngine.butlerBux ++;
        input = censor(input, OpinionEngine.veryBadWords);
        text = censor(text, OpinionEngine.veryBadWords);
        input = censor(input, OpinionEngine.mediumBad);

        updateChatLog("~~~OpinionOnInput: ${OpinionEngine.currentOpinion} to topics ${OpinionEngine.currentOpinionTopics.join(',')}~~~\n $chatHandle: ${input.replaceAll('\n',' ')}\nButlerBot: $text");
        await generateOutput("Response to ${chatHandle}'s Input: $input",text);
    }

    static String censor(String input, badWords) {
      for(String badWord in badWords) {
          input = input.replaceAll(badWord, "***");
      }
      return input;
    }

    static void updateChatLog(log){
        chatLog = "$chatLog \n\n ${DateTime.now()} \n(ButlerBux: ${FuckEngine.butlerBux}, Loneliness Quotient: ${Feelings.lonelinessQuotient}, Overwhelmed Quotient: ${Feelings.overwhelmedQuotient} )\n $log";
        print(chatLog);
    }

    static Future<void> spontaneousMessage(String summary, String text) async{
        text = text.replaceAll(Feelings.titlePlaceholder,Feelings.getTitle());
        updateChatLog("$summary: $text");
        await generateOutput(summary,text);
        answerQueries();
    }

    static Future<void> generateOutput(String summary, String text) async {
        await TextWriter.writeLocal("hello_butler_bot.txt",text);
        //everything underneat this needs turned off to run local
        await generateAudioOutput(summary, text);
    }

    static Future generateAudioOutput(String summary, String text) async {
      await WaveWriter.writeLocal("hello_butler_bot");
      await FFMPEGWrapper.convertWavToMP3AndOGG("hello_butler_bot","/var/www/html/knucklessux.com/public_html/JR/AudioLogs/Raw/");
      await TextWriter.writePodcastJSON("/var/www/html/knucklessux.com/public_html/JR/AudioLogs/json/hello_butler_bot.json","Gosh I wonder why this exists??? What does it mean??? Who is speaking???","ButlerBot", summary, text );

    }

    //lets there be an async push notification about when theres new input
    static void answerQueries() {
        for(StatusQuery q in statusQueries) {
            q.close();
        }
        statusQueries.clear();
    }

    static void echoInput(String chatHandle, String input) async {
        if(input == null) return;
        String text = "$chatHandle said: $input";
        input = censor(input, OpinionEngine.veryBadWords);
        text = censor(text, OpinionEngine.veryBadWords);
        input = censor(input, OpinionEngine.mediumBad);
        chatLog = "$chatLog \n\n $chatHandle: $input\nButlerBot: $text";
        print(chatLog);
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
        if(Feelings.breakStart != null) {
            return Feelings.breakMessage(false);
        }

        if(Feelings.lunchStart != null) {
            return Feelings.lunchMessage();
        }
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

        return ret;
    }


}