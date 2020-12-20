import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String senderId;
  String receiverId;
  String type;
  String message;
  Timestamp timestamp;
  FieldValue serverTime;
  String photoUrl;
  bool isSaved;

  Message(
      {this.senderId,
      this.receiverId,
      this.type,
      this.message,
      this.timestamp,
      this.serverTime,
      this.isSaved,
      this.photoUrl});

  Message.imageMessage(
      {this.senderId,
      this.receiverId,
      this.message,
      this.type,
      this.timestamp,
      this.serverTime,
      this.isSaved,
      this.photoUrl});

  Map toMap() {
    var map = Map<String, dynamic>();
    map['senderId'] = this.senderId;
    map['receiverId'] = this.receiverId;
    map['type'] = this.type;
    map['message'] = this.message;
    map['timestamp'] = this.serverTime;
    map['isSaved'] = this.isSaved;
    return map;
  }

  Map toImageMap(){
    var map = Map<String, dynamic>();
    map['senderId'] = this.senderId;
    map['receiverId'] = this.receiverId;
    map['type'] = this.type;
    map['message'] = this.message;
    map['timestamp'] = this.serverTime;
    map['photoUrl'] = this.photoUrl;
    map['isSaved'] = this.isSaved;
    return map;
  }

  // named constructor
  Message.fromMap(Map<String, dynamic> map) {
    this.senderId = map['senderId'];
    this.receiverId = map['receiverId'];
    this.type = map['type'];
    this.message = map['message'];
    this.timestamp = map['timestamp'];
    this.photoUrl = map['photoUrl'];
    this.isSaved = map['isSaved'];
  }
}