import 'package:flutter/material.dart';
import '../utilities/constants.dart';

class CustomFlatButton extends StatelessWidget {
  final String textEnter;
  final Function onpressed;

  CustomFlatButton({Key key, this.textEnter, this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 300,
      child: TextButton(
        onPressed: onpressed,
        child: Row(
          children: [
            Text(
              textEnter,
              style: TextStyle(
                color: mainwhiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: mainwhiteColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: mainwhiteColor),
                ),
                child: Icon(Icons.arrow_forward_ios, color: mainwhiteColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
