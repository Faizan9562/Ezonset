import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crisislink/Model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as Im;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserController with ChangeNotifier {
  OurUser _currentUser = OurUser();
  OurUser get getCurrentUser => _currentUser;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<bool> registerUser(String email, String password) async {
    bool retVal = false;
    OurUser _user = OurUser();
    try {
      UserCredential _authResult = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _authResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (_authResult.user != null) {
        _user.uid = _authResult.user.uid;
        _user.email = _authResult.user.email;
        String fcmToken = await firebaseMessaging.getToken();
        try {
          await _firestore.collection("users").doc(_user.uid).set({
            "uid": _user.uid,
            "email": _user.email,
            "accountCreated": Timestamp.now(),
            "avatarUrl": _user.avatarUrl,
            "username": _user.useranme,
            "country": _user.country,
            "displayName": _user.displayName,
            "token": fcmToken,
            "type" : null,
          });
          _currentUser = _user;
          retVal = true;
        } catch (e) {
          retVal = false;
          print(e);
        }
      }
    } catch (e) {
      retVal = false;
      print(e);
    }
    notifyListeners();
    return retVal;
  }

  //Gets credentials from UI and passes onto the Db service to login
  Future<bool> loginUser(String email, String password) async {
    bool response = false;
    try {
      UserCredential _authResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (_authResult.user != null) {
        OurUser _retrivedUser = OurUser();
        try {
          DocumentSnapshot _documentSnapshot = await _firestore
              .collection("users")
              .doc(_authResult.user.uid)
              .get();
          Map<String, dynamic> snapshotData = _documentSnapshot.data();
          _retrivedUser.uid = auth.currentUser.uid;
          _retrivedUser.email = snapshotData["email"];
          _retrivedUser.accountCreated = snapshotData["accountCreated"];
          _retrivedUser.avatarUrl = snapshotData["avatarUrl"];
          _retrivedUser.useranme = snapshotData["username"];
          _retrivedUser.displayName = snapshotData["displayName"];
          _retrivedUser.country = snapshotData["country"];
          _retrivedUser.step = snapshotData["step"];
          _retrivedUser.type = snapshotData["type"];
          _currentUser = _retrivedUser;
          setToken(_currentUser);
          response = true;
        } catch (e) {
          response = false;
          print(e);
        }
      }
    } catch (e) {
      response = false;
      print(e);
    }
    notifyListeners();
    return response;
  }

  Future<bool> signOut() async {
    bool retVal = false;
    try {
      await auth.signOut();
      _currentUser = OurUser();
      retVal = true;
    } catch (e) {
      retVal = false;
      print(e);
    }
    notifyListeners();
    return retVal;
  }

  setToken(OurUser user) async {
    String fcmToken = await firebaseMessaging.getToken();
    try {
      await _firestore.collection("users").doc(user.uid).update({
        "token": fcmToken,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<bool> updateDisplay(String name) async {
    try {
      print("The name to update is : $name");
      print(auth.currentUser.uid);
      await _firestore
          .collection("users")
          .doc(auth.currentUser.uid)
          .update({"displayName": name});
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  bool isUploading = false;
  File file;
  ImagePicker img = ImagePicker();
  String postId = Uuid().v4();

  Future<bool> updateAvatar(String uid) async {
    Future<String> uploadImage(imageFile, String uid) async {
      String downloadUrl;
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child("profilePictures/$uid.jpg")
          .putFile(imageFile);
      await uploadTask.whenComplete(() async {
        print("about to aquire");
        downloadUrl = await uploadTask.snapshot.ref.getDownloadURL();
      });
      print("after aquire");
      return downloadUrl;
    }

    updatePostInFirestore({String mediaUrl, String uid}) async {
      print("THE POST ID IS $postId");
      print(uid);
      await FirebaseFirestore.instance.collection("users").doc(uid).update({
        "avatarUrl": mediaUrl,
      });
      await getCurrentUserInfo();
      notifyListeners();
    }

    compressImage() async {
      final tempDir = await getTemporaryDirectory();
      final path = tempDir.path;
      Im.Image imageFile = Im.decodeImage(file.readAsBytesSync());
      final compressedImageFile = File("$path/img_$postId.jpg")
        ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 90));
      file = compressedImageFile;
    }

    uploadToStorage(String uid) async {
      isUploading = true;
      await compressImage();
      print("here 1");
      String mediaUrl = await uploadImage(file, uid);
      await updatePostInFirestore(mediaUrl: mediaUrl, uid: uid);
      isUploading = false;
      postId = Uuid().v4();
    }

    handleChooseFromGallery(String uid) async {
      var getImage = await img.getImage(
          source: ImageSource.gallery, maxWidth: 1920, maxHeight: 1080);
      File file = File(getImage.path);

      this.file = file;
      if (file != null) {
        await uploadToStorage(uid);
      }
    }

    handleChooseFromGallery(uid);

    return true;
  }


  Future<bool> updatePicture(String uid) async {
    Future<String> uploadImage(imageFile, String uid) async {
      String downloadUrl;
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child("organizationsLogo/$uid.jpg")
          .putFile(imageFile);
      await uploadTask.whenComplete(() async {
        print("about to aquire");
        downloadUrl = await uploadTask.snapshot.ref.getDownloadURL();
      });
      print("after aquire");
      return downloadUrl;
    }

    updatePostInFirestore({String mediaUrl, String uid}) async {
      print("THE POST ID IS $postId");
      print(uid);
      await FirebaseFirestore.instance.collection("CrisisLink").doc(uid).update({
        "organizationLogo": mediaUrl,
      });
      await getCurrentUserInfo();
      notifyListeners();
    }

    compressImage() async {
      final tempDir = await getTemporaryDirectory();
      final path = tempDir.path;
      Im.Image imageFile = Im.decodeImage(file.readAsBytesSync());
      final compressedImageFile = File("$path/img_$postId.jpg")
        ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 90));
      file = compressedImageFile;
    }

    uploadToStorage(String uid) async {
      isUploading = true;
      await compressImage();
      print("here 1");
      String mediaUrl = await uploadImage(file, uid);
      await updatePostInFirestore(mediaUrl: mediaUrl, uid: uid);
      isUploading = false;
      postId = Uuid().v4();
    }

    handleChooseFromGallery(String uid) async {
      var getImage = await img.getImage(
          source: ImageSource.gallery, maxWidth: 1920, maxHeight: 1080);
      File file = File(getImage.path);

      this.file = file;
      if (file != null) {
        await uploadToStorage(uid);
      }
    }

    handleChooseFromGallery(uid);

    return true;
  }

  Future<bool> updateUsername(String username) async {
    try {
      await _firestore
          .collection("users")
          .doc(_currentUser.uid)
          .update({"username": username});
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  Future<bool> updateGender(String gender) async {
    try {
      await _firestore
          .collection("users")
          .doc(_currentUser.uid)
          .update({"gender": gender});
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  Future<bool> updateInterestedIn(String gender) async {
    try {
      await _firestore
          .collection("users")
          .doc(_currentUser.uid)
          .update({"interestedIn": gender});
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  Future<bool> updateCountry(String country) async {
    try {
      await _firestore
          .collection("users")
          .doc(_currentUser.uid)
          .update({"country": country});
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  Future<bool> updatePushNotifications(bool push) async {
    try {
      await _firestore
          .collection("users")
          .doc(_currentUser.uid)
          .update({"pushNotifications": push});
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  Future<bool> updateProfileSetupStep(int step) async {
    try {
      await _firestore
          .collection("users")
          .doc(_currentUser.uid)
          .update({"step": step});
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  Future<OurUser> getCurrentUserInfo() async {
    try {
      DocumentSnapshot _documentSnapshot =
          await _firestore.collection("users").doc(auth.currentUser.uid).get();
      Map<String, dynamic> snapshotData = _documentSnapshot.data();
      print(snapshotData["accountCreated"]);
      _currentUser.uid = auth.currentUser.uid;
      _currentUser.email = snapshotData["email"];
      _currentUser.accountCreated = snapshotData["accountCreated"];
      _currentUser.avatarUrl = snapshotData["avatarUrl"];
      _currentUser.useranme = snapshotData["username"];
      _currentUser.displayName = snapshotData["displayName"];
      _currentUser.country = snapshotData["country"];
      _currentUser.step = snapshotData["step"];
      _currentUser.type = snapshotData["type"];
      notifyListeners();
      return _currentUser;
    } catch (e) {
      print(e);
    }
  }
}

//   Future<void> addMessagetoDb(
//       Message message, OurUser sender, OurUser receiver) {
//     UserDatabase().addMessageToDb(message, sender, receiver);
//   }

//   uploadImage(
//           {@required File image,
//           @required OurUser receiver,
//           @required OurUser sender,
//           @required ImageUploadProvider imageUploadProvider}) =>
//       UserDatabase().uploadImage(image, receiver, sender, imageUploadProvider);

//   //All Methods Below Retrieve data from DB for the current user

//   Future<String> updatePushNotifications() async {
//     await UserDatabase().updatePushNotification(true, _currentUser.uid);
//     return "Success";
//   }

//   Future<String> setSecurityQues(String question) async {
//     await UserDatabase().setSecurityQuestion(question, _currentUser.uid);
//   }

//   Future<String> setSecurityAns(String answer) async {
//     await UserDatabase().setSecurityAnswer(answer, _currentUser.uid);
//   }
// }
