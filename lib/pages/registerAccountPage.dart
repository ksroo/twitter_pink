import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:twitter_pink/sharedPref/sharedPref.dart';
import 'package:twitter_pink/widgets/alertWidgets.dart';


import '../pages/loginPage.dart';

import '../utilities/constants.dart';
import '../widgets/customFlatButton.dart';
import '../widgets/customInputTextField.dart';
import '../widgets/customRaisButton.dart';
import 'package:http/http.dart' as http;
import './homePage.dart';

class RegisterAccountPage extends StatefulWidget {
  static const routeName = "/registerAccountPage";

  @override
  _RegisterAccountPageState createState() => _RegisterAccountPageState();
}

class _RegisterAccountPageState extends State<RegisterAccountPage> {
final _formKeyFullName = GlobalKey<FormState>();
final _formKeyUserName = GlobalKey<FormState>();
final _formKeyEmail = GlobalKey<FormState>();
final _formKeyPassword = GlobalKey<FormState>();

TextEditingController _userNameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
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
                height: 650,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "Create to your Account, Now",
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
                      hintText: 'Full Name',
                      secure: false,
                      controller: _nameController,
                      formKey: _formKeyFullName,
                    ),
                    CustomInputTextField(
                      hintText: 'UserName',
                      secure: false,
                      controller: _userNameController,
                      formKey: _formKeyUserName,
                    ),
                    CustomInputTextField(
                      hintText: 'Email',
                      secure: false,
                      controller: _emailController,
                      formKey: _formKeyEmail,
                    ),
                    CustomInputTextField(
                      hintText: 'Password',
                      secure: true,
                      controller: _passwordController,
                      formKey: _formKeyPassword,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    CustomRaisButton(
                      textLoginOrSinUp: "Register",
                      onpressed: () {
                        // Create Api to register Users Here???????
                        registerAccount();
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomFlatButton(
                textEnter: "You have Account? ",
                onpressed: () {
                  Navigator.of(context).pushNamed(LoginPage.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future registerAccount() async {
    var url = Uri.parse(REGISTER_URL);
    var response = await http.post(url, body: {
      "username": _userNameController.text,
      "email": _emailController.text,
      "password": _passwordController.text,
      "fullName": _nameController.text,
    });

    if(_formKeyFullName.currentState.validate()&& _formKeyUserName.currentState.validate()){

      if (response.statusCode == 200) {
        print("Account Created" + response.body);
        var body = jsonDecode(response.body);
        SharedPrefs.saveToken(body['jwt'],body['user']['id'].toString());
        Navigator.of(context).pushReplacementNamed(HomePage.routeName);
      } else {
        print("Can Not Create Account ***");
        var body = jsonDecode(response.body);
        print(body['message'][0]['messages'][0]['message']);

        String errorMessage = body['message'][0]['messages'][0]['message'].toString();
        AlertWidgets.accountSystemAlertWidget(context,errorMessage,"");
      }
    }

  }
}
