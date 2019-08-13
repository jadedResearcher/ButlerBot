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
        Process pwd =  await Process.start('ffmpeg', <String>["-i","-nostdin", "-y", "$fileName.wav","-acodec", "libvorbis","${finalLocation}${fileName}.ogg"]);
        Process pwd2 =  await Process.start('ffmpeg', <String>["-i","-nostdin", "-y","$fileName.wav","${finalLocation}${fileName}.mp3"]);
        await pwd.exitCode;
        await pwd2.exitCode;
        return;

    }

}