//be can feel lonely or overwhelmed, and can have feelings about the player
//if bb has a feeling about a TOPIC, its kept in the topic
import 'Suspicion.dart';
//todo if lonely, bb might talk to himself (one message an hour) things like "is anyone there?"
abstract class Feelings {

    static final String titlePlaceholder = "<INSERT_TITLE_HERE>";
    //does what it says on the tin
    int timeSinceLastMessage = 0;
    //how many messages per 15 minutes?
    int messageDensity = 1;
    static List<Suspicion> all_suspicions = new List<Suspicion>();

    static String getTitle() {
        //TODO go through all suspicians. pick the highest one over a threshold and use that title
        return "Observer";
    }

}