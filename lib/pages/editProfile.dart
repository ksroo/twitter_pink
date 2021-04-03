import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter_pink/main.dart';
import 'package:twitter_pink/model/userModel.dart';
import 'package:twitter_pink/utilities/constants.dart';
import 'package:twitter_pink/widgets/alertWidgets.dart';
import 'package:twitter_pink/widgets/customInputTextField.dart';
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  UserModel myUser;
  EditProfile(this.myUser);

  static const routeName = "/EditProfile";
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File _profileImage;
  File _bannerImage;
  final picker = ImagePicker();
  final pickerTow = ImagePicker();

  Future getImage() async {
    final filePicked = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (filePicked != null) {
        _profileImage = File(filePicked.path);
      } else {
        AlertWidgets.accountSystemAlertWidget(
            context, "No Profile image selected.", "Sorry");
      }
    });
  }

  Future getImageTow() async {
    final filePicked = await pickerTow.getImage(source: ImageSource.gallery);

    setState(() {
      if (filePicked != null) {
        _bannerImage = File(filePicked.path);
      } else {
        AlertWidgets.accountSystemAlertWidget(
            context, "No Banner image selected.", "Sorry");
      }
    });
  }

  final _formKeyFullName = GlobalKey<FormState>();
  final _formKeyUserName = GlobalKey<FormState>();
  final _formKeyEmail = GlobalKey<FormState>();

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.myUser.fullName;
    _emailController.text = widget.myUser.email;
    _userNameController.text = widget.myUser.username;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: mainDarkPinkColor,
        elevation: 0,
        title: Icon(
          FontAwesomeIcons.dove,
          color: mainwhiteColor,
          size: 50,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Icon(
              Icons.edit,
              color: mainwhiteColor,
              size: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            uploadImage(
              "Upload Your Profile Image ",
              () {
                getImage();
              },
              () async {
                var header = {"Authorization": "Bearer " + prefs.get("token")};
                Response response;
                Dio dio = Dio();
                response = await dio.post(
                  MAIN_URL + "/upload",
                  data: await addProfileImageData(
                      _profileImage, widget.myUser.id.toString()),
                  options: Options(headers: header),
                );
                if (response.statusCode == 200) {
                  AlertWidgets.successSystemAlertWidget(
                      context, "Profile image Updated", "Done", "okay");
                } else {
                  AlertWidgets.accountSystemAlertWidget(
                      context, "Cant Not Update Your Profile image", "Sorry");
                }
              },
            ),
            SizedBox(height: 10),
            Divider(
              height: 10,
            ),
            uploadImage(
              "Upload Your Banner Image ",
              () {
                getImageTow();
              },
              () async {
                var header = {"Authorization": "Bearer " + prefs.get("token")};
                Response response;
                Dio dio = Dio();
                response = await dio.post(
                  MAIN_URL + "/upload",
                  data: await addBannerImageData(
                      _bannerImage, widget.myUser.id.toString()),
                  options: Options(headers: header),
                );
                if (response.statusCode == 200) {
                  AlertWidgets.successSystemAlertWidget(
                      context, "Banner image Updated", "Done", "okay");
                } else {
                  AlertWidgets.accountSystemAlertWidget(
                      context, "Cant Not Update Your Banner image", "Sorry");
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Update  Full Name",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: CustomInputTextField(
                        hintText: "Edit Full Name ",
                        secure: false,
                        controller: _nameController,
                        formKey: _formKeyFullName,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        updateUserTextData(widget.myUser.id.toString(),
                            "fullName", _nameController.text, context);
                      },
                      child: Text(
                        "save",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: mainDarkPinkColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Update UserName",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: CustomInputTextField(
                        hintText: "Edit User Name @",
                        secure: false,
                        controller: _userNameController,
                        formKey: _formKeyUserName,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        updateUserTextData(widget.myUser.id.toString(),
                            "username", _userNameController.text, context);
                      },
                      child: Text(
                        "save",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: mainDarkPinkColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Update Your Email",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: CustomInputTextField(
                        hintText: "Edit Email ",
                        secure: false,
                        controller: _emailController,
                        formKey: _formKeyEmail,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        updateUserTextData(widget.myUser.id.toString(), "email",
                            _emailController.text, context);
                      },
                      child: Text(
                        "save",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: mainDarkPinkColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget uploadImage(
      String title, Function selectImageOnPress, Function uploadImageOnPress) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Row(
            children: [
              IconButton(
                onPressed: selectImageOnPress,
                icon: Icon(
                  Icons.upload_file,
                  size: 40,
                  color: mainDarkPinkColor,
                ),
              ),
              FlatButton(
                onPressed: uploadImageOnPress,
                child: Text(
                  "save",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: mainDarkPinkColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  updateUserTextData(
      String id, String key, String value, BuildContext context) async {
    var header = {"Authorization": "Bearer " + prefs.get("token")};

    var url = Uri.parse("http://localhost:1337/users/$id");
    print(url);

    http.Response response = await http.put(url, headers: header, body: {
      key: value,
    });
    AlertWidgets.successSystemAlertWidget(
        context, "$key upDated", "Success", "Okay");
    if (response.statusCode == 200) {
      print("Sucsess");
    } else {
      print(response.body);
    }
  }

  Future<FormData> addProfileImageData(File image, String userId) async {
    var formData = FormData();
    formData = FormData.fromMap({
      "ref": userId,
      "refId": userId,
      "source": "users-permissions",
      "field": "image",
    });

    if (_profileImage != null) {
      formData.files.add(MapEntry("files.image",
          await MultipartFile.fromFile(image.path, filename: "tweet.png")));
    }
    return formData;
  }

  Future<FormData> addBannerImageData(File image, String userId) async {
    var formData = FormData();
    formData = FormData.fromMap({
      "ref": userId,
      "refId": userId,
      "source": "users-permissions",
      "field": "bannar",
    });

    if (_bannerImage != null) {
      formData.files.add(MapEntry("files.image",
          await MultipartFile.fromFile(image.path, filename: "tweet.png")));
    }
    return formData;
  }
}
