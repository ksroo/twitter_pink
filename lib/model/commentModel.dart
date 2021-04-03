class CommentModel {
  int id;
  int userID;
  String content;


  CommentModel(this.id, this.content,this.userID);

  CommentModel.fromJson(Map<String, dynamic> map) {
    this.id = map['id'];
    this.userID = map['user'];
    this.content = map['content'];
  }
}
