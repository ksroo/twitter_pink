

class UserModel {
  int id;
  String username;
  String email;
  String fullName;
  String image;
  String bannar;

  UserModel( this.email, this.fullName, this.id, this.bannar,this.image,
      this.username);
       UserModel.fromJson(Map<String, dynamic> map) {
    this.id = map['id'];
    this.username = map['username'];
    this.email = map['email'];
    this.fullName = map['fullName'];
    this.image = map['image'] != null ? map['image']['url'] : null;
    this.bannar = map['bannar'] != null ? map['bannar']['url'] : null;
  }
}
