import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_pink/providers/searchProvider.dart';
import '../model/tweetModel.dart';
import '../widgets/coustomTweetCard.dart';

import 'package:twitter_pink/utilities/constants.dart';


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchWordTextEditingController =
      TextEditingController();
  String inputValue = "";

  @override
  void initState() {
    _searchWordTextEditingController.text = inputValue;
    super.initState();
  }

  @override
  void dispose() {
    _searchWordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainDarkPinkColor,
        title: Text("Search what you wont"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _searchWordTextEditingController,
                decoration: InputDecoration(
                  hintText: "Write Search word ",
                  icon: Icon(
                    Icons.search_outlined,
                    color: mainDarkPinkColor,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            FlatButton(

              onPressed: () {
                setState(() {
                  inputValue = _searchWordTextEditingController.text;
                });
              },
              child: Text(
                "Search",
                style: TextStyle(color: mainwhiteColor),
              ),
              color: mainDarkPinkColor,
            ),
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.99,
                child: Column(
                  children: [
                    FutureBuilder(
                      future: Provider.of<SearchProvider>(context).fetchSearchTweets(
                          _searchWordTextEditingController.text),
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
          ],
        ),
      ),
    );
  }
}
