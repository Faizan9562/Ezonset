import 'package:ezonset/Controller/userController/userController.dart';
import 'package:ezonset/Controller/validationController/login_validation.dart';
import 'package:ezonset/RootController/root.dart';
import 'package:ezonset/View/Screens/Auth/forgot_password.dart';
import 'package:ezonset/View/Screens/Auth/register.dart';
import 'package:ezonset/View/Screens/homepage.dart';
import 'package:ezonset/View/Widgets/TextFields/tf1.dart';
import 'package:ezonset/View/Widgets/progressBtn/flutter_progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserController _currentUser =
        Provider.of<UserController>(context, listen: false);

    LoginValidation loginValidationService =
        Provider.of<LoginValidation>(context);

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
              fontSize: 15,
            ),
            textScaleFactor: 1,
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }

    //Takes users data and sends to users controller to login
    Future<bool> _loginUser(
        String email, String password, BuildContext context) async {
      if (await _currentUser.loginUser(email, password)) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => OurRoot()));
      } else {
        loginFailedSnackBar(context);
      }
    }

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TF1(
                  controller: emailController,
                  title: "Email",
                  hintTitle: "Enter Email Here",
                  onChange: (text) {
                    loginValidationService.changeEmail(text);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TF1(
                  controller: passController,
                  title: "Password",
                  hintTitle: "Enter Password Here",
                  obs: true,
                  onChange: (text) {
                    loginValidationService.changePassword(text);
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Builder(
                builder: (context) {
                  return Container(
                    width: 150,
                    child: ProgressButton(
                      borderRadius: 10,
                      color: Colors.orange,
                      animate: false,
                      defaultWidget: Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 15,
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
                        size: 20,
                      ),
                      width: double.infinity,
                      height: 40,
                      onPressed: loginValidationService.isValid
                          ? () async {
                              await _loginUser(
                                  loginValidationService.email.value,
                                  loginValidationService.password.value,
                                  context);
                            }
                          : null,
                    ),
                  );
                },
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                child: Text(
                  "Don't Have An Account ? Register Now",
                  style: TextStyle(
                      fontFamily: "Nunito", fontWeight: FontWeight.w900),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Register()));
                },
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                child: Text(
                  "Forgot your password ? ",
                  style: TextStyle(
                    fontFamily: "Nunito",
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                        child: ForgotPassword()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
