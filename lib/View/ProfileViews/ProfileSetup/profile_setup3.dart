import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crisislink/Controller/user_controller.dart';
import 'package:crisislink/Model/user.dart';
import 'package:crisislink/View/ProfileViews/ProfileSetup/const/gradient_const.dart';
import 'package:crisislink/View/ProfileViews/ProfileSetup/const/size_const.dart';
import 'package:crisislink/View/ProfileViews/ProfileSetup/profile_setup4.dart';
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

class ProfileSetupThree extends StatefulWidget {
  _ProfileSetupThreeState createState() => _ProfileSetupThreeState();
}

class _ProfileSetupThreeState extends State<ProfileSetupThree> {
  TextEditingController _nameController = TextEditingController();
  String postId = Uuid().v4();

  String myName = "";
  String myUsername = "";

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
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: NunitoText(
                  text: "Get Crisis Link for your workplace or school",
                  align: TextAlign.center,
                  fontSize: 16,
                  clr: Colors.blue,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    w * 2.0370, h * 0.9954, w * 2.0370, h * 0.9954),
                child: fieldColorBox(
                    SIGNUP_BACKGROUND,
                    "Name",
                    "Create your Unique Code",
                    _nameController,
                    [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]"))]),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: 320,
                height: 50,
                child: GradientButton(
                  title: "I am a school/college/university",
                  clrs: [Color(0xff20B5D9), Color(0xff20B5D9)],
                  onpressed: () async {
                    await FirebaseFirestore.instance
                        .collection("CrisisLink")
                        .doc(myName)
                        .set({
                      "organizationID": myName,
                      "organizationAdmin": _currentUser.getCurrentUser.uid,
                      "type": "Education",
                    });

                    await FirebaseFirestore.instance
                        .collection("users")
                        .doc(_currentUser.getCurrentUser.uid)
                        .update({
                      "type" : "Admin",
                      "step" : 4,
                    });

                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                        child: ProfileSetupFour(),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: 320,
                height: 50,
                child: GradientButton(
                  title: "I am a business/corporate",
                  clrs: [Color(0xff155398), Color(0xff155398)],
                  onpressed: () async {
                    await FirebaseFirestore.instance
                        .collection("CrisisLink")
                        .doc(myName)
                        .set({
                      "organizationID": myName.toLowerCase(),
                      "organizationAdmin": _currentUser.getCurrentUser.uid,
                      "type": "Coorporate",
                    });

                    await FirebaseFirestore.instance
                        .collection("users")
                        .doc(_currentUser.getCurrentUser.uid)
                        .update({
                      "type" : "Admin",
                      "step" : 4,
                    });

                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                        child: ProfileSetupFour(),
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

  Widget fieldColorBox(Gradient gradient, String title, String text,
      TextEditingController controller, List<TextInputFormatter> input) {
    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;

    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);

    return Padding(
      padding: EdgeInsets.only(
        left: w * 7.63888,
        right: w * 7.63888,
        bottom: h * 0.99547,
      ),
      child: Container(
        height: h * 7.466,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.purple,
              blurRadius: 5,
              offset: Offset(0.1, 0.1),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: w * 7.6388,
            ),
            Expanded(
              flex: 2,
              child: Wrap(
                children: <Widget>[
                  MediaQuery(
                    data: mqDataNew,
                    child: TextField(
                      inputFormatters: input,
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: text,
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontSize: TEXT_NORMAL_SIZE,
                          color: Colors.grey,
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          myName = _nameController.text;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
