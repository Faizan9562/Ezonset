import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crisislink/Controller/user_controller.dart';
import 'package:crisislink/Model/user.dart';
import 'package:crisislink/View/ProfileViews/ProfileSetup/const/gradient_const.dart';
import 'package:crisislink/View/ProfileViews/ProfileSetup/const/size_const.dart';
import 'package:crisislink/View/User%20View/StempDashboard/stempDashboard.dart';
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

class ProfileSetupEight extends StatefulWidget {
  _ProfileSetupEightState createState() => _ProfileSetupEightState();
}

class _ProfileSetupEightState extends State<ProfileSetupEight> {
  TextEditingController _uNameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  String postId = Uuid().v4();

  UserController _currentUser;
  List<QueryDocumentSnapshot> docs1;
  List<QueryDocumentSnapshot> docs2;
  String orgPicture;
  Map<String, dynamic> data;

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
      body: Container(
        child: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("members")
                .where("userId", isEqualTo: _currentUser.getCurrentUser.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                docs1 = snapshot.data.docs;
              }
              return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("CrisisLink")
                      .where("organizationID",
                          isEqualTo: docs1[0].data()["organzationID"])
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data.docs.length > 0) {
                      docs2 = snapshot.data.docs;
                      if (docs2[0].data().containsKey("organizationLogo")) {
                        orgPicture = docs2[0].data()["organizationLogo"];
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
                                      text:
                                          "${docs2[0].data()["organizationName"]}",
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    NunitoText(
                                      text:
                                          "${docs2[0].data()["type"]} Organization",
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
                        NunitoText(
                          text: "Choose Your role",
                          align: TextAlign.center,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          width: 320,
                          height: 50,
                          child: GradientButton(
                            title:
                                "${docs2[0].data()["type"] == "Coorporate" ? "Employee" : "Student"} ${docs2[0].data()["type"] == "Coorporate" ? "(Non-Manager)" : "(Non-Teacher)"}",
                            clrs: [Color(0xffFBAF3A), Color(0xffF7941F)],
                            onpressed: () async {
                              FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(_currentUser.getCurrentUser.uid)
                                  .update({
                                "type": docs2[0].data()["type"] == "Coorporate"
                                    ? "Employee"
                                    : "Student",
                                "step" : 10,
                              });

                              var mem = await FirebaseFirestore.instance
                                  .collection("members")
                                  .where("userId",
                                      isEqualTo:
                                          _currentUser.getCurrentUser.uid)
                                  .get();

                              var id = mem.docs[0].id;

                              FirebaseFirestore.instance
                                  .collection("members")
                                  .doc(id)
                                  .update({
                                "type": docs2[0].data()["type"] == "Coorporate"
                                    ? "Employee"
                                    : "Student"
                              });

                              Navigator.pushReplacement(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.easeIn,
                                  child: StempDashboard(),
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
                            title:
                                "${docs2[0].data()["type"] == "Coorporate" ? "Manager" : "Teacher"}",
                            clrs: [Color(0xffFBAF3A), Color(0xffF7941F)],
                            onpressed: () async {
                              FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(_currentUser.getCurrentUser.uid)
                                  .update({
                                "type": docs2[0].data()["type"] == "Coorporate"
                                    ? "Manager"
                                    : "Teacher",
                                "step" : 10,
                              });

                              var mem = await FirebaseFirestore.instance
                                  .collection("members")
                                  .where("userId",
                                      isEqualTo:
                                          _currentUser.getCurrentUser.uid)
                                  .get();

                              var id = mem.docs[0].id;

                              FirebaseFirestore.instance
                                  .collection("members")
                                  .doc(id)
                                  .update({
                                "type": docs2[0].data()["type"] == "Coorporate"
                                    ? "Manager"
                                    : "Teacher"
                              });

                              Navigator.pushReplacement(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.easeIn,
                                  child: StempDashboard(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  });
            },
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
