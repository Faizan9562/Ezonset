import 'package:ezonset/Controller/userController/userController.dart';
import 'package:ezonset/Model/user.dart';
import 'package:ezonset/RootController/root.dart';
import 'package:ezonset/Services/app_retain.dart';
import 'package:flutter/material.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String wid;
  OurUser _currentUser;
  Future<OurUser> _future;
  UserController _userController;

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
    _userController = Provider.of<UserController>(context, listen: false);
    OurUser inf;
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      body: SplashScreen.navigate(
        name: 'assets/flare/splash.flr',
        until: () async {
          UserController _userController =
              Provider.of<UserController>(context, listen: false);
          inf = await _userController.getCurrentUserInfo();
        },
        next: (_) {
          return AppRetainWidget(
            child: OurRoot(myUser: inf),
          );

          // FOR ONBOARDING SCREEN
          // if (wid == "Seen") {

          //   return AppRetainWidget(
          //     child: OurRoot(myUser: _currentUser),
          //   );
          // } else if (wid == "Not Seen") {
          //   return OnBoardingPage();
          // }
        },
        startAnimation: 'Untitled',
      ),
    );
  }
}
