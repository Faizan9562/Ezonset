import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezonset/Model/message.dart';
import 'package:ezonset/Model/user.dart';
import 'package:ezonset/Providers/image_upload_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';


class UserDatabase {
  static UserDatabase instance = UserDatabase();
  final Firestore _firestore = Firestore.instance;
  final DBRef = FirebaseDatabase.instance.reference();
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  StorageReference _storageReference;


  //CREATE USERS TO FIREBASE
  Future<String> createUser(OurUser user) async {
    String fcmToken = await firebaseMessaging.getToken();

    String retVal = "error";
    try {
      await _firestore.collection("users").document(user.uid).setData({
        "uid": user.uid,
        "email": user.email,
        "password": user.password,
        "accountCreated": Timestamp.now(),
        "avatarUrl": user.avatarUrl,
        "username": user.useranme,
        "country": user.country,
        "displayName": user.displayName,
        "token" : fcmToken,
      });
      retVal = "Success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  setToken(OurUser user) async {
    String fcmToken = await firebaseMessaging.getToken(); 
    try {
      await _firestore.collection("users").document(user.uid).updateData({
        "token" : fcmToken,
      });
    } catch (e) {
    }
  }

  //GET USER INFO TO UPDATE CURRENT USER
  Future<OurUser> getUserInfoById(String uid) async {
    OurUser retVal = OurUser();
    try {
      DocumentSnapshot _documentSnapshot =
          await _firestore.collection("users").document(uid).get();
      retVal.uid = uid;
      retVal.email = _documentSnapshot.data["email"];
      retVal.accountCreated = _documentSnapshot.data["accountCreated"];
      retVal.avatarUrl = _documentSnapshot.data["avatarUrl"];
      retVal.useranme = _documentSnapshot.data["username"];
      retVal.displayName = _documentSnapshot.data["displayName"];
      retVal.country = _documentSnapshot.data["country"];
      retVal.gender = _documentSnapshot.data["gender"];
      retVal.phone = _documentSnapshot.data["phone"];
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Stream<List<OurUser>> searchUsersInDB(String _searchName) {
    try {
      var _ref = _firestore
          .collection("users")
          .where("username", isEqualTo: _searchName)
          .where(
            "uid",
          );
      return _ref.getDocuments().asStream().map((_snapshot) {
        return _snapshot.documents.map((_doc) {
          return OurUser.fromFireStore(_doc);
        }).toList();
      });
    } catch (e) {
      print("The error is $e");
    }
  }




  Future<void> addMessageToDb(
      Message message, OurUser sender, OurUser receiver) async {

    var map = message.toMap();

    print("SenderUid ${sender.uid}");
    
    await _firestore
        // .collection("messages").document(sender.chatRoomId)
        .collection("value")
        .add(map);

    

    // await DBRef.child("messages/${message.senderId}/${message.receiverId}")
    //     .push()
    //     .set({
    //   "senderId": map["senderId"],
    //   "receiverId": map['receiverId'],
    //   "type": map['type'],
    //   'message': map['message'],
    //   "timestamp": Timestamp.now().toDate().toString(),
    // });

    // await DBRef.child("messages/${message.receiverId}/${message.senderId}")
    //     .push()
    //     .set({
    //   "senderId": map["senderId"],
    //   "receiverId": map['receiverId'],
    //   "type": map['type'],
    //   'message': map['message'],
    //   "timestamp": Timestamp.now().toDate().toString(),
    // });
  }

  //Update Profile Picture to the Firebase
  Future<void> updateAvatarPicture(String url, String uid) async {
    try {
      await _firestore
          .collection("users")
          .document(uid)
          .updateData({"avatarUrl": url});
    } catch (e) {
      print(e);
    }
  }

  //Update Username of the user in Firebase
  Future<void> updateUsername(String username, String uid) async {
    try {
      await _firestore
          .collection("users")
          .document(uid)
          .updateData({"username": username});
    } catch (e) {
      print(e);
    }
  }

  //Update country of the user in Firebase
  Future<void> updateCountry(String country, String uid) async {
    try {
      await _firestore
          .collection("users")
          .document(uid)
          .updateData({"country": country});
    } catch (e) {
      print(e);
    }
  }


  Future<void> updateGender(String gender, String uid) async {
    try {
      await _firestore
          .collection("users")
          .document(uid)
          .updateData({"gender": gender});
    } catch (e) {
      print(e);
    }
  }

  Future<void> updatePushNotification(bool push, String uid) async {
    try {
      await _firestore
          .collection("users")
          .document(uid)
          .updateData({"pushNotifications": push});
    } catch (e) {
      print(e);
    }
  }

  //Update DisplayName of the user in Firebase
  Future<void> updateDisplayName(String name, String uid) async {
    try {
      await _firestore
          .collection("users")
          .document(uid)
          .updateData({"displayName": name});
    } catch (e) {
      print(e);
    }
  }

  //Update SecurityQuestion of the user in Firebase
  Future<void> setSecurityQuestion(String question, String uid) async {
    try {
      await _firestore
          .collection("securityQuestions")
          .document(uid)
          .updateData({"question": question});
    } catch (e) {
      print(e);
    }
  }

  //Update SecurityAnswer of the user in Firebase
  Future<void> setSecurityAnswer(String answer, String uid) async {
    try {
      await _firestore
          .collection("securityQuestions")
          .document(uid)
          .updateData({"answer": answer});
    } catch (e) {
      print(e);
    }
  }

  Future<String> uploadImageToStorage(File image, OurUser sender) async {
    try {
      _storageReference = FirebaseStorage.instance
          .ref()
          .child(sender.uid).child("messageImages");
      StorageUploadTask _storageUploadTask = _storageReference.putFile(image);
      var url =
          await (await _storageUploadTask.onComplete).ref.getDownloadURL();
      print(url);
      return url;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void setImageMsg(String url, OurUser receiver, OurUser sender) async {
    Message _message;

    _message = Message.imageMessage(
        message: "Image",
        receiverId: receiver.uid,
        senderId: sender.uid,
        photoUrl: url,
        type: 'image',
        serverTime: FieldValue.serverTimestamp());
    var map = _message.toImageMap();

    // add the data to Db
    print("uploading image to database");
    await _firestore
        .collection("messages")
        // .document(sender.chatRoomId).collection("value")
        .add(map);

    // await DBRef.child("messages/${_message.senderId}/${_message.receiverId}")
    //     .push()
    //     .set({
    //   "senderId": map["senderId"],
    //   "receiverId": map['receiverId'],
    //   "type": map['type'],
    //   'message': map['message'],
    //   "photoUrl": map['photoUrl'],
    //   "timestamp": Timestamp.now().toString(),
    // });

    // await DBRef.child("messages/${_message.receiverId}/${_message.senderId}")
    //     .push()
    //     .set({
    //   "senderId": map["senderId"],
    //   "receiverId": map['receiverId'],
    //   "type": map['type'],
    //   'message': map['message'],
    //   "photoUrl": map['photoUrl'],
    //   "timestamp": Timestamp.now().toString(),
    // });
  }

  Future<void> uploadImage(File image, OurUser receiver, OurUser sender,
      ImageUploadProvider imageUploadProvider) async {
    imageUploadProvider.setToLoading();
    String url = await uploadImageToStorage(image, sender);
    imageUploadProvider.setToIdle();
    setImageMsg(url, receiver, sender);
  }

  addNotification(String receiverId, String message){
    _firestore.collection("users").document(receiverId).collection("notifications").add({
      "message" : message,
      "title" : "You have a new message"
    });
  }
}
