//handles writing any input to a text file at a given location relative to the server.
import 'dart:io';

abstract class TextWriter {

    static void writeLocal(String fileName,String contents) async {
        await File(fileName).writeAsString(contents);
    }

}