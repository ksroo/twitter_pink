import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:twitter_pink/main.dart';
import '../model/tweetModel.dart';
import '../utilities/constants.dart';
import 'package:http/http.dart' as http;


class ProfileProvider with ChangeNotifier{
  var header = {"Authorization": "Bearer " + prefs.get("token")};

  Future<List<TweetModel>> fetchLoginUserTweets(String id) async {

    var url = Uri.parse(LOGIN_USER_TWEETS_URL + id);

    http.Response response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List<TweetModel> tweets = [];

      for (var tweet in body) {
        tweets.add(TweetModel.fromJson(tweet));
      }

      return tweets;
    } else {
      print(response.statusCode);
    }

    return null;
  }
  notifyListeners();
}
