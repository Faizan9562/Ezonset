import 'package:ezonset/RootController/root.dart';
import 'package:ezonset/View/Screens/Splash/splash.dart';
import 'package:ezonset/View/Screens/homepage.dart';
import 'package:ezonset/View/Screens/first_main.dart';
import 'package:ezonset/View/Screens/Auth/login.dart';
import 'package:ezonset/View/Screens/Auth/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'Controller/userController/userController.dart';
import 'Controller/validationController/login_validation.dart';
import 'Controller/validationController/register_validation.dart';
import 'Providers/image_upload_provider.dart';
import 'package:flutter/services.dart' as sv;

void main() {
  runApp(
    Ezonset(),
  );
}

class Ezonset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      sv.DeviceOrientation.portraitUp,
      sv.DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginValidation()),
        ChangeNotifierProvider(create: (_) => RegisterValidation()),
        ChangeNotifierProvider(create: (_) => UserController()),
        ChangeNotifierProvider(create: (_) => ImageUploadProvider()),
      ],
      child: MaterialApp(
        // locale: DevicePreview.of(context).locale, // <--- Add the locale
        // builder: DevicePreview.appBuilder, // <--- Add the builder
        debugShowCheckedModeBanner: false,
        routes: {
          "/login": (context) => Login(),
          "/register": (context) => Register(),
          "/homepage": (context) => Homepage(),
          "/root": (context) => OurRoot(),
          "/splash": (context) => Splash(),
        },
        home: Splash(),
      ),
    );
  }
}
