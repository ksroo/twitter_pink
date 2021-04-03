import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:twitter_pink/widgets/navigationBar.dart';
import '../widgets/alertWidgets.dart';
import '../sharedPref//sharedPref.dart';

import '../pages/homePage.dart';

import '../widgets/customFlatButton.dart';
import '../widgets/customRaisButton.dart';
import '../widgets/customInputTextField.dart';
import 'registerAccountPage.dart';
import '../utilities/constants.dart';


class LoginPage extends StatefulWidget {
  static const routeName = '/LoginPage';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: mainwhiteColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                width: 400,
                height: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "Login to your Account, Now",
                        style: TextStyle(
                          fontSize: 24,
                          color: mainDarkPinkColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    CustomInputTextField(
                      hintText: 'Enter Your Email',
                      secure: false,
                      controller: _emailController,
                    ),
                    CustomInputTextField(
                      hintText: 'Password',
                      secure: true,
                      controller: _passwordController,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    CustomRaisButton(
                      textLoginOrSinUp: "Login",
                      onpressed: () {
                        // Api Login account herr *****
                        loginAccount();
                      // Navigator.pushReplacementNamed(context, HomePage.routeName);

                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: Text(
                        "Forget Password",
                        style: TextStyle(
                            fontSize: 18,
                            color: mainDarkPinkColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
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
        ),
      ),
    );
  }

  Future loginAccount() async {
    var url = Uri.parse(LOGIN_URL);
    var response = await http.post(url, body: {
      "identifier": _emailController.text,
      "password": _passwordController.text,
    });
    if (response.statusCode == 200) {
      print("Account Login" + response.body);
      var body = jsonDecode(response.body);
      SharedPrefs.saveToken(body['jwt'],body['user']['id'].toString());


      Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    } else {
      print("Can Not Login Account ***");
      var body = jsonDecode(response.body);
      print(body['message'][0]['messages'][0]['message']);

      String errorMessage = body['message'][0]['messages'][0]['message'].toString();
      AlertWidgets.accountSystemAlertWidget(context,errorMessage,"");
    }
  }
}
