import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezonset/Model/message.dart';
import 'package:ezonset/Model/user.dart';
import 'package:ezonset/Providers/image_upload_provider.dart';
import 'package:ezonset/Services/userDatabase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserController with ChangeNotifier {
  OurUser _currentUser = OurUser();
  OurUser _userFriend = OurUser();

  OurUser get getCurrentUser => _currentUser;

  FirebaseAuth auth = FirebaseAuth.instance;
  Firestore _firestore = Firestore.instance;
  

  //Gets credentials from UI and passes onto the Db service to register
  Future<bool> registerUser(String email, String password) async {
    bool retVal = false;
    OurUser _user = OurUser();
    try {
      AuthResult _authResult = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      AuthResult _authsResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (_authResult.user != null) {
        print("Adding to database");
        _user.uid = _authResult.user.uid;
        _user.email = _authResult.user.email;
        _user.password = password;
        String _returnString = await UserDatabase().createUser(_user);
        print("TheReturnStringIS: $_returnString");
        if (_returnString == "Success") {
          retVal = true;
        }
      }
    } catch (e) {
      print(e);
    }
    return retVal;
  }

 //Gets credentials from UI and passes onto the Db service to login
  Future<bool> loginUser(String email, String password) async {
    bool response = false;
    try {
      AuthResult _authResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (_authResult.user != null) {
        print("Signing User In");
        _currentUser = await UserDatabase().getUserInfoById(_authResult.user.uid);
        if (_currentUser != null) {
          response = true;
        }

        setToken(_currentUser);
      }
    } catch (e) {
      print(e);
    }
    return response;
  }

  Future<String> signOut() async {
    String retVal = 'error';
    try {
      await auth.signOut();
      _currentUser = OurUser();

      retVal = "Success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }


  Future<OurUser> getCurrentUserInfo() async {
    try {
      FirebaseUser _firebaseUser = await auth.currentUser();
      this._currentUser = await UserDatabase.instance.getUserInfoById(_firebaseUser.uid);
      print("this ${_currentUser.uid}");
      return _currentUser;
    } catch (e) {
      print(e);
    }
  }

  Future<void> addMessagetoDb(Message message, OurUser sender, OurUser receiver) {
    UserDatabase().addMessageToDb(message, sender, receiver);
  }

  setToken(OurUser user) async {
    await UserDatabase().setToken(user);
  }

  uploadImage({@required File image,
    @required OurUser receiver,
    @required OurUser sender,
    @required ImageUploadProvider imageUploadProvider}) => UserDatabase().uploadImage(image,receiver,sender,imageUploadProvider);

  //All Methods Below Retrieve data from DB for the current user
  Future<String> updateAvatar(String url) async {
    await UserDatabase().updateAvatarPicture(url, _currentUser.uid);
    return "Success";
  }

  Future<String> updateUsername(String username) async {
    await UserDatabase().updateUsername(username, _currentUser.uid);
    return "Success";
  }

  Future<String> updateDisplay(String name) async {
    await UserDatabase().updateDisplayName(name, _currentUser.uid);
    return "Success";
  }

  Future<String> updateGender(String gender) async {
    await UserDatabase().updateGender(gender, _currentUser.uid);
    return "Success";
  }


  Future<String> updatePushNotifications() async {
    await UserDatabase().updatePushNotification(true, _currentUser.uid);
    return "Success";
  }

  Future<String> updateCountry(String country) async {
    await UserDatabase().updateCountry(country, _currentUser.uid);
    return "Success";
  }

  Future<String> setSecurityQues(String question) async {
    await UserDatabase().setSecurityQuestion(question, _currentUser.uid);
  }

  Future<String> setSecurityAns(String answer) async {
    await UserDatabase().setSecurityAnswer(answer, _currentUser.uid);
  }  
}
