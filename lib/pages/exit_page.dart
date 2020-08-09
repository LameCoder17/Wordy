import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

exitDialog(BuildContext context) {
  Widget cancelButton = FlatButton(
    child: Text(
        "No",
    ),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );
  Widget okButton = FlatButton(
    child: Text(
        "Yes",
    ),
    onPressed: () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
        "Quit",
    ),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.00)
    ),
    content: Text(
        "Are you sure you want to exit ?",
    ),
    actions: [
      cancelButton,
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}