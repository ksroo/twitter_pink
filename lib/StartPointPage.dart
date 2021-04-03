import 'package:flutter/material.dart';
import './widgets/customFlatButton.dart';
import 'pages/registerAccountPage.dart';
import 'utilities/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'pages/loginPage.dart';

class StartPoint extends StatefulWidget {
  static const routeName = '/StartPoint';
  @override
  _StartPointState createState() => _StartPointState();
}

class _StartPointState extends State<StartPoint> {
  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [
            0.1,
            0.5,
            0.7,
          ],
          colors: [
            mainDarkPinkColor,
            mainLightPinkColor,
            mainMoreDarkColor,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.dove,
                    color: mainwhiteColor,
                    size: 60,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "TwitterPink",
                    style: TextStyle(
                      fontSize: 20,
                      color: mainwhiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                width: sizeWidth * 0.60,
                height: sizeHeight * 0.30,
                child: Center(
                  child: Text(
                    "See what's Happening in the world right now.",
                    style: TextStyle(
                      fontSize: 30,
                      color: mainwhiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  CustomFlatButton(
                    textEnter: "Login to TwitterPink",
                    onpressed: () {
                      Navigator.of(context).pushNamed(LoginPage.routeName);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomFlatButton(
                    textEnter: "Create New Account",
                    onpressed: () {
                      Navigator.of(context)
                          .pushNamed(RegisterAccountPage.routeName);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
