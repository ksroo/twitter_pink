import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_pink/providers/accountByIdProvider.dart';
import 'package:twitter_pink/providers/profileProvider.dart';
import 'package:twitter_pink/providers/searchProvider.dart';
import '../model/userModel.dart';

import '../providers/tweetProvider.dart';

import './pages/profilePage.dart';

import 'package:provider/provider.dart';
import 'pages/registerAccountPage.dart';
import 'pages/loginPage.dart';
import 'StartPointPage.dart';
import './pages/homePage.dart';
import 'widgets/navigationBar.dart';
import './widgets/navigationBar.dart';

SharedPreferences prefs;
UserModel myUserAccountData =
    UserModel("", "", int.parse(prefs.getString("myId")), "", "", "");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  String token = prefs.getString('token');

  Widget _screen;
  if (token == null || token == "") {
    _screen = StartPoint();
  } else {
    _screen = NavigationBar();
  }
  runApp(
    
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> TweetProvider()),
        ChangeNotifierProvider(create: (_)=> ProfileProvider()),
        ChangeNotifierProvider(create: (_)=> SearchProvider()),
        ChangeNotifierProvider(create: (_)=> AccountByIdProvider()),



      ],
      child: MyApp(_screen),
    ),
  );
  
   
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final Widget _screen;

  MyApp(this._screen);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Twitter Pink',
      home: this._screen,
      routes: {
        LoginPage.routeName: (ctx) => LoginPage(),
        RegisterAccountPage.routeName: (ctx) => RegisterAccountPage(),
        HomePage.routeName: (ctx) => HomePage(),
        NavigationBar.routeName: (ctx) => NavigationBar(),
        ProfilePage.routeName: (ctx) => ProfilePage(),
        StartPoint.routeName: (ctx) => StartPoint(),
      },
    );
  }
}
