import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';
import 'package:twitter_pink/utilities/constants.dart';

class AlertWidgets{


  static accountSystemAlertWidget(BuildContext context,String errorMessage,String title){
    Alert(
      context: context,
      type: AlertType.error,
      title: title,
      desc: errorMessage,
      buttons: [
        DialogButton(
          color: mainDarkPinkColor,
          child: Text(
            "Cancel",
            style: TextStyle(color: mainwhiteColor, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }


  static successSystemAlertWidget(BuildContext context,String message,String title,String okay){
    Alert(
      context: context,
      type: AlertType.success,
      title: title,
      desc: message,
      buttons: [
        DialogButton(
          color: mainDarkPinkColor,
          child: Text(
            okay,
            style: TextStyle(color: mainwhiteColor, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }

}