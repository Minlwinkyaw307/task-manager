
import 'package:vibration/vibration.dart';

Future<void> vibrate(int duration, int amplitude) async{
  Vibration.hasCustomVibrationsSupport().then((result){
    if(result){
      Vibration.hasAmplitudeControl().then((res){
        if(res){
          Vibration.vibrate(amplitude: amplitude, duration: duration);
        }else{
          Vibration.vibrate(duration: duration);
        }
      });
    }
  }).catchError((err) {
    print("Got Error - ${err.toString()}");
  });
}