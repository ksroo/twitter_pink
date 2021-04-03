import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:twitter_pink/providers/accountByIdProvider.dart';

import '../model/userModel.dart';


import 'package:twitter_pink/utilities/constants.dart';

class FriendProfilePage extends StatefulWidget {


  String userId;
  FriendProfilePage(this.userId );




  @override
  _FriendProfilePageState createState() => _FriendProfilePageState();
}

class _FriendProfilePageState extends State<FriendProfilePage> {



  //
  // @override
  // void initState() {
  //   // fetchAccountById(myId);
  //
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Icon(FontAwesomeIcons.dove,size: 40,color: mainDarkPinkColor,),
        backgroundColor: mainwhiteColor,
        iconTheme: IconThemeData(
          color: mainDarkPinkColor,
        ),

        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                children: [
                  FutureBuilder(
                    future:  Provider.of<AccountByIdProvider>(context).fetchAccountById(widget.userId),
                    builder: (context, snapShot) {
                      switch (snapShot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: mainLightPinkColor,
                            ),
                          );
                          break;
                        case ConnectionState.none:
                          return Center(
                            child: Text("Error on Connction"),
                          );
                          break;
                        case ConnectionState.active:
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: mainLightPinkColor,
                            ),
                          );
                          break;
                        case ConnectionState.done:
                          UserModel myUser = snapShot.data;
                          return headerProfileCard(myUser);
                          break;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: mainLightPinkColor,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 100, left: 10),
              child: Text(
                "My Tweets",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: mainDarkPinkColor),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return tweetCard("this my profile tweets that will show it",
                      "https://images.unsplash.com/photo-1616995787507-c3bffc4d51d9?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=668&q=80");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget headerProfileCard(UserModel myUser) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                MAIN_URL + myUser.image,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10),
              child: Transform.translate(
                offset: Offset(5, 40),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    border: Border.all(color: mainwhiteColor, width: 3),
                    image: DecorationImage(
                      image: NetworkImage(
                        MAIN_URL + myUser.image,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(10, 90),
              child: Column(
                children: [
                  Text(
                    myUser.fullName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "@${myUser.username}",
                    style: TextStyle(fontSize: 13, color: mainGreyColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget tweetCard(String tweetDescriptuon, String tweetImage) {
    var sizeWidth = MediaQuery.of(context).size.width;
    var sizeheight = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 10, left: 5, right: 5),
      child: Column(
        children: [
          Container(
            // color: Colors.grey.shade200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://images.unsplash.com/photo-1568602471122-7832951cc4c5?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      child: Text(
                        "@username",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            tweetDescriptuon,
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: sizeWidth * 40,
              height: sizeheight * 0.50,
              child: Card(
                child: Image.network(tweetImage, fit: BoxFit.fill),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Container(
                    height: sizeheight * 0.05,
                    width: sizeWidth * 0.12,
                    child: FlatButton(
                      onPressed: () {},
                      child: Icon(FontAwesomeIcons.heart),
                    ),
                  ),
                  Text(
                    "70 Likes",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: sizeheight * 0.05,
                    width: sizeWidth * 0.12,
                    child: FlatButton(
                      onPressed: () {},
                      child: Icon(FontAwesomeIcons.comment),
                    ),
                  ),
                  Text(
                    "190 Comments",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          Divider(
            thickness: 2,
            height: 10,
          ),
        ],
      ),
    );
  }
}
