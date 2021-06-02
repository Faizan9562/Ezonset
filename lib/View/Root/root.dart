import 'package:crisislink/Controller/user_controller.dart';
import 'package:crisislink/Enums/auth_status.dart';
import 'package:crisislink/Model/user.dart';
import 'package:crisislink/View/Admin%20View/adminDashboard.dart';
import 'package:crisislink/View/Auth/getting_Started.dart';
import 'package:crisislink/View/Auth/register.dart';
import 'package:crisislink/View/Homepage/homepage_admin.dart';
import 'package:crisislink/View/ProfileViews/ProfileSetup/profile_setup.dart';
import 'package:crisislink/View/ProfileViews/ProfileSetup/profile_setup2.dart';
import 'package:crisislink/View/ProfileViews/ProfileSetup/profile_setup4.dart';
import 'package:crisislink/View/ProfileViews/ProfileSetup/profile_setup5.dart';
import 'package:crisislink/View/TMDashboard/TMDashboard.dart';
import 'package:crisislink/View/User%20View/StempDashboard/stempDashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Root extends StatelessWidget {
  AuthStatus _authStatus = AuthStatus.authenticating;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    UserController _currentUser = Provider.of<UserController>(context);
    OurUser myUser = _currentUser.getCurrentUser;

    if (auth.currentUser == null) {
      _authStatus = AuthStatus.notLoggedIn;
    }

    if (myUser.uid != null) {
      if (myUser.useranme == null) {
        _authStatus = AuthStatus.noProfile;
      }
      if(myUser.step == 1) {
        _authStatus = AuthStatus.profileTwo;
      }
      if(myUser.step == 4) {
        _authStatus = AuthStatus.profileFive;
      }
      if(myUser.step == 7) {
        _authStatus = AuthStatus.profileSeven;
      }
      if(myUser.step == 10) {
        if(myUser.type == "Employee" || myUser.type == "Student") {
          _authStatus = AuthStatus.stemp;
        }
        if(myUser.type == "Teacher" || myUser.type == "Manager") {
          _authStatus = AuthStatus.tm;
        }
      }
    }

    print(myUser.step);

    switch (_authStatus) {
      case AuthStatus.authenticating:
        return Scaffold(body: CircularProgressIndicator());
        break;
      case AuthStatus.noProfile:
        return ProfileSetup();
        break;
      case AuthStatus.notLoggedIn:
        return Register();
        break;
      case AuthStatus.profileTwo:
        return ProfileSetupTwo();
        break;
      case AuthStatus.profileFive:
        return ProfileSetupFive();
        break;
      case AuthStatus.profileSeven:
        return AdminDashboard();
        break;
      case AuthStatus.stemp:
        return StempDashboard();
        break;
      case AuthStatus.tm:
        return TMDashboard();
        break;
      default:
    }
  }
}
