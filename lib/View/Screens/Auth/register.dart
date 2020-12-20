import 'package:ezonset/Controller/userController/userController.dart';
import 'package:ezonset/Controller/validationController/register_validation.dart';
import 'package:ezonset/View/Screens/Auth/login.dart';
import 'package:ezonset/View/Widgets/TextFields/tf1.dart';
import 'package:ezonset/View/Widgets/progressBtn/flutter_progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

    Future<bool> successSnackBar(BuildContext context) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Success",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Nunito",
              fontWeight: FontWeight.w700,
              fontSize: 15,
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
              fontSize: 18,
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
      } else {
        registerFailedSnackBar(context);
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
                    validationService.changeEmail(text);
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
                    validationService.changePassword(text);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TF1(
                  controller: passConfirmController,
                  title: "Confirm Password",
                  hintTitle: "Enter Password Again",
                  obs: true,
                  onChange: (text) {
                    print(text);
                    validationService.changeConfirmPass(text);
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
                        'Register',
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
                      onPressed: validationService.isValid
                          ? () async {
                              await registerUser(validationService.email.value,
                                  validationService.password.value, context);
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
                  "Already Have an Account ? Login Now",
                  style: TextStyle(
                      fontFamily: "Nunito", fontWeight: FontWeight.w900),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Login()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
