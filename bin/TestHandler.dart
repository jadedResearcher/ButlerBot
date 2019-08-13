import 'FFMPEGWrapper.dart';
import 'TextWriter.dart';
import 'WaveWriter.dart';

abstract class TestHandler {

    static int numVisits = 0;

    static void test() async {
        numVisits ++;
        print("numVisits is $numVisits");
        TextWriter.writeLocal("hello_butler_bot.txt","$numVisits times it has worked. Does it cache?");
        print("wrote the text file");
        await WaveWriter.writeLocal("hello_butler_bot");
        print("did the wave writing");
        await FFMPEGWrapper.convertWavToMP3AndOGG("hello_butler_bot","/var/www/html/knucklessux.com/public_html/JR/AudioLogs/Raw/");
        print("did the conversion");
    }
}