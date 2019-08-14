import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'ChatBot.dart';
import 'StatusQuery.dart';
import 'TestHandler.dart';
import 'TextWriter.dart';

/*
Add related, reliable and real ratings in meta data.
add all the transcripts

make a route where it just gives you a list of all json files in a hash

make a dart project for k whatever. shows everything in a table

 */

bool waitMode = false;
List<StatusQuery> statusQueries = new List<StatusQuery>();

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
      await processInput(request);
    }else if(request.uri.toString().contains("JRHAXBUTITSFORAREALLYGOODPURPOSE")) {
      await ChatBot.echoInput("JR",request.uri.queryParameters['input']);
      request.response.write("thank you for your input");
    }else if(request.uri.toString().contains("ChatLogHax")) {
      request.response.write(ChatBot.chatLog);
    }

    if(!request.uri.toString().contains("ResponseStatus")) {
      request.response.close();
    }else {
      //don't close yet.
      statusQueries.add(new StatusQuery(request));
    }
  }
}


Future<Null> processInput(HttpRequest request) async{
  if(waitMode) {
    request.response.write("apologies, but please wait your turn");
    return;
  }
  waitTillNewInput();
  print("request url is ${request.uri}");
  String chatHandle = request.uri.queryParameters['chatHandle'];
  if(chatHandle == null || chatHandle.isEmpty) chatHandle = "Anon";
  chatHandle = chatHandle.substring(0,min(113, chatHandle.length));
  String input = request.uri.queryParameters['input'];
  if(input == null) {
    request.response.write("apologies, but please give me valid input");
    return;
  }
  input = input.substring(0,min(500, input.length));
  await ChatBot.handleInput(chatHandle,input);
  request.response.write("thank you for your input");
  answerQueries();
}

//lets there be an async push notification about when theres new input
void answerQueries() {
  for(StatusQuery q in statusQueries) {
    q.close();
  }
  statusQueries.clear();
}

void waitTillNewInput() {
  waitMode = true;
  new Future.delayed(const Duration(seconds: 13), () => waitMode = false);
}
