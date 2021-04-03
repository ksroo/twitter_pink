import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../main.dart';
import '../pages/friendProfilePage.dart';
import '../pages/tweetDetailsPage.dart';
import 'package:http/http.dart' as http;
import '../model/tweetModel.dart';
import 'package:twitter_pink/utilities/constants.dart';

class CustomTweetCard extends StatefulWidget {
  final TweetModel tweets;

  CustomTweetCard(
    this.tweets,
  );

  @override
  _CustomTweetCardState createState() => _CustomTweetCardState();
}

class _CustomTweetCardState extends State<CustomTweetCard> {

  @override
  Widget build(BuildContext context) {
    var sizeWidth = MediaQuery.of(context).size.width;
    var sizeheight = MediaQuery.of(context).size.height;
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
                    InkWell(
                      onTap: () {
                        print(widget.tweets.tweetUserId);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FriendProfilePage(
                                    widget.tweets.tweetUserId.toString())));
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(45),
                          image: DecorationImage(
                            image: NetworkImage(
                                MAIN_URL + widget.tweets.tweetUserImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      child: Text(
                        widget.tweets.tweetUserName,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "@${widget.tweets.tweetUserFullName}",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                widget.tweets.description,
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TweetsDetailsPage(widget.tweets)));
              },
              child: Container(
                width: sizeWidth * 40,
                height: sizeheight * 0.30,
                child: Card(
                  child: Image.network(MAIN_URL + widget.tweets.image,
                      fit: BoxFit.fill),
                ),
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
                    child: TextButton(
                        onPressed: () async {
                          print(widget.tweets.liked);

                          // when user create like
                          var header = {"Authorization": "Bearer " + prefs.get("token")};
                          var url = Uri.parse(LIKES_URL);

                          http.Response response =
                              await http.post(url, headers: header, body: {
                            "tweet": widget.tweets.id.toString(),
                          });

                          switch (response.statusCode) {
                            case 200:
                              {
                                print("you like this tweet");
                                //ids.add(widget.tweets.id);
                                // when user Remove like
                                http.Response response = await http.put(
                                    Uri.parse(
                                      TWEETS_URL +
                                          "/" +
                                          widget.tweets.id.toString(),
                                    ),
                                    headers: header,
                                    body: {
                                      "liked": 1.toString(),
                                    });
                                break;
                              }

                            case 420:
                              {
                                print("you unLike this tweet");
                                String tweetId = widget.tweets.id.toString();
                                http.Response response = await http.delete(
                                    Uri.parse(
                                      LIKES_URL + tweetId,
                                    ),
                                    headers: header);
                                print("you UnLike this tweet");

                                if (response.statusCode == 200) {
                                  http.Response response = await http.put(
                                      Uri.parse(
                                        TWEETS_URL +
                                            "/" +
                                            widget.tweets.id.toString(),
                                      ),
                                      headers: header,
                                      body: {
                                        "liked": 0.toString(),
                                      });
                                }
                                //ids.remove(widget.tweets.id);

                                break;
                              }
                            default:
                              {
                                print(response.body);
                              }
                          }

                          setState(() {});

                          print(widget.tweets.likes.toString());
                        },
                        child: (widget.tweets.liked == "0")
                            ? Icon(
                                Icons.favorite,
                                color: mainDarkPinkColor,
                              )
                            : Icon(
                                FontAwesomeIcons.heart,
                                color: Colors.black,
                                size: 20,
                              )),
                  ),
                  Text(
                    widget.tweets.likes.toString() + "Likes",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: sizeheight * 0.05,
                    width: sizeWidth * 0.12,
                    child: TextButton(
                      onPressed: () {},
                      child: Icon(FontAwesomeIcons.comment),
                    ),
                  ),
                  Text(
                    widget.tweets.comments.length.toString() + " Comments",
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
