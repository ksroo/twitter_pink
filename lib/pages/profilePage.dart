

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:twitter_pink/model/tweetModel.dart';
import 'package:twitter_pink/pages/editProfile.dart';
import 'package:twitter_pink/pages/tweetDetailsPage.dart';
import 'package:twitter_pink/providers/accountByIdProvider.dart';
import 'package:twitter_pink/providers/profileProvider.dart';
import 'package:twitter_pink/widgets/coustomTweetCard.dart';
import '../StartPointPage.dart';
import '../sharedPref//sharedPref.dart';
import 'package:twitter_pink/main.dart';
import '../model/userModel.dart';

import 'package:twitter_pink/utilities/constants.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = "/ProfilePage";
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String myId = prefs.getString('myId');

  @override
  void initState() {
    // fetchAccountById(myId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                children: [
                  FutureBuilder(
                    future:  Provider.of<AccountByIdProvider>(context).fetchAccountById(myId),
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
              padding: const EdgeInsets.only(top: 80,left:0 ),
              child: TextButton.icon(
                onPressed: (){
                  SharedPrefs.saveToken("", "");
                  Navigator.pushReplacementNamed(context, StartPoint.routeName);
                },
                icon: Icon(FontAwesomeIcons.cloudUploadAlt,color: mainDarkPinkColor,size: 15,),
                label: Text("LogOut",style: TextStyle(color: mainDarkPinkColor),),
                ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 10),
              child: Text(
                "My Tweets",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: mainDarkPinkColor),
              ),
            ),
            Container(
              child: Column(
                children: [
                  FutureBuilder(
                    future: Provider.of<ProfileProvider>(context).fetchLoginUserTweets(myId),
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
                          List<TweetModel> tweets =
                          snapShot.data.reversed.toList();
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.9,
                            child: ListView.builder(
                              itemCount: tweets.length,
                              itemBuilder: (context, index) {
                                return tweetCard(tweets[index]);
                              },
                            ),
                          );
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
               MAIN_URL + myUser.bannar,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40,right: 10.0, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      border: Border.all(color: mainwhiteColor, width: 3),
                      image: DecorationImage(
                        image: NetworkImage(


                            MAIN_URL + myUser.image,),

                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:80),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context) => EditProfile(myUser)) );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: mainwhiteColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: mainDarkPinkColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Edit Profile",
                            style: TextStyle(
                              color: mainDarkPinkColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                      ),

                    ),
                  ),

                ],
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

  Widget tweetCard(TweetModel tweet) {
    var sizeWidth = MediaQuery.of(context).size.width;
    var sizeheight = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 10, left: 5, right: 5),
      child: InkWell(
        onTap: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=> TweetsDetailsPage(tweet)));
        },
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
                            image: tweet.tweetUserImage != null? NetworkImage(
                                MAIN_URL + tweet.tweetUserImage): Image.asset("assets/images/placeholder.png"),
                            fit: BoxFit.cover ,
                          ),
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
                              tweet.description,
                              style: TextStyle(fontSize: 17),
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
                  child: tweet.image != null ? Image.network(MAIN_URL+ tweet.image, fit: BoxFit.fill): Image.asset("assets/images/placeholder.png"),
                ),
              ),
            ),

            Divider(
              thickness: 2,
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
