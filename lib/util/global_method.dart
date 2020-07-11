import 'package:flutter/material.dart';
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

void confirmAlertDialog(BuildContext context, String title, String body,
    Function onCancel, Function onAccept) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed: () => onCancel(),
  );
  Widget continueButton = FlatButton(
    child: Text("Confirm"),
    onPressed: () => onAccept(),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(body),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}