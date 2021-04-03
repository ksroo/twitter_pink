// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:twitter_pink/api/sharedPref.dart';
//
// import 'package:twitter_pink/main.dart';
// import 'package:twitter_pink/pages/homePage.dart';
// import 'package:twitter_pink/widgets/alertWidgets.dart';
// import '../model/tweetModel.dart';
// import '../utilities/constants.dart';
// import 'package:http/http.dart' as http;
//
//
// class LoginProvider with ChangeNotifier{
//   var header = {"Authorization": "Bearer " + prefs.get("token")};
//
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//
//
//   Future loginAccount() async {
//     var url = Uri.parse(LOGIN_URL);
//     var response = await http.post(url, body: {
//       "identifier": emailController.text,
//       "password": passwordController.text,
//     });
//     if (response.statusCode == 200) {
//       print("Account Login" + response.body);
//       var body = jsonDecode(response.body);
//       SharedPrefs.saveToken(body['jwt'],body['user']['id'].toString());
//
//
//      // Navigator.of(context).pushReplacementNamed(HomePage.routeName);
//     } else {
//       print("Can Not Login Account ***");
//       var body = jsonDecode(response.body);
//       print(body['message'][0]['messages'][0]['message']);
//
//       String errorMessage = body['message'][0]['messages'][0]['message'].toString();
//      //AlertWidgets.accountSystemAlertWidget(context,errorMessage,"");
//     }
//   }
//   notifyListeners();
// }
