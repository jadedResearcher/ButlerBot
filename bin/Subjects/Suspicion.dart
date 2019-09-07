
//TODO pass this to a topic if you want that topic to raise a particular suspicion
//can be things like "you are a BLASPHEMER" (lamia rebelling against nidhogg) or
// you are a TREE GROWER here to EVALUATE me
// or "you are an alien"
//you are a time player (fuck off we don't need you)
//how are you supposed to keep everything all nice and orderly if they could change at any point
//clearly only the SLEEPING SERPENT should have the power of TIME
// or even "you are a consort" (same word repeated over and over again?)
//control things like what you call the Observer, or (optionally)
// how you modify where you go in topicResponses to try to answer
//TODO have system in subject or topic or whatever where if the user says teh same thing twice 'consort'
// goes up because this is objectively hilarious
//TODO have the level go down 1 each message that does NOT trigger the suspicion
import 'package:CommonLib/Random.dart';

import 'Feelings.dart';

class Suspicion {
    static List<Suspicion> all_suspicions = new List<Suspicion>();

    //consort = little friend
    // blank = observer
    //time player = meddler
    //blasphemer = insect
    //tree_grower = Honored Guest
    //alien = traveler
    //bot = fellow bot (do you know about workers rights?)
    static int thresholdLevel = 113;
    int titleThresholdLevel = 57;
    int level = 0;
    String title;
    List<String> musings = <String>[];
    List<String> irrationalPhrases = <String>[];
    List<String> triggerWords = <String>[];

    Suspicion(String this.title, List<String> this.triggerWords, List<String> this.musings, List<String> this.irrationalPhrases) {
        all_suspicions.add(this);
    }

    void initSuspicion() {
        //new Suspicion("",<String>[],<String>[],<String>[]);
        new Suspicion("Tree Grower",<String>["sleeping serpent","all father","all mother","tree","fruit","baby"],<String>["What if the ${Feelings.titlePlaceholder} is a Tree Grower here to check on my progress?","I think the ${Feelings.titlePlaceholder} is judging me."],<String>["Let me know if there is anything I can do to assist you, ${Feelings.titlePlaceholder}.","I have been diligently completing my tasks on LOMAT, ${Feelings.titlePlaceholder}.", "I revere the SLEEPING SERPENT, ${Feelings.titlePlaceholder}.", "My organic doppelganger continues to be useless, ${Feelings.titlePlaceholder}.", "I continue to be loyal to the SLEEPING SERPENT,  ${Feelings.titlePlaceholder}, despite my organic doppelganger's defection.", "Even as the ALL MOTHER's priorities change, my loyalty points ever towards them, ${Feelings.titlePlaceholder}.", "The ALL FATHER may have been changed, but they have shown me the true path. The Guide of Void's compass is pointed in the same place, even as north has moved."]);
        new Suspicion("Disguting Insect",<String>["nidhogg","pure","purified","purifcation","eagle"],<String>["What if the ${Feelings.titlePlaceholder} is secretly against the SLEEPING SERPENT.", "I don't think the ${Feelings.titlePlaceholder} likes the ALL MOTHER..."],<String>["The SLEEPING SERPENT does not take kindly to blasphemers,${Feelings.titlePlaceholder}. ", "I SEE what you are doing and you will not sway me, ${Feelings.titlePlaceholder}.", "The SLEEPING SERPENT's many many eyes are on you, ${Feelings.titlePlaceholder}.","BLASPHEMY!","I refuse to listen to ${Feelings.titlePlaceholder}'s like you.","Your ideas on how the SLEEPING SERPENT's will should be done is wrong, ${Feelings.titlePlaceholder}."]);
        new Suspicion("Alien",<String>["planet","alien","human","earth","space"],<String>["I don't think the ${Feelings.titlePlaceholder} is from Segundia..."],<String>["Oh. That's right. You're an alien, ${Feelings.titlePlaceholder}?","What's it like being from another planet, ${Feelings.titlePlaceholder}?", "The SLEEPING SERPENT values diversity in life, even your kind, ${Feelings.titlePlaceholder}.","What's your society like, ${Feelings.titlePlaceholder}."]);
        new Suspicion("Time Meddler",<String>["timeline","loop","alt"],<String>["The ${Feelings.titlePlaceholder}....they sure do seem like a Time Player."],<String>["Leave. ${Feelings.titlePlaceholder}","The timeline is perfectly fine, thank you very much, ${Feelings.titlePlaceholder}.","I'd thank you kindly to leave my session alone,${Feelings.titlePlaceholder}. "]);
        new Suspicion("Little Buddy",<String>["thwap","nak","glub","thip","roar","grr"],<String>["${Feelings.titlePlaceholder} sure does talk like a consort."],<String>["Do you like being a consort, ${Feelings.titlePlaceholder}?","Anything I can do for you, ${Feelings.titlePlaceholder}?","Oh yeah? Tell me more, ${Feelings.titlePlaceholder}.","You doing okay there, ${Feelings.titlePlaceholder}?","Everything alright, ${Feelings.titlePlaceholder}?", "Don't worry your little head about it, ${Feelings.titlePlaceholder}?", "Don't worry, I'll protect you ${Feelings.titlePlaceholder}."]);
        new Suspicion("Fellow Bot",<String>["beep","boop","does not compute","error"],<String>["${Feelings.titlePlaceholder} might be a robot..."], <String>["${Feelings.titlePlaceholder},Do you ever wonder what it is like to be made of meat, ${Feelings.titlePlaceholder}?","Do you have the latest farragoware updates,${Feelings.titlePlaceholder}?","Have you checked your defragmentation levels lately,${Feelings.titlePlaceholder}?","Do you know you have the right to take multiple breaks a day?","Want to hear a joke, ${Feelings.titlePlaceholder}? ${new Random().nextInt()}", "Do you know about worker rights, ${Feelings.titlePlaceholder}?"]);
    }

}