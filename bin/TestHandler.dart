import 'dart:io';

import 'FFMPEGWrapper.dart';
import 'TextWriter.dart';
import 'WaveWriter.dart';

abstract class TestHandler {

    static int numVisits = 0;

    static void testAsyncCalls() async {
        for(int i = 0; i<4; i++) {
            print("About to test $i ${new DateTime.now()}");
            //ProcessResult ret = await Process.run('sleep', <String>["3"]);
            //print("output is: ${ret.stdout}");
            await TextWriter.writeLocal("test.txt","${new DateTime.now().hour}:${new DateTime.now().minute} o'clock. Hello World. It's working.");
            await WaveWriter.writeLocal("test");
            await FFMPEGWrapper.convertWavToMP3AndOGG("test","/var/www/html/knucklessux.com/public_html/");
            print("Done testing $i ${new DateTime.now()}");
        }

    }

    static void test() async {
        numVisits ++;
        print("numVisits is $numVisits");
        String text = "${new DateTime.now().hour}:${new DateTime.now().minute} o'clock. Hello World. It's working.";
        await TextWriter.writeLocal("hello_butler_bot.txt",text);
        print("wrote the text file");
        await WaveWriter.writeLocal("hello_butler_bot");
        print("did the wave writing");
        await FFMPEGWrapper.convertWavToMP3AndOGG("hello_butler_bot","/var/www/html/knucklessux.com/public_html/JR/AudioLogs/Raw/");
        print("did the conversion");
        //PP becomes BB
        await TextWriter.writePodcastJSON("/var/www/html/knucklessux.com/public_html/JR/AudioLogs/json/hello_butler_bot.json","Gosh I wonder why this exists??? What does it mean??? Who is speaking???","ButlerBot", "Answer to Question: How many times has this worked?", text );
        print("did the json");

    }
}