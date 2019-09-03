
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
import 'Feelings.dart';

class Suspicion {
    //consort = little friend
    // blank = observer
    //time player = meddler
    //blasphemer = insect
    //tree_grower = Honored Guest
    //alien = traveler
    //bot = fellow bot (do you know about workers rights?)
    static int thresholdLevel = 113;
    int level = 0;
    String title;
    String textEngineModifier;
    Suspicion(String this.title, [String this.textEngineModifier]) {
        Feelings.all_suspicions.add(this);
    }

}