import 'TextWriter.dart';
import 'WaveWriter.dart';

abstract class TestHandler {

    static int numVisits = 0;

    static void test() {
        numVisits ++;
        TextWriter.writeLocal("test.txt","Great Scott! It's working, JR!!! Its worked $numVisits times! ");
        WaveWriter.writeLocal("test");
    }
}