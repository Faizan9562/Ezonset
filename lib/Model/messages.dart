import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String subject;
  String description;
  String receiverUserName;
  String senderId;
  String receiverId;
  String type;
  dynamic timestamp;
  String sender_userName;
  String ticketId;
  String otherPersonId;
  String photoUrl;

  Message({
    this.senderId,
    this.receiverId,
    this.type,
    this.description,
    this.otherPersonId,
    this.receiverUserName,
    this.sender_userName,
    this.subject,
    this.ticketId,
    this.timestamp,
  });

  Message.imageMessage(
      {this.senderId,
      this.receiverId,
      this.type,
      this.description,
      this.otherPersonId,
      this.receiverUserName,
      this.sender_userName,
      this.subject,
      this.ticketId,
      this.timestamp,
      this.photoUrl});

  Map toMap() {
    var map = Map<String, dynamic>();
    map['sender_Id'] = this.senderId;
    map['receiver_Id'] = this.receiverId;
    map['type'] = this.type;
    map['description'] = this.description;
    map['otherPersonId'] = this.otherPersonId;
    map['receiver_userName'] = this.receiverUserName;
    map['sender_userName'] = this.sender_userName;
    map['subject'] = this.subject;
    map['ticketId'] = this.ticketId;
    map['timestamp'] = this.timestamp;
    return map;
  }

  Map toImageMap() {
    var map = Map<String, dynamic>();
    map['sender_Id'] = this.senderId;
    map['receiver_Id'] = this.receiverId;
    map['type'] = this.type;
    map['description'] = this.description;
    map['otherPersonId'] = this.otherPersonId;
    map['receiver_userName'] = this.receiverUserName;
    map['sender_userName'] = this.sender_userName;
    map['subject'] = this.subject;
    map['ticketId'] = this.ticketId;
    map['timestamp'] = this.timestamp;
    return map;
  }

  // named constructor
  Message.fromMap(Map<String, dynamic> map) {
    this.senderId = map['sender_Id'];
    this.receiverId = map['receiver_Id'];
    this.type = map['type'];
    this.description = map['description'];
    this.otherPersonId = map['otherPersonId'];
    this.receiverUserName = map['receiver_userName'];
    this.sender_userName = map['sender_userName'];
    this.subject = map['subject'];
    this.ticketId = map['ticketId'];
    this.timestamp = map['timestamp'];
  }
}
