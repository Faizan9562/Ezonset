import 'package:achievement_view/achievement_view.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crisislink/Controller/user_controller.dart';
import 'package:crisislink/Model/user.dart';
import 'package:crisislink/View/ProfileViews/ProfileSetup/const/gradient_const.dart';
import 'package:crisislink/View/ProfileViews/ProfileSetup/const/size_const.dart';
import 'package:crisislink/Widgets/GradientButton/GradientButton.dart';
import 'package:crisislink/Widgets/TextWidgets/nunito_text.dart';
import 'package:crisislink/Widgets/progressBtn/flutter_progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:strings/strings.dart';

class TotalEmployee extends StatefulWidget {
  Map orgData;
  TotalEmployee({this.orgData});

  _TotalEmployeeState createState() => _TotalEmployeeState();
}

class _TotalEmployeeState extends State<TotalEmployee> {
  TextEditingController _uNameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  String postId = Uuid().v4();

  UserController _currentUser;

  Color clrbg;
  Color clrobj;
  Color clrtxt;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;

    _currentUser = Provider.of<UserController>(context);

    clrbg = Color(int.parse(widget.orgData["backgroundColor"]));
    clrobj = Color(int.parse(widget.orgData["objectColor"]));
    clrtxt = Color(int.parse(widget.orgData["fontColor"]));

    List<QueryDocumentSnapshot> docs;
    String orgPicture;
    List<QueryDocumentSnapshot> data;
    List<QueryDocumentSnapshot> employeeData;

    OurUser myUser;
    setState(() {
      myUser = _currentUser.getCurrentUser;
    });

    return Scaffold(
      backgroundColor: clrbg,
      body: Container(
        child: SafeArea(
          child: SingleChildScrollView(
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
                                    text:
                                        "${docs[0].data()["organizationName"]}",
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  NunitoText(
                                    text:
                                        "${docs[0].data()["type"]} Organization",
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 20),
                        child: Align(
                          alignment: Alignment.center,
                          child: NunitoText(
                            text:
                                "Total ${docs[0].data()["type"] == "Education" ? "Students" : "Employees"}",
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            clr: clrtxt,
                          ),
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("members")
                            .where("type",
                                isEqualTo: docs[0].data()["type"] == "Education"
                                    ? "Student"
                                    : "Employee")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            employeeData = snapshot.data.docs;
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: employeeData.length,
                              itemBuilder: (context, index) {
                                return StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection("users")
                                        .where("uid",
                                            isEqualTo: employeeData[index]
                                                ["userId"])
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Card(
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Row(
                                                children: [
                                                  CircularProfileAvatar(
                                                    snapshot.data.docs[0]
                                                                .data()[
                                                            "avatarUrl"] ??
                                                        "",
                                                    backgroundColor:
                                                        Colors.black,
                                                    initialsText: Text(
                                                      "Display HERE",
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                          fontFamily: "Nunito",
                                                          fontWeight:
                                                              FontWeight.w900,
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      NunitoText(
                                                        text:
                                                            "${snapshot.data.docs[index].data()["displayName"]}",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      NunitoText(
                                                        text:
                                                            "${snapshot.data.docs[index].data()["email"]}",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      NunitoText(
                                                        text:
                                                            "${employeeData[index].data()["type"] == "Education" ? "Student" : "Employee"}",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    });
                              },
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
