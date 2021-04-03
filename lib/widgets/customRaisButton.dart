import 'package:flutter/material.dart';
import '../utilities/constants.dart';

class CustomRaisButton extends StatelessWidget {
  final String textLoginOrSinUp;
  final Function onpressed;
  final TextStyle textStyle;

  CustomRaisButton({this.textLoginOrSinUp, this.onpressed,this.textStyle});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: mainDarkPinkColor,
      child: Text(
        textLoginOrSinUp,
        style: TextStyle(
            color: mainwhiteColor, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      onPressed: onpressed,
    );
  }
}
