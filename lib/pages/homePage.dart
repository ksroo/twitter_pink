import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:twitter_pink/main.dart';
import 'package:twitter_pink/model/userModel.dart';
import 'package:twitter_pink/providers/accountByIdProvider.dart';
import 'package:twitter_pink/providers/tweetProvider.dart';
import 'package:twitter_pink/widgets/navigationBar.dart';
import '../model/tweetModel.dart';
import '../pages/createTweetPage.dart';
import '../utilities/constants.dart';

import '../widgets/coustomTweetCard.dart';


class HomePage extends StatefulWidget {
  static const routeName = "/HomePage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  Widget build(BuildContext context) {
    Provider.of<AccountByIdProvider>(context).fetchAccountById(prefs.getString("myId")).then((futureUser) => {
      myUserAccountData = futureUser,
    });

    return Scaffold(
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
              Icons.auto_awesome,
              color: mainDarkPinkColor,
              size: 30,
            ),
       
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> CreateTweetPage( MAIN_URL+ myUserAccountData.image)));
        },
        backgroundColor: mainDarkPinkColor,
        child: Icon(
          Icons.edit_off,
          color: mainwhiteColor,
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(

          child: Container(
            child: Column(
              children: [
                FutureBuilder(
                  future: Provider.of<TweetProvider>(context,listen: false).fetchTweets(),
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
                              return CustomTweetCard(
                                tweets[index],
                              );
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
        ),

      ),
    );
  }
}
