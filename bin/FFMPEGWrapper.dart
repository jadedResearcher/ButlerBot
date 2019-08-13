//handles transcoding
import 'dart:io';
/* examples from magic spells:
  ffmpeg -i $f ${fileName}.m4a
ffmpeg -i $f -acodec libvorbis ${fileName}.ogg
  ffmpeg -i $f  ${fileName}.mp3
 */
abstract class FFMPEGWrapper {

    //mostly used for podcast engine (makes them then moves them) (wav will come from festival text2Wave
    static void convertWavToMP3AndOGG(String fileName, String finalLocation) async {
        Future<ProcessResult> p1 =  Process.run('ffmpeg', <String>["-i","-nostdin", "-y", "$fileName.wav","-acodec", "libvorbis","${finalLocation}${fileName}.ogg"]);
        Future<ProcessResult> p2 = Process.run('ffmpeg', <String>["-i","-nostdin", "-y","$fileName.wav","${finalLocation}${fileName}.mp3"]);
        //that lets them run in parallel and waits for them all to be done (order agnostic)
        await Future.wait<ProcessResult>( <Future<ProcessResult>>[p1,p2]);
        return;

    }

}