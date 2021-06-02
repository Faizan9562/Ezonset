import 'package:crisislink/Controller/user_controller.dart';
import 'package:crisislink/View/Admin%20View/add_members.dart';
import 'package:crisislink/View/Auth/login.dart';
import 'package:crisislink/Onboard/onboarding.dart';
import 'package:crisislink/View/Homepage/homepage_admin.dart';
import 'package:crisislink/View/ProfileViews/ProfileSetup/profile_setup.dart';
import 'package:crisislink/View/ProfileViews/ProfileSetup/profile_setup2.dart';
import 'package:crisislink/View/ProfileViews/ProfileSetup/profile_setup3.dart';
import 'package:crisislink/View/ProfileViews/ProfileSetup/profile_setup4.dart';
import 'package:crisislink/View/ProfileViews/ProfileSetup/profile_setup5.dart';
import 'package:crisislink/View/ProfileViews/ProfileSetup/profile_setup6.dart';
import 'package:crisislink/View/Root/root.dart';
import 'package:crisislink/View/User%20View/ProfileViews/profile_setup7.dart';
import 'package:crisislink/View/User%20View/ProfileViews/profile_setup8.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String wid;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    if (_seen) {
      return "Seen";
    } else {
      await prefs.setBool('seen', true);
      return "Not Seen";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkFirstSeen().then((value) => wid = value);
  }

  @override
  Widget build(BuildContext context) {
    UserController _currentUser = Provider.of<UserController>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SplashScreen.navigate(
        name: 'assets/flare/splash.flr',
        next: (context) {
          if (wid == "Seen") {
            return WillPopScope(
              onWillPop: () async {
                MoveToBackground.moveTaskToBack();
                return false;
              },
              child: Root(),
            );
          } else if (wid == "Not Seen") {
            return OnBoardingPage();
          }
        },
        until: () async {
          await _currentUser.getCurrentUserInfo();
        },
        startAnimation: 'splash',
      ),
    );
  }
}
