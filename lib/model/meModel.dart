class MeModel {
  int id;
  String username;
  String email;
  String fullName;

  MeModel(this.email, this.fullName, this.id, this.username);
  MeModel.fromJson(Map<String, dynamic> map) {
    this.id = map['id'];
    this.username = map['username'];
    this.email = map['email'];
    this.fullName = map['fullName'];
  }
}
