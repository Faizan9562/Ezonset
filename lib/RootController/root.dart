import 'package:ezonset/Controller/userController/userController.dart';
import 'package:ezonset/Model/user.dart';
import 'package:ezonset/View/Screens/Profile/profile_setup.dart';
import 'package:ezonset/View/Screens/Splash/splash.dart';
import 'package:ezonset/View/Screens/homepage.dart';
import 'package:ezonset/View/Screens/Auth/login.dart';
import 'package:ezonset/View/Screens/Auth/register.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

enum AuthStatus {
  firstTime,
  authenticating,
  notLoggedIn,
  loggedInhome,
  noProfile,
}

class OurRoot extends StatefulWidget {
  OurUser myUser;

  OurRoot({this.myUser});
  @override
  _OurRootState createState() => _OurRootState();
}

class _OurRootState extends State<OurRoot> {
  OurUser _currentUser;
  AuthStatus _authStatus = AuthStatus.authenticating;
  Future<OurUser> _future;
  int lastStartupNumber;
  
  
//==================APP AUTHENTICATION SECTION===================
  @override
  Widget build(BuildContext context) {
    OurUser currentUser;
    UserController _userController =
              Provider.of<UserController>(context, listen: false);
    UserController _curruser = Provider.of<UserController>(context);

    setState(() {
      currentUser = _curruser.getCurrentUser;
    });

    return FutureBuilder<OurUser>(
      future: null,
      builder: (context, snapshot) {
        if (currentUser.uid == null) {
          _authStatus = AuthStatus.notLoggedIn;
        }

        if (currentUser.uid != null) {
          if (currentUser.displayName == null) {
            _authStatus = AuthStatus.noProfile;
          }
          if (currentUser.displayName != null) {
            _authStatus = AuthStatus.loggedInhome;
          }
        }

        switch (_authStatus) {
          case AuthStatus.authenticating:
            return loader();
            break;
          case AuthStatus.noProfile:
            return profileSetup();
            break;

          case AuthStatus.notLoggedIn:
            return login();
            break;
          case AuthStatus.loggedInhome:
            return homepage(widget.myUser);
            break;
          // case AuthStatus.firstTime:
          //   return onboarding();
          //   break;
          default:
        }
      },
    );
  }

  Widget homepage(OurUser cur) {
    return Homepage(
      myUser: _currentUser,
    );
  }

  // Widget onboarding() {
  //   return OnBoardingPage();
  // }

  Widget register() {
    return Register();
  }

  Widget login() {
    return Login();
  }

  Widget profileSetup() {
    return ProfileSetup();
  }

  Widget loader() {
    return Splash();
  }
}

//###############################################################
