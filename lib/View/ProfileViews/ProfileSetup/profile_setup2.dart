import 'package:crisislink/Controller/user_controller.dart';
import 'package:crisislink/Model/user.dart';
import 'package:crisislink/View/ProfileViews/ProfileSetup/const/gradient_const.dart';
import 'package:crisislink/View/ProfileViews/ProfileSetup/const/size_const.dart';
import 'package:crisislink/View/ProfileViews/ProfileSetup/profile_setup3.dart';
import 'package:crisislink/View/User%20View/ProfileViews/profile_setup7.dart';
import 'package:crisislink/Widgets/GradientButton/GradientButton.dart';
import 'package:crisislink/Widgets/TextWidgets/nunito_text.dart';
import 'package:crisislink/Widgets/progressBtn/flutter_progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:strings/strings.dart';

class ProfileSetupTwo extends StatefulWidget {
  _ProfileSetupTwoState createState() => _ProfileSetupTwoState();
}

class _ProfileSetupTwoState extends State<ProfileSetupTwo> {
  TextEditingController _uNameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  String postId = Uuid().v4();

  UserController _currentUser;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;

    _currentUser = Provider.of<UserController>(context);

    OurUser myUser;
    setState(() {
      myUser = _currentUser.getCurrentUser;
    });

    void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
      // TODO: implement your code here
    }

    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: "Logo",
                child: Container(
                  width: 160,
                  child: Image.asset(
                    'assets/images/CLLogo.png',
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: 320,
                height: 50,
                child: GradientButton(
                  title: "Connect to my workplace network",
                  clrs: [Color(0xffFBAF3A), Color(0xffF7941F)],
                  onpressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                        child: ProfileSetupSeven(),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: 100,
                
                child: Divider(thickness: 2,),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: 320,
                height: 50,
                child: GradientButton(
                  title: "Get Crisis Link for my workplace",
                  clrs: [Color(0xff38B564), Color(0xff01A99B)],
                  onpressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                        child: ProfileSetupThree(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}