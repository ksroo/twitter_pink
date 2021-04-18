import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:twitter_pink/main.dart';

import 'package:twitter_pink/utilities/constants.dart';

import '../widgets/navigationBar.dart';

class CreateTweetPage extends StatefulWidget {
  String userImageUrl;
  CreateTweetPage(this.userImageUrl);
  static const routeName = "/CreateTweetePage";

  @override
  _CreateTweetPageState createState() => _CreateTweetPageState();
}

class _CreateTweetPageState extends State<CreateTweetPage> {
  TextEditingController _tweetTextController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _tweetTextController.dispose();
  }
  String myId = prefs.getString('myId');
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final filePicked = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (filePicked != null) {
        _image = File(filePicked.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: mainDarkPinkColor,
              child: Text(
                "Tweet",
                style: TextStyle(
                  color: mainwhiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                var header = {"Authorization": "Bearer " + prefs.get("token")};
                Response response;
                Dio dio = Dio();
                response = await dio.post(TWEETS_URL,data: await addPostData(_image,_tweetTextController.text),options: Options(
                  headers: header,
                ));
                Navigator.of(context).pushNamed(NavigationBar.routeName);
              },
            ),
          ),
        ],
        leadingWidth: 1100,
        leading: GestureDetector(
          onTap: () {
            return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Cancle"),
                  content: Text("Are you Sure need cancle Tweet"),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => CreateTweetPage(widget.userImageUrl)));
                      },
                      child: Text("No"),
                    ),
                    FlatButton(
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
              "Cancle",
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
                        image: NetworkImage(
                            widget.userImageUrl),
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
                          hintText: "What is your mind",
                        ),
                        maxLines: 20,
                        obscureText: false,
                        controller: _tweetTextController,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  getImage();
                },
                child: Row(
                  children: [
                    Text(
                      "Select Image",
                      style: TextStyle(color: mainDarkPinkColor, fontSize: 15),
                    ),
                    Icon(
                      FontAwesomeIcons.image,
                      color: mainDarkPinkColor,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
            _image == null
                ? Container()
                : Card(
                    child: Container(
                      height: 200,
                      width: 200,
                      child: Image.file(
                        _image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
          ],
        ),
      ),
      //add post data
    );
  }



  Future <FormData> addPostData(File image, String tweetDescription) async{
      var formData = FormData();
      formData.fields.add(MapEntry("data", '{"description" : "$tweetDescription"},"users_permissions_user":"$myId"'));
      if(_image != null){
        formData.files.add(MapEntry("files.image", await MultipartFile.fromFile(image.path,filename: "tweet.png")));
      }
      return formData;
  }
}
