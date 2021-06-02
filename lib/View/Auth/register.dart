import 'package:achievement_view/achievement_view.dart';
import 'package:crisislink/Controller/user_controller.dart';
import 'package:crisislink/Providers/register_validation.dart';
import 'package:crisislink/View/Auth/login.dart';
import 'package:crisislink/Widgets/TextWidgets/nunito_text.dart';
import 'package:crisislink/Widgets/TextWidgets/poppins_text.dart';
import 'package:crisislink/Widgets/TextWidgets/rounded_textfield.dart';
import 'package:crisislink/Widgets/progressBtn/flutter_progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Register extends StatelessWidget {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  TextEditingController passConfirmController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    RegisterValidation validationService =
        Provider.of<RegisterValidation>(context);

    UserController _currentUser =
        Provider.of<UserController>(context, listen: false);

    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;

    Future<bool> successSnackBar(BuildContext context) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Success",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Nunito",
              fontWeight: FontWeight.w700,
              fontSize: 4 * w,
            ),
            textScaleFactor: 1,
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    }

    registerFailedSnackBar(BuildContext context) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Signup Failed",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Nunito",
              fontWeight: FontWeight.w700,
              fontSize: 4 * w,
            ),
            textScaleFactor: 1,
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }

    Future<bool> registerUser(
        String email, String password, BuildContext context) async {
      bool test = true;
      if (await _currentUser.registerUser(email, password)) {
        successSnackBar(context);
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacementNamed(context, "/profileSetup");
          return test;
        });
      } else {
        registerFailedSnackBar(context);
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 120,
                    child: Hero(
                      tag: "Logo",
                      child: Image.asset(
                        "assets/images/CLLogo.png",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                NunitoText(
                  text: "Let's Get Started!",
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
                NunitoText(
                  text: "Create a new account for CrisisLink",
                  clr: Colors.grey,
                  fontSize: 13,
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Flexible(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Hero(
                            tag: "Email",
                            child: RoundedTextField(
                              hint: "Enter Your Email",
                              type: TextInputType.emailAddress,
                              obsecureText: false,
                              icon: Icon(Icons.email_outlined),
                              iconColor: Colors.cyan,
                              label: "Email",
                              controller: emailController,
                              onChange: (text) {
                                validationService.changeEmail(text);
                              },
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 0,
                        child: validationService.email.error == null
                            ? SizedBox()
                            : Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: GestureDetector(
                                  child: Icon(
                                    Icons.error,
                                    color: Colors.deepOrange,
                                  ),
                                  onTap: () {
                                    AchievementView(
                                      context,
                                      color: Colors.deepOrange,
                                      icon: Icon(
                                        FontAwesomeIcons.bug,
                                        color: Colors.white,
                                      ),
                                      title: "Warning !",
                                      elevation: 20,
                                      subTitle: validationService.email.error,
                                      isCircle: true,
                                    )..show();
                                  },
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Flexible(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Hero(
                            tag: "Pass",
                            child: RoundedTextField(
                              hint: "Enter Your Password",
                              type: TextInputType.text,
                              obsecureText: true,
                              icon: Icon(Icons.lock),
                              iconColor: Colors.cyan,
                              label: "Password",
                              controller: passController,
                              onChange: (text) {
                                validationService.changePassword(text);
                              },
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 0,
                        child: validationService.password.error == null
                            ? SizedBox()
                            : Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: GestureDetector(
                                  child: Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                  onTap: () {
                                    AchievementView(
                                      context,
                                      color: Colors.red,
                                      icon: Icon(
                                        FontAwesomeIcons.bug,
                                        color: Colors.white,
                                      ),
                                      title: "Error !",
                                      elevation: 20,
                                      subTitle:
                                          validationService.password.error,
                                      isCircle: true,
                                    )..show();
                                  },
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Flexible(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: RoundedTextField(
                            hint: "Re-Enter Your Password",
                            type: TextInputType.text,
                            obsecureText: true,
                            icon: Icon(Icons.lock),
                            iconColor: Colors.cyan,
                            label: "Confirm Password",
                            controller: passConfirmController,
                            onChange: (text) {
                              validationService.changeConfirmPass(text);
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 0,
                        child: validationService.confirmPass.error == null
                            ? SizedBox()
                            : Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: GestureDetector(
                                  child: Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                  onTap: () {
                                    AchievementView(
                                      context,
                                      color: Colors.red,
                                      icon: Icon(
                                        FontAwesomeIcons.bug,
                                        color: Colors.white,
                                      ),
                                      title: "Error !",
                                      elevation: 20,
                                      subTitle:
                                          validationService.confirmPass.error,
                                      isCircle: true,
                                    )..show();
                                  },
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Builder(
                  builder: (context) {
                    return Container(
                      width: 300,
                      height: 50,
                      child: Hero(
                        tag: "Register",
                        child: ProgressButton(
                          borderRadius: 30,
                          color: Color(0xff20B5D9),
                          animate: false,
                          defaultWidget: NunitoText(
                            text: "Register",
                            fontWeight: FontWeight.w900,
                            clr: Colors.white,
                          ),
                          progressWidget: SpinKitThreeBounce(
                            color: Colors.white,
                            size: w * 5.0925,
                          ),
                          width: double.infinity,
                          height: 5 * h,
                          onPressed: validationService.isValid
                              ? () async {
                                  await registerUser(
                                      validationService.email.value,
                                      validationService.password.value,
                                      context);
                                }
                              : null,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NunitoText(
                        text: "Already have an account? ",
                      ),
                      PoppinsText(
                        text: "LOGIN HERE",
                        clr: Color(0xff20B5D9),
                        fontWeight: FontWeight.w800,
                      )
                    ],
                  ),
                  onTap: () {
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
