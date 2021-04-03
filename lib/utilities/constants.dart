import 'package:flutter/material.dart';

//Colors

final mainDarkPinkColor = Color(0xffbd5eb0);
final mainMoreDarkColor = Color(0xff7c5fa5);
final mainLightPinkColor = Color(0xffde28cb);
final mainwhiteColor = Color(0xfffefefb);
final mainGreyColor = Color(0xff687683);
final mainBgColor = Color(0xfff4f4f4);

//Api URL

final MAIN_URL = 'http://localhost:1337';
final REGISTER_URL = MAIN_URL + "/auth/local/register";
final LOGIN_URL = MAIN_URL + "/auth/local";
final TWEETS_URL = MAIN_URL + "/tweets";
final MYACCOUNT_URL = MAIN_URL + "/users/me";
final USERS_URL = MAIN_URL + "/users/";
final LIKES_URL = MAIN_URL + "/likes/";
final COMMENT_URL = MAIN_URL + "/tweets/";
final LOGIN_USER_TWEETS_URL = MAIN_URL + "/tweets?users_permissions_user=";
final MYLIKES_URL = LIKES_URL + "given?user=";

final placeHolderImage = "assets/images/placeholder.png";


// Search

final SWARCH_URL = MAIN_URL + "/tweets?description_contains=";


//favorite list

List<int> ids = [1, 2, 3];



