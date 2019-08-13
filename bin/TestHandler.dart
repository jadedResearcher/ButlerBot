import 'TextWriter.dart';
import 'WaveWriter.dart';

abstract class TestHandler {

    static int numVisits = 0;

    static void test() {
        numVisits ++;
        print("numVisits is $numVisits");
        TextWriter.writeLocal("test.txt","$numVisits times it has worked. Does it cache?");
        print("wrote the text file");
        WaveWriter.writeLocal("test");
        print("did the wave writer");
    }
}