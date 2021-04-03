
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';


import 'package:twitter_pink/main.dart';


import 'package:twitter_pink/utilities/constants.dart';

import '../widgets/navigationBar.dart';

class CreateCommentPage extends StatefulWidget {
  String tweetId;

  CreateCommentPage(this.tweetId,);

  @override
  _CreateCommentPageState createState() => _CreateCommentPageState();
}

class _CreateCommentPageState extends State<CreateCommentPage> {
  TextEditingController _commentTextController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _commentTextController.dispose();
  }
  String myId = prefs.getString('myId');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        leadingWidth: 1100,
        leading: GestureDetector(
          onTap: () {
            return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Cancel"),
                  content: Text("Are you Sure need cancel Comment"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => CreateCommentPage(widget.tweetId)));
                      },
                      child: Text("No"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(NavigationBar.routeName);
                      },
                      child: Text("Yes"),
                    ),
                  ],
                );
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10, top: 20),
            child: Text(
              "Cancel",
              style: TextStyle(
                  color: mainDarkPinkColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      image: DecorationImage(
                        image:(myUserAccountData.image != null || myUserAccountData.image != "")?  NetworkImage(MAIN_URL   + myUserAccountData.image):AssetImage("assets/images/placeholder"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      height: MediaQuery.of(context).size.height * 0.11,
                      child: TextFormField(
                        cursorColor: mainDarkPinkColor,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Write Your Comment",
                        ),
                        maxLines: 20,
                        obscureText: false,
                        controller: _commentTextController,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: mainDarkPinkColor,
                child: Text(
                  "Comment",
                  style: TextStyle(
                    color: mainwhiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () async {
                  var header = {"Authorization": "Bearer " + prefs.get("token")};
                    String tweetId = widget.tweetId.toString();

                  http.Response response = await http.post(Uri.parse("http://localhost:1337/tweets/$tweetId/comment"),headers: header,body: {
                    "content":_commentTextController.text,
                  });

                  print(response.body);

                  Navigator.of(context).pushReplacementNamed(NavigationBar.routeName);
                },
              ),
            ),
          ],
        ),
      ),
      //add post data
    );
  }



}
