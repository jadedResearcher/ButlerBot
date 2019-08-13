//handles reading from a text file and writing to a wav file
import 'dart:io';

abstract class WaveWriter {

    static void writeLocal(String fileName) async {
        //Process.run waits for it to be over, start lets you wait for its end seperate (and pass inputs) run returns ProcessResult
        await Process.run('text2wave', <String>["$fileName.txt","-o","$fileName.wav"]);
        return;
    }

}