import 'package:ezonset/View/Screens/Auth/login.dart';
import 'package:ezonset/View/Screens/Auth/register.dart';
import 'package:ezonset/View/Widgets/GradientButton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class First extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "EzOnset",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w900,
                  fontSize: 40),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: GradientButton(
              clrs: [Colors.deepOrange, Colors.orange],
              title: "Login",
              onpressed: (){
                Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => Login()));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: GradientButton(
              clrs: [Colors.deepOrange, Colors.orange],
              title: "Register",
              onpressed: (){
                Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => Register()));
              },
            ),
          ),
          
          SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset("assets/images/fb.png", width: 50,),
              Image.asset("assets/images/insta.png", width: 50,),
              Image.asset("assets/images/twitter.png", width: 50,),
            ],
          ),
        ],
      ),
    );
  }
}
