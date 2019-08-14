import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'ChatBot.dart';
import 'TestHandler.dart';
import 'TextWriter.dart';

/*
Add related, reliable and real ratings in meta data.
add all the transcripts

make a route where it just gives you a list of all json files in a hash

make a dart project for k whatever. shows everything in a table

 */

Future main() async {

  var server = await HttpServer.bind(
    "0.0.0.0",
    8500,
  );
  print('Listening on localhost:${server.port}');


  await for (HttpRequest request in server) {
    request.response.headers.add("Access-Control-Allow-Origin", "*");
    request.response.headers.add("Access-Control-Allow-Methods", "POST,GET,DELETE,PUT,OPTIONS");
    if(request.uri.toString().contains("TalkButlerBot")) {
      await process(request);
    }else if(request.uri.toString().contains("JRHAXBUTITSFORAREALLYGOODPURPOSE")) {
      await ChatBot.echoInput(request.uri.queryParameters['input']);
      request.response.write("thank you for your input");
    }
    request.response.close();
  }
}


Future<Null> process(HttpRequest request) async{
  print("request url is ${request.uri}");
  await ChatBot.handleInput(request.uri.queryParameters['input']);
  request.response.write("thank you for your input");

}
