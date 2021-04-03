import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:twitter_pink/pages/tweetDetailsPage.dart';
import 'package:twitter_pink/providers/tweetProvider.dart';

import '../model/tweetModel.dart';

import '../pages/friendProfilePage.dart';
import '../utilities/constants.dart';

class NewTweetsPage extends StatefulWidget {
  @override
  _NewTweetsPageState createState() => _NewTweetsPageState();
}

class _NewTweetsPageState extends State<NewTweetsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBgColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Icon(
          FontAwesomeIcons.dove,
          color: mainDarkPinkColor,
          size: 40,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Icon(
              Icons.whatshot_outlined,
              color: mainDarkPinkColor,
              size: 30,
            ),
            // child: Icon(
            //   FontAwesomeIcons.commentSlash,
            //   color: mainDarkPinkColor,
            // ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width / 1,
              child: Column(
                children: [
                  FutureBuilder(
                    future: Provider.of<TweetProvider>(context).fetchTweets(),
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
                              child: tweets.length >= 7
                                  ? ListView.builder(
                                      itemCount: 7,
                                      itemBuilder: (context, index) {
                                        return newTweetNotificationWidget(
                                            tweets[index]);
                                      },
                                    )
                                  : Container(
                                      child: Center(
                                        child: Text("No Data More than 7"),
                                      ),
                                    ));
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

  Widget newTweetNotificationWidget(TweetModel tweet) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FriendProfilePage(tweet.tweetUserId.toString())));
                },
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    image: DecorationImage(
                      image: (tweet.image != null)
                          ? NetworkImage(MAIN_URL + tweet.image)
                          : AssetImage("assets/images/placeholder.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TweetsDetailsPage(tweet)));

                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "New tweet About",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: mainDarkPinkColor,
                            ),
                          ),
                          Icon(
                            Icons.auto_awesome,
                            color: mainLightPinkColor,
                          )
                        ],
                      ),
                      Text(
                        tweet.description,
                        style: TextStyle(
                          fontSize: 13,
                          color: mainDarkPinkColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
