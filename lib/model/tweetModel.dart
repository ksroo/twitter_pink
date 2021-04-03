import '../model/commentModel.dart';

class TweetModel {
  int id;
  int tweetUserId;
  int likes;
  String description;
  String image;
  String tweetUserName;
  String tweetUserImage;
  String tweetUserFullName;
  String liked;
  List<CommentModel> comments;

  TweetModel(
    this.id,
    this.description,
    this.image,
    this.tweetUserId,
    this.tweetUserName,
    this.tweetUserImage,
    this.tweetUserFullName,
    this.likes,
    this.liked,
    this.comments,
  );

  TweetModel.fromJson(Map<String, dynamic> map) {
    this.id = map['id'];
    this.likes = map['likes'];
    this.liked = map['liked'];
    this.tweetUserId = map['users_permissions_user']['id'];
    this.tweetUserName = map['users_permissions_user']['username'];
    this.tweetUserFullName = map['users_permissions_user']['fullName'];
    this.tweetUserImage = map['users_permissions_user']['image']["url"];
    this.description = map['description'];
    this.image = map['image']['url'];
    _setComment(map["comments"]);

  }

  // loop for all comments in single tweet
  void _setComment(List <dynamic> commentJson){
    this.comments = [];
    for (var comment in commentJson){
      comments.add(CommentModel.fromJson(comment));
    }
  }
}
