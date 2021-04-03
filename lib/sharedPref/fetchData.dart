// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
// import 'package:twitter_pink/main.dart';
//
// import '../model/userModel.dart';
// import 'package:twitter_pink/utilities/constants.dart';
// import '../model/tweetModel.dart';
//
//
//
//
//
// // Future<List<TweetModel>> fetchTweets() async {
// //
// //
// //   var url = Uri.parse(TWEETS_URL);
// //
// //   http.Response response = await http.get(url, headers: header);
// //   if (response.statusCode == 200) {
// //     var body = jsonDecode(response.body);
// //     List<TweetModel> tweets = [];
// //
// //     for (var tweet in body) {
// //       tweets.add(TweetModel.fromJson(tweet));
// //     }
// //
// //     return tweets;
// //   } else {
// //     print(response.statusCode);
// //   }
// //
// //   return null;
// // }
//
// // Future<List<TweetModel>> fetchLoginUserTweets(String id) async {
// //
// //   var url = Uri.parse(LOGIN_USER_TWEETS_URL + id);
// //
// //   http.Response response = await http.get(url, headers: header);
// //   if (response.statusCode == 200) {
// //     var body = jsonDecode(response.body);
// //     List<TweetModel> tweets = [];
// //
// //     for (var tweet in body) {
// //       tweets.add(TweetModel.fromJson(tweet));
// //     }
// //
// //     return tweets;
// //   } else {
// //     print(response.statusCode);
// //   }
// //
// //   return null;
// // }
//
// // Future<List<TweetModel>> fetchSearchTweets(String inputText) async {
// //
// //
// //   var url = Uri.parse(SWARCH_URL + inputText);
// //
// //   http.Response response = await http.get(url, headers: header);
// //   if (response.statusCode == 200) {
// //     var body = jsonDecode(response.body);
// //     List<TweetModel> tweets = [];
// //
// //     for (var tweet in body) {
// //       tweets.add(TweetModel.fromJson(tweet));
// //       print(tweet);
// //     }
// //
// //     return tweets;
// //   } else {
// //     print(response.statusCode);
// //   }
// //
// //   return null;
// // }
//
// // Future<UserModel> fetchMyAccount() async {
// //   // how you give token here\
// //
// //   var url = Uri.parse(MYACCOUNT_URL);
// //
// //   http.Response response = await http.get(url, headers: header);
// //   if (response.statusCode == 200) {
// //     var body = jsonDecode(response.body);
// //
// //     return UserModel.fromJson(body);
// //   } else {
// //     print(response.statusCode);
// //   }
// //
// //   return null;
// // }
// //
//
// // Future<UserModel> fetchAccountById(String id) async {
// //   var url = Uri.parse(USERS_URL + id);
// //
// //   http.Response response = await http.get(url, headers: header);
// //   if (response.statusCode == 200) {
// //     var body = json.decode(response.body);
// //
// //     return UserModel.fromJson(body);
// //   } else {
// //     print(response.statusCode);
// //   }
// //
// //   return null;
// // }
//
// // featc Like in coustomTweetCard
