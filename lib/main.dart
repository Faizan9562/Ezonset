import 'package:crisislink/Controller/user_controller.dart';
import 'package:crisislink/Providers/login_validation.dart';
import 'package:crisislink/Providers/register_validation.dart';
import 'package:crisislink/View/Auth/login.dart';
import 'package:crisislink/View/Auth/register.dart';
import 'package:crisislink/View/ProfileViews/ProfileSetup/profile_setup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:crisislink/View/Splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(CrisisLink());
}

class CrisisLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserController()),
        ChangeNotifierProvider(create: (_) => LoginValidation()),
        ChangeNotifierProvider(create: (_) => RegisterValidation()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CrisisLink',
        routes: {
          "/login": (context) => Login(),
          "/register": (context) => Register(),
          "/profileSetup": (context) => ProfileSetup(),
        },
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Splash();
  }
}