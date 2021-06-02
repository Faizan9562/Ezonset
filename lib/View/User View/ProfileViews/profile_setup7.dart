import 'package:achievement_view/achievement_view.dart';
import 'package:crisislink/Controller/user_controller.dart';
import 'package:crisislink/Model/user.dart';
import 'package:crisislink/View/ProfileViews/ProfileSetup/const/gradient_const.dart';
import 'package:crisislink/View/ProfileViews/ProfileSetup/const/size_const.dart';
import 'package:crisislink/View/User%20View/ProfileViews/profile_setup8.dart';
import 'package:crisislink/Widgets/GradientButton/GradientButton.dart';
import 'package:crisislink/Widgets/TextWidgets/nunito_text.dart';
import 'package:crisislink/Widgets/progressBtn/flutter_progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:strings/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileSetupSeven extends StatefulWidget {
  _ProfileSetupSevenState createState() => _ProfileSetupSevenState();
}

class _ProfileSetupSevenState extends State<ProfileSetupSeven> {
  TextEditingController _uNameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  String postId = Uuid().v4();

  String myName = "";
  String myUsername = "";
  String _currentLocation = "Your Country";
  String gender = "Male";
  String interestedIn = "Female";

  bool _male = true;
  bool _famele = false;

  bool _maleInterest = false;
  bool _fameleInterest = true;
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
                  text: "Connect to my workplace network",
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
                    "Enter Organizational Code",
                    _nameController,
                    [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"))]),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    w * 2.0370, h * 0.5, w * 2.0370, h * 0.9954),
                child: nexButton("NEXT", context),
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
              color: Colors.blue,
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
                          myUsername = _uNameController.text.toLowerCase();
                          print(myName);
                          print(myUsername);
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

  updateDataToDb() async {
    var _ref = FirebaseFirestore.instance
        .collection("CrisisLink")
        .where("organizationID", isEqualTo: _nameController.text)
        .get();
    QuerySnapshot docs;
    docs = await _ref;

    print(docs.docs);
    if (docs.docs.length > 0) {
      await FirebaseFirestore.instance.collection("members").add({
        "organzationID": _nameController.text,
        "userId": _currentUser.getCurrentUser.uid,
      });

      await FirebaseFirestore.instance
          .collection("users")
          .doc(_currentUser.getCurrentUser.uid)
          .update({
        "step": 7,
        "organzationID": _nameController.text.toLowerCase(),
      });

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => ProfileSetupEight()));
    } else {
      AchievementView(context,
          color: Colors.red,
          icon: Icon(
            FontAwesomeIcons.bug,
            color: Colors.white,
          ),
          title: "Error !",
          elevation: 20,
          subTitle: "No organization with name ${_nameController.text} exists",
          isCircle: true, listener: (status) {
        print(status);
      })
        ..show();
    }
  }

  Widget nexButton(String text, BuildContext context) {
    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: w * 20.731, vertical: h * 6.2217),
      child: Builder(
        builder: (context) {
          return ProgressButton(
              borderRadius: 30,
              color: Color(0xff8B78F7),
              animate: false,
              defaultWidget: NunitoText(
                text: "Next",
                fontWeight: FontWeight.w900,
                clr: Colors.white,
              ),
              progressWidget: SpinKitThreeBounce(
                color: Colors.white,
                size: w * 5.0925,
              ),
              width: double.infinity,
              height: 5 * h,
              onPressed: _nameController.text.length > 0
                  ? () async {
                      updateDataToDb();
                      // if (_currentUser.getCurrentUser.avatarUrl == null) {
                      //   await _currentUser.updateDisplay(camelize(myName));
                      //   dpFailedSnackBar(context);
                      // } else {
                      //   try {
                      //     var _ref = FirebaseFirestore.instance
                      //         .collection("users")
                      //         .where("username", isEqualTo: myUsername)
                      //         .get();
                      //     QuerySnapshot docs;
                      //     docs = await _ref;

                      //     print(docs.docs);
                      //     if (docs.docs.length > 0) {
                      //     } else {
                      //       await updateDataToDb();
                      //       Navigator.pushReplacement(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (BuildContext context) => Home()));
                      //     }
                      //   } catch (e) {
                      //     print(e);
                      //   }
                      // }
                    }
                  : null);
        },
      ),
    );
  }
}
