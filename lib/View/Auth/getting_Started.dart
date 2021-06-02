import 'package:crisislink/View/Auth/login.dart';
import 'package:crisislink/View/Auth/register.dart';
import 'package:crisislink/Widgets/GradientButton/GradientButton.dart';
import 'package:crisislink/Widgets/TextWidgets/nunito_text.dart';
import 'package:crisislink/Widgets/TextWidgets/poppins_text.dart';
import 'package:crisislink/Widgets/TextWidgets/nunito_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

class GettingStarted extends StatelessWidget {
  void _launchSocial(String url, String fallbackUrl) async {
    // Don't use canLaunch because of fbProtocolUrl (fb://)
    try {
      bool launched =
          await launch(url, forceSafariVC: false, forceWebView: false);
      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 120,
                        child: Hero(
                          tag: "Logo",
                          child: Image.asset(
                            "assets/images/logo.png",
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(25),
                      child: NunitoText(
                        text:
                            "Look for new people around the world. Connect and show how you feel",
                        align: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: 300,
                      height: 50,
                      child: Hero(
                        tag: "Login",
                        child: GradientButton(
                          title: "LOGIN",
                          clrs: [Color(0xffFF66FF), Color(0xffFF00FB)],
                          onpressed: () {
                            Navigator.pushReplacement(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                duration: Duration(milliseconds: 200),
                                curve: Curves.easeIn,
                                child: Login(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 300,
                      height: 50,
                      child: Hero(
                        tag: "Register",
                        child: GradientButton(
                          title: "REGISTER",
                          clrs: [Color(0xff8B97FB), Color(0xff8D49FE)],
                          onpressed: () {
                            Navigator.pushReplacement(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                duration: Duration(milliseconds: 200),
                                curve: Curves.easeIn,
                                child: Register(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: Container(
                              width: 50,
                              height: 50,
                              child: Image.asset("assets/icons/fb.png"),
                            ),
                            onTap: () {
                              _launchSocial(
                                  'https://www.facebook.com/ciaynOfficial/',
                                  '');
                            },
                          ),
                          GestureDetector(
                            child: Container(
                              width: 50,
                              height: 50,
                              child: Image.asset("assets/icons/insta.png"),
                            ),
                            onTap: () {
                              _launchSocial(
                                  'https://www.instagram.com/ciaynOfficial/',
                                  '');
                            },
                          ),
                          GestureDetector(
                            child: Container(
                              width: 50,
                              height: 50,
                              child: Image.asset("assets/icons/twitter.png"),
                            ),
                            onTap: () {
                              _launchSocial(
                                  'https://www.twitter.com/ciaynOfficial/', '');
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      child: Divider(
                        thickness: 1,
                        color: Colors.pink,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    NunitoText(
                      text: "OR",
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 100,
                      child: Divider(
                        thickness: 1,
                        color: Colors.pink,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 250,
                        child: Image.asset(
                          "assets/images/logov4.png",
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                      child: NunitoText(
                        text: "Already have a spouse and ready to connect ?",
                        align: TextAlign.center,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Container(
                        //   width: 150,
                        //   child: Image.asset("assets/images/appstore.png"),
                        // ),
                        GestureDetector(
                          child: Container(
                            width: 200,
                            child: Image.asset("assets/images/playstore.png"),
                          ),
                          onTap: () {
                            _launchSocial(
                                "https://play.google.com/store/apps/details?id=com.ciayn.couple.diary.todo.horoscope.mood.gallery",
                                "");
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
