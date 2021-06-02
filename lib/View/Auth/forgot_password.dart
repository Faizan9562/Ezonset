import 'package:achievement_view/achievement_view.dart';
import 'package:crisislink/Widgets/TextWidgets/nunito_text.dart';
import 'package:crisislink/Widgets/TextWidgets/rounded_textfield.dart';
import 'package:crisislink/Widgets/progressBtn/flutter_progress_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ForgotPassword extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController emailCont = new TextEditingController();
  TextEditingController emailController = new TextEditingController();

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
        body: Container(
          width: w * 100,
          height: h * 100,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: h * 9.954,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 150,
                      child: Image.asset("assets/images/logo.png"),
                    ),
                    SizedBox(
                      height: h * 4.9773,
                    ),
                    NunitoText(
                      text: "Forgot your Password ?",
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ],
                ),
                SizedBox(
                  height: h * 4.9773,
                ),
                Column(
                  children: <Widget>[
                    Image.asset(
                      "assets/images/Forgotpassword.png",
                      width: w * 38.194,
                    ),
                    SizedBox(
                      height: h * 4.9773,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 5.0925),
                      child: Text(
                        "To request for a new one, type your email address below. A link to reset the password will be sent to that email.",
                        textScaleFactor: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: h * 2.4886,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 2 * h, horizontal: 6 * w),
                  child: Column(
                    children: <Widget>[
                      Hero(
                        tag: "Email",
                        child: RoundedTextField(
                          hint: "Enter Your Email",
                          type: TextInputType.emailAddress,
                          obsecureText: false,
                          icon: Icon(Icons.email_outlined),
                          iconColor: Colors.cyan,
                          label: "Email",
                          controller: emailController,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 3 * h, horizontal: 20 * w),
                        child: ProgressButton(
                            borderRadius: 10,
                            color: Color(0xff00d8cd),
                            animate: false,
                            defaultWidget: Text(
                              'SEND',
                              style: TextStyle(
                                fontSize: w * 4.0555,
                                letterSpacing: 2,
                                color: Colors.white,
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w900,
                              ),
                              textScaleFactor: 1,
                              textAlign: TextAlign.center,
                            ),
                            progressWidget: SpinKitThreeBounce(
                              color: Colors.white,
                              size: w * 5.0925,
                            ),
                            width: double.infinity,
                            height: 5 * h,
                            onPressed: () async {
                              try {
                                await resetPassword(emailCont.text);
                                AchievementView(context,
                                    color: Colors.green,
                                    icon: Icon(
                                      FontAwesomeIcons.bug,
                                      color: Colors.white,
                                    ),
                                    title: "Success !",
                                    elevation: 20,
                                    subTitle:
                                        "A link has been sent to your email.",
                                    isCircle: true, listener: (status) {
                                  print(status);
                                })
                                  ..show();
                              } catch (e) {
                                AchievementView(context,
                                    color: Colors.red,
                                    icon: Icon(
                                      FontAwesomeIcons.bug,
                                      color: Colors.white,
                                    ),
                                    title: "Error !",
                                    elevation: 20,
                                    subTitle: "${e.message}",
                                    isCircle: true, listener: (status) {
                                  print(status);
                                })
                                  ..show();
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
