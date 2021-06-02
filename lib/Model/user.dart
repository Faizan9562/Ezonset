
import 'package:cloud_firestore/cloud_firestore.dart';

class OurUser {
  String uid;
  String email;
  String useranme;
  String displayName;
  String country;
  String avatarUrl;
  int step;
  String type;
  Timestamp accountCreated;

  OurUser({this.accountCreated, this.email, this.uid, this.avatarUrl, this.country, this.displayName, this.useranme, this.step, this.type});

  factory OurUser.fromFireStore(DocumentSnapshot _snapshot) {
    var _data = _snapshot.data();
    return OurUser(
      uid: _data["uid"],
      email: _data["email"] ?? "",
      useranme: _data["username"] ?? "",
      displayName: _data["displayName"] ?? "",
      country: _data["country"] ?? "",
      avatarUrl: _data["avatarUrl"] ?? "",
      accountCreated: _data["accountCreated"] ?? "",
      step: _data["step"] ?? "",
      type: _data["type"] ?? "",
    );
  }
}
