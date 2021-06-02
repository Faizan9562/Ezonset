import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crisislink/Controller/user_controller.dart';
import 'package:crisislink/Model/user.dart';
import 'package:crisislink/View/Admin%20View/adminDashboard.dart';
import 'package:crisislink/View/Homepage/homepage_admin.dart';
import 'package:crisislink/View/ProfileViews/ProfileSetup/const/gradient_const.dart';
import 'package:crisislink/View/ProfileViews/ProfileSetup/const/size_const.dart';
import 'package:crisislink/Widgets/GradientButton/GradientButton.dart';
import 'package:crisislink/Widgets/TextWidgets/nunito_text.dart';
import 'package:crisislink/Widgets/progressBtn/flutter_progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:strings/strings.dart';

class ProfileSetupSix extends StatefulWidget {
  _ProfileSetupSixState createState() => _ProfileSetupSixState();
}

class _ProfileSetupSixState extends State<ProfileSetupSix> {
  TextEditingController _uNameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  String postId = Uuid().v4();

  List<QueryDocumentSnapshot> docs;
  String orgPicture;
  Map<String, dynamic> data;

  UserController _currentUser;
  Color bgpickerColor = Color(0xffffffff);
  Color bgcurrentColor = Color(0xfffffff);

  Color objpickerColor = Color(0xffffffff);
  Color objcurrentColor = Color(0xfffffff);

  Color fontpickerColor = Color(0xffffffff);
  Color fontcurrentColor = Color(0xfffffff);
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;

    _currentUser = Provider.of<UserController>(context);

    OurUser myUser;
    setState(() {
      myUser = _currentUser.getCurrentUser;
    });

    void changebgColor(Color color) {
      setState(() => bgpickerColor = color);
    }

    void changeobjColor(Color color) {
      setState(() => objpickerColor = color);
    }

    void changefontColor(Color color) {
      setState(() => fontpickerColor = color);
    }

    return Scaffold(
      body: Container(
        child: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
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
              return Column(
                children: <Widget>[
                  Card(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            child: CircularProfileAvatar(
                              orgPicture ?? "",
                              backgroundColor: Colors.black,
                              initialsText: Text(
                                "Display HERE",
                                textScaleFactor: 1,
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w900,
                                    fontSize: w * 3.6388,
                                    color: Colors.white),
                              ),
                              cacheImage: true,
                              borderColor: Colors.white,
                              borderWidth: 5,
                              elevation: 0,
                              radius: w * 1,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              NunitoText(
                                text: "${docs[0].data()["organizationName"]}",
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              NunitoText(
                                text: "${docs[0].data()["type"]} Organization",
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("users")
                                .doc(myUser.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                data = snapshot.data.data();
                                // if (data.containsKey("avatarUrl")) {
                                //   myUser.avatarUrl = data["avatarUrl"];
                                // }
                                return Row(
                                  children: [
                                    CircularProfileAvatar(
                                      myUser.avatarUrl ?? "",
                                      backgroundColor: Colors.black,
                                      initialsText: Text(
                                        "Display HERE",
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
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        NunitoText(
                                          text: "${data["displayName"]}",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        NunitoText(
                                          text: "${data["email"]}",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        NunitoText(
                                          text: "ADMINISTRATOR",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              }
                            }),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: NunitoText(
                        text: "Choose Colors",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  child: AlertDialog(
                                    title: const Text('Pick a color!'),
                                    content: SingleChildScrollView(
                                      child: ColorPicker(
                                        pickerColor: bgpickerColor,
                                        onColorChanged: changebgColor,
                                        showLabel: true,
                                        pickerAreaHeightPercent: 0.8,
                                      ),
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: const Text('Got it'),
                                        onPressed: () {
                                          setState(() =>
                                              bgcurrentColor = bgpickerColor);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: NunitoText(
                                      text: "Background Color",
                                      align: TextAlign.center,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          color:
                                              bgcurrentColor ?? Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  child: AlertDialog(
                                    title: const Text('Pick a color!'),
                                    content: SingleChildScrollView(
                                      child: ColorPicker(
                                        pickerColor: objpickerColor,
                                        onColorChanged: changeobjColor,
                                        showLabel: true,
                                        pickerAreaHeightPercent: 0.8,
                                      ),
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: const Text('Got it'),
                                        onPressed: () {
                                          setState(() =>
                                              objcurrentColor = objpickerColor);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: NunitoText(
                                      text: "Object Color",
                                      align: TextAlign.center,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          color:
                                              objcurrentColor ?? Colors.blue),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  child: AlertDialog(
                                    title: const Text('Pick a color!'),
                                    content: SingleChildScrollView(
                                      child: ColorPicker(
                                        pickerColor: fontpickerColor,
                                        onColorChanged: changefontColor,
                                        showLabel: true,
                                        pickerAreaHeightPercent: 0.8,
                                      ),
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: const Text('Got it'),
                                        onPressed: () {
                                          setState(() => fontcurrentColor =
                                              fontpickerColor);

                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: NunitoText(
                                      text: "Font Color",
                                      align: TextAlign.center,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          color:
                                              fontcurrentColor ?? Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 320,
                    height: 50,
                    child: GradientButton(
                      title: "Take me to dashboard",
                      clrs: [Color(0xffFBAF3A), Color(0xffF7941F)],
                      onpressed: () async {
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(_currentUser.getCurrentUser.uid)
                            .update({
                          "step": 10,
                        });

                        QuerySnapshot myOrganization = await FirebaseFirestore
                            .instance
                            .collection("CrisisLink")
                            .where("organizationAdmin",
                                isEqualTo: _currentUser.getCurrentUser.uid)
                            .get();

                        await FirebaseFirestore.instance
                            .collection("CrisisLink")
                            .doc(myOrganization.docs[0].id)
                            .update({
                          "backgroundColor": bgcurrentColor.value.toString(),
                          "objectColor": objcurrentColor.value.toString(),
                          "fontColor": fontpickerColor.value.toString(),
                        });

                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeIn,
                            child: AdminDashboard(),
                          ),
                        );

                        // Navigator.pushReplacement(
                        //   context,
                        //   PageTransition(
                        //     type: PageTransitionType.rightToLeft,
                        //     duration: Duration(milliseconds: 200),
                        //     curve: Curves.easeIn,
                        //     child: null,
                        //   ),
                        // );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
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
