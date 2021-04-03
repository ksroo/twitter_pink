import 'package:flutter/material.dart';
import '../pages/topTweetsPage.dart';
import '../pages/profilePage.dart';
import '../pages/homePage.dart';
import '../pages/searchPage.dart';
import '../utilities/constants.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NavigationBar extends StatefulWidget {
 // int initialPage;

  static const routeName = "/NavigationBar";
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _currentIndex = 0;

  List<Widget> widgetPages = [
    HomePage(),
    SearchPage(),
    NewTweetsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: widgetPages.elementAt(_currentIndex),
        bottomNavigationBar: SalomonBottomBar(
          items: [
            SalomonBottomBarItem(
                icon: Icon(Icons.home),
                title: Text(
                  "Home",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                selectedColor: mainDarkPinkColor),
            SalomonBottomBarItem(
                icon: Icon(Icons.search),
                title: Text(
                  "Search",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                selectedColor: mainDarkPinkColor),
            SalomonBottomBarItem(
                icon: Icon(Icons.whatshot_outlined),
                title: Text(
                  "Top Tweets",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                selectedColor: mainDarkPinkColor),
            SalomonBottomBarItem(
                icon: Icon(Icons.person_add_disabled_rounded),
                title: Text(
                  "Profile",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                selectedColor: mainDarkPinkColor),
          ],
          currentIndex: _currentIndex,
          onTap: _changeItem,
        ),
      ),
    );
  }

  void _changeItem(int value) {
    setState(() {
      _currentIndex = value;
    });
  }
}
