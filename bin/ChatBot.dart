//todo integrate with pl's text engine, not just raw chat bot things (mostly if you didn't interest it)
import 'FFMPEGWrapper.dart';
import 'TextWriter.dart';
import 'WaveWriter.dart';

abstract class ChatBot {

    static void handleInput(String input) async {
        String text = await getOutput(input);
        await TextWriter.writeLocal("hello_butler_bot.txt",text);
        await WaveWriter.writeLocal("hello_butler_bot");
        await FFMPEGWrapper.convertWavToMP3AndOGG("hello_butler_bot","/var/www/html/knucklessux.com/public_html/JR/AudioLogs/Raw/");
        await TextWriter.writePodcastJSON("/var/www/html/knucklessux.com/public_html/JR/AudioLogs/json/hello_butler_bot.json","Gosh I wonder why this exists??? What does it mean??? Who is speaking???","ButlerBot", "Response to Input: $input", text );
    }

    static Future<String> getOutput(String input) async {
        return "You said: $input";
    }

}