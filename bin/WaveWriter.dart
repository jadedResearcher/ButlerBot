//handles reading from a text file and writing to a wav file
import 'dart:io';

abstract class WaveWriter {

    static void writeLocal(String fileName) async {
        Process pwd =  await Process.start('text2wave', <String>["$fileName.txt","-o","$fileName.wav"]);
        return;
    }

}