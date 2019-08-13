import 'FFMPEGWrapper.dart';
import 'TextWriter.dart';
import 'WaveWriter.dart';

abstract class TestHandler {

    static int numVisits = 0;

    static void test() async {
        numVisits ++;
        print("numVisits is $numVisits");
        String text = "$numVisits times it has worked. Does it cache?";
        await TextWriter.writeLocal("hello_butler_bot.txt",text);
        print("wrote the text file");
        await WaveWriter.writeLocal("hello_butler_bot");
        print("did the wave writing");
        await FFMPEGWrapper.convertWavToMP3AndOGG("hello_butler_bot","/var/www/html/knucklessux.com/public_html/JR/AudioLogs/Raw/");
        print("did the conversion");
        //PP becomes BB
        await TextWriter.writePodcastJSON("/var/www/html/knucklessux.com/public_html/JR/AudioLogs/json/hello_butler_bot.json","Gosh I wonder why this exists??? What does it mean??? Who is speaking???","ButtlerBot", "Answer to Question: How many times has this worked?", text );
        print("did the json");

    }
}