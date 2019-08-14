import 'Subject.dart';

abstract class SecretSubjects extends Subject {
    static List<String> getSubjects(String input) {
        List<String> processed = Subject.getProcessed(input);
        List<String> ret = new List<String>();

        if (processed.contains("better than expected") ||
            processed.contains("[???]") || processed.contains("???")) {
            ret.add( "[???]");
        }
        if (processed.contains("better than expected") || processed.contains("[???]") || processed.contains("???")) {
            ret.add("[???]");
        }

        if (processed.contains("loras") || processed.contains("janus") || processed.contains("rods")) {
            ret.add("loras");
        }

        if (processed.contains("who is shogun")) {
            ret.add("shogun");
        }

        if (processed.contains("jr") || processed.contains("jadedResearcher") || processed.contains("waste of mind") || processed.contains("junior")) {
            ret.add("jr");
        }
        return ret;
    }
}