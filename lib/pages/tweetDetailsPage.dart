import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:twitter_pink/model/commentModel.dart';
import 'package:twitter_pink/model/userModel.dart';
import 'package:twitter_pink/providers/accountByIdProvider.dart';
import '../pages/createCommentPage.dart';
import '../widgets/navigationBar.dart';
import '../model/tweetModel.dart';
import 'package:twitter_pink/utilities/constants.dart';
import '../widgets/coustomTweetCard.dart';

class TweetsDetailsPage extends StatefulWidget {
  static const routeName = "/TweetsDetailsPage";
  TweetModel tweet;
  TweetsDetailsPage(this.tweet);
  @override
  _TweetsDetailsPageState createState() => _TweetsDetailsPageState();
}

class _TweetsDetailsPageState extends State<TweetsDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Icon(
          FontAwesomeIcons.dove,
          size: 40,
          color: mainDarkPinkColor,
        ),
        backgroundColor: mainwhiteColor,

        leading: InkWell(
          onTap: (){
            Navigator.of(context).pushReplacementNamed(NavigationBar.routeName);
          },
            child: Icon(
          Icons.arrow_back,
          color: mainDarkPinkColor,
        )),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navigator.of(context).pushReplacementNamed(CreateCommentPage.routeName);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> CreateCommentPage(widget.tweet.id.toString())));
        },
        backgroundColor: mainDarkPinkColor,
        child: Icon(
          Icons.comment,
          color: mainwhiteColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTweetCard(widget.tweet,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Comments",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Container(
               height: 270,
               child: ListView.builder(
                 itemCount: widget.tweet.comments.length,
                 itemBuilder: (context,index){
                   List<CommentModel> comments = widget.tweet.comments.reversed.toList();
                   int id = comments[index].userID;
                   if(comments != null){

                    return FutureBuilder(
                      future:  Provider.of<AccountByIdProvider>(context).fetchAccountById(id.toString()),
                        builder: (context,snapShot){
                        UserModel userData = snapShot.data;

                        return Container(
                          height: 90,
                          child: ListView.builder(
                            itemCount: 1,
                            itemBuilder: (context,index){
                              return  commentCard(comments[index],userData);
                            },
                          ),
                        );






                      
                    });




                   }
                   return Container();

                 },
               ),
             ),
           ),
          ],
        ),
      ),
    );
  }

  Widget commentCard(CommentModel comment,UserModel user){
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            InkWell(
              onTap: () {


              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45),
                  image: DecorationImage(
                    image: (user.image != null || user.image != "")?NetworkImage(
                      MAIN_URL + user.image): AssetImage(placeHolderImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

          ],
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.fullName,
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
                        comment.content,
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
    );
  }
}
