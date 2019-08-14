abstract class Subject {
    static RegExp punctuationpattern = new RegExp("[.,\/#!%\^&\*;:{}=\-_`~\(\)]");

    static List<String> getProcessed(String input) {
        String processed = input.toLowerCase().replaceAll(
            punctuationpattern, " ");
        List<String> words = processed.split(" ")
            ..retainWhere((String s) => s.isNotEmpty);
        return words;
    }

    static List<String> getResponse(String subject) {

    }

    static List<String> getSubjects(String input) {
        //TODO call all your sub subjects
    }

}