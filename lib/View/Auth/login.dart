import 'package:achievement_view/achievement_view.dart';
import 'package:crisislink/Controller/user_controller.dart';
import 'package:crisislink/Providers/login_validation.dart';
import 'package:crisislink/View/Auth/forgot_password.dart';
import 'package:crisislink/View/Auth/register.dart';
import 'package:crisislink/View/Root/root.dart';
import 'package:crisislink/Widgets/TextWidgets/nunito_text.dart';
import 'package:crisislink/Widgets/TextWidgets/poppins_text.dart';
import 'package:crisislink/Widgets/TextWidgets/rounded_textfield.dart';
import 'package:crisislink/Widgets/progressBtn/flutter_progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  //Takes users data and sends to users controller to login

  @override
  Widget build(BuildContext context) {
    UserController _currentUser =
        Provider.of<UserController>(context, listen: false);

    LoginValidation loginValidationService =
        Provider.of<LoginValidation>(context);

    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;

    print("The UID IS ${_currentUser.getCurrentUser.uid}");

    // Show Failed Snackbar // UI //
    loginFailedSnackBar(BuildContext context) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Incorrect email or password",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Nunito",
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
            textScaleFactor: 1,
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }

    Future<bool> _loginUser(
        String email, String password, BuildContext context) async {
      if (await _currentUser.loginUser(email, password)) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => Root()));
      } else {
        loginFailedSnackBar(context);
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
                  height: 20,
                ),
                NunitoText(
                  text: "Welcome Back!",
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
                NunitoText(
                  text: "Login to your existing account",
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
                                loginValidationService.changeEmail(text);
                              },
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 0,
                        child: loginValidationService.email.error == null
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
                                      subTitle:
                                          loginValidationService.email.error,
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
                                loginValidationService.changePassword(text);
                              },
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 0,
                        child: loginValidationService.password.error == null
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
                                          loginValidationService.password.error,
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
                  height: 20,
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.only(right: 20),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: NunitoText(
                        text: "Forgot Password ?",
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                        child: ForgotPassword(),
                      ),
                    );
                  },
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
                        tag: "Login",
                        child: ProgressButton(
                          borderRadius: 30,
                          color: Color(0xff20B5D9),
                          animate: false,
                          defaultWidget: NunitoText(
                            text: "Login",
                            fontWeight: FontWeight.w900,
                            clr: Colors.white,
                          ),
                          progressWidget: SpinKitThreeBounce(
                            color: Colors.white,
                            size: w * 5.0925,
                          ),
                          width: double.infinity,
                          height: 5 * h,
                          onPressed: loginValidationService.isValid
                              ? () async {
                                  await _loginUser(
                                      loginValidationService.email.value,
                                      loginValidationService.password.value,
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
                        text: "Don't have an account ? ",
                      ),
                      PoppinsText(
                        text: "SIGN UP",
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
                        child: Register(),
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
