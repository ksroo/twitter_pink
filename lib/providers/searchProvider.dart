import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:twitter_pink/main.dart';
import '../model/tweetModel.dart';
import '../utilities/constants.dart';
import 'package:http/http.dart' as http;


class SearchProvider with ChangeNotifier{

  Future<List<TweetModel>> fetchSearchTweets(String inputText) async {
    var header = {"Authorization": "Bearer " + prefs.get("token")};

    var url = Uri.parse(SWARCH_URL + inputText);

    http.Response response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List<TweetModel> tweets = [];

      for (var tweet in body) {
        tweets.add(TweetModel.fromJson(tweet));
        print(tweet);
      }

      return tweets;
    } else {
      print(response.statusCode);
    }

    return null;
  }

  notifyListeners();

}