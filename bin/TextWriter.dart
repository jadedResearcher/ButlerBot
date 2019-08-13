//handles writing any input to a text file at a given location relative to the server.
import 'dart:convert';
import 'dart:io';

abstract class TextWriter {

    static void writeLocal(String fileName,String contents) async {
        await File(fileName).writeAsString(contents);
    }

    /*
    {
      "keywords": "???",
      "speaker": "???",
      "gigglesnort": "An episode of Farrago Fraydio",
      "summary": "An episode of Farrago Fraydio",
        "clean":true,
      "transcript":""
    }
     */
    //just assume summary is of the form "Answer to the Question: X"
    static void writePodcastJSON(String fileName, String gigglesnort, String speaker, String summary, String transcript) async {
        final Map<dynamic, dynamic> json = new Map<dynamic,dynamic>();
        json["keywords"] = "generated";
        json["speaker"] = speaker;
        json["gigglesnort"] = gigglesnort;
        json["clean"] = true;
        json["summary"] = summary;
        json["transcript"] = transcript;
        await writeLocal(fileName, jsonEncode(json));
    }
}