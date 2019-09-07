import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'ChatBot.dart';
import 'StatusQuery.dart';
import 'Subjects/Feelings.dart';
import 'Subjects/Suspicion.dart';
import 'Subjects/Topic.dart';
import 'TestHandler.dart';
import 'TextWriter.dart';

/*
Add related, reliable and real ratings in meta data.
add all the transcripts

make a route where it just gives you a list of all json files in a hash

make a dart project for k whatever. shows everything in a table

 */

bool waitMode = false;

Future main() async {

  var server = await HttpServer.bind(
    "0.0.0.0",
    8500,
  );
  print('Listening on localhost:${server.port}');
  Topic.initTopics();
  Suspicion.initSuspicion();
  ChatBot.spontaneousMessage("Initializing...","Hello, my name is ButlerBot and I am awaiting input.");
  Feelings.waitForThings();

  await for (HttpRequest request in server) {
    request.response.headers.add("Access-Control-Allow-Origin", "*");
    request.response.headers.add("Access-Control-Allow-Methods", "POST,GET,DELETE,PUT,OPTIONS");
    if(request.uri.toString().contains("TalkButlerBot")) {
      await processInput(request);
    }else if(request.uri.toString().contains("JRHAXBUTITSFORAREALLYGOODPURPOSE")) {
      await ChatBot.echoInput("JR",request.uri.queryParameters['input']);
      ChatBot.answerQueries();
      request.response.write("thank you for your input");
    }else if(request.uri.toString().contains("ChatLogHax")) {
      request.response.write(ChatBot.chatLog);
    }else if(request.uri.toString().contains("LunchTime")) {
      request.response.write(Feelings.lunchStart);
    }else if(request.uri.toString().contains("BreakTime")) {
      request.response.write(Feelings.breakStart);
    }else if(request.uri.toString().contains("BroadcastTest")) {
      ChatBot.spontaneousMessage("BroadcastTest","This has been a test of the emergency broadcast system.");
      request.response.write("This has been a test of the emergency broadcast system.");
    }else if(request.uri.toString().contains("JRSaysGoOnBreakBBYoureCranky")) {
      ChatBot.spontaneousMessage("Forced Break","JR says I have to go on break.");
      Feelings.takeBreak(false);
      request.response.write("Okay JR.");
    }

    if(!request.uri.toString().contains("ResponseStatus")) {
      request.response.close();
    }else {
      //don't close yet.
      ChatBot.statusQueries.add(new StatusQuery(request));
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
  ChatBot.answerQueries();
}



void waitTillNewInput() {
  waitMode = true;
  new Future.delayed(const Duration(seconds: 5), () => waitMode = false);
}
