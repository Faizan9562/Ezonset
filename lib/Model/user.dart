import 'package:cloud_firestore/cloud_firestore.dart';

class OurUser {
  String uid;
  String email;
  String password;
  String useranme;
  String displayName;
  String country;
  String avatarUrl;
  String gender;
  String phone;
  Timestamp accountCreated;

  OurUser({this.accountCreated, this.email, this.uid, this.password, this.avatarUrl, this.country, this.displayName, this.useranme, this.gender, this.phone});

  factory OurUser.fromFireStore(DocumentSnapshot _snapshot) {
    var _data = _snapshot.data;
    return OurUser(
      uid: _snapshot.data["uid"],
      email: _snapshot.data["email"] ?? "",
      password: _snapshot.data["password"] ?? "",
      useranme: _snapshot.data["username"] ?? "",
      displayName: _snapshot.data["displayName"] ?? "",
      country: _snapshot.data["country"] ?? "",
      avatarUrl: _snapshot.data["avatarUrl"] ?? "",
      accountCreated: _snapshot.data["accountCreated"] ?? "",
      gender: _snapshot.data["gender"] ?? "",
      phone: _snapshot.data["phone"] ?? ""
    );
  }
}
