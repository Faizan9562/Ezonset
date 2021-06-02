import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crisislink/Controller/user_controller.dart';
import 'package:crisislink/Model/user.dart';
import 'package:crisislink/View/ProfileViews/ProfileSetup/const/gradient_const.dart';
import 'package:crisislink/View/ProfileViews/ProfileSetup/const/size_const.dart';
import 'package:crisislink/View/ProfileViews/ProfileSetup/profile_setup5.dart';
import 'package:crisislink/Widgets/GradientButton/GradientButton.dart';
import 'package:crisislink/Widgets/TextWidgets/nunito_text.dart';
import 'package:crisislink/Widgets/progressBtn/flutter_progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:strings/strings.dart';

class ProfileSetupFour extends StatefulWidget {
  _ProfileSetupFourState createState() => _ProfileSetupFourState();
}

class _ProfileSetupFourState extends State<ProfileSetupFour> {
  TextEditingController _nameController = TextEditingController();
  String postId = Uuid().v4();

  UserController _currentUser;
  List<QueryDocumentSnapshot> docs;
  String orgPicture;
  

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
                  text: "Setup your network",
                  align: TextAlign.center,
                  fontSize: 16,
                  clr: Colors.blue,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("CrisisLink")
                      .where("organizationAdmin",
                          isEqualTo: _currentUser.getCurrentUser.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data.docs.length > 0) {
                      docs = snapshot.data.docs;
                      if (docs[0].data().containsKey("organizationLogo")) {
                        orgPicture = docs[0].data()["organizationLogo"];
                      }
                    }
                    return CircularProfileAvatar(
                      orgPicture ?? "",
                      backgroundColor: Colors.black,
                      initialsText: Text(
                        "LOGO",
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w900,
                            fontSize: w * 3.6388,
                            color: Colors.white),
                      ),
                      cacheImage: true,
                      borderColor: Colors.black,
                      borderWidth: 5,
                      elevation: 10,
                      radius: w * 12.7314,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) => AssetGiffyDialog(
                                  buttonOkText: Text(
                                    "Choose From Gallery",
                                    textScaleFactor: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Nunito",
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  image: Image.asset(
                                    "assets/gifs/1.gif",
                                    fit: BoxFit.cover,
                                  ),
                                  entryAnimation: EntryAnimation.TOP_LEFT,
                                  buttonOkColor: Color(0xff8D4BF5),
                                  title: Text(
                                    'Upload your Picture',
                                    textScaleFactor: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  description: Text(
                                    'It is highly advised to use your own image as a profile picture. Other people will see this photo in thier explore section. Our team will review your account based on this image.',
                                    textAlign: TextAlign.center,
                                    textScaleFactor: 1,
                                    style: TextStyle(fontFamily: "Nunito"),
                                  ),
                                  onOkButtonPressed: () async {
                                    await UserController().updatePicture(
                                        docs[0].data()["organizationID"]);
                                    Navigator.of(context).pop();
                                  },
                                ));
                      },
                    );
                  }),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    w * 2.0370, h * 0.9954, w * 2.0370, h * 0.9954),
                child: fieldColorBox(
                    SIGNUP_BACKGROUND,
                    "Name",
                    "Name Your Organization",
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
                        setState(() {});
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
    await _currentUser.updatePushNotifications(true);
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
              color: Color(0xffFAA227),
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
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(_currentUser.getCurrentUser.uid)
                          .update({
                        "step": 4,
                      });

                      await FirebaseFirestore.instance
                          .collection("CrisisLink")
                          .doc(docs[0].data()["organizationID"])
                          .update({
                        "organizationName": _nameController.text,
                      });
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                          child: ProfileSetupFive(),
                        ),
                      );
                    }
                  : null);
        },
      ),
    );
  }
}
