import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crisislink/Controller/user_controller.dart';
import 'package:crisislink/Model/user.dart';
import 'package:crisislink/View/Admin%20View/add_members.dart';
import 'package:crisislink/View/Admin%20View/totalEmployees.dart';
import 'package:crisislink/View/Admin%20View/totalManagers.dart';
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

class HomepageAdmin extends StatefulWidget {
  _HomepageAdminState createState() => _HomepageAdminState();
}

class _HomepageAdminState extends State<HomepageAdmin> {
  TextEditingController _uNameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  String postId = Uuid().v4();

  UserController _currentUser;

  Map orgData;
  Color clrbg;
  Color clrobj;
  Color clrtxt;
  List<QueryDocumentSnapshot> docs;
  String orgPicture;
  List<QueryDocumentSnapshot> data;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;

    _currentUser = Provider.of<UserController>(context);

    OurUser myUser;
    setState(() {
      myUser = _currentUser.getCurrentUser;
    });

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("CrisisLink")
            .where("organizationAdmin",
                isEqualTo: _currentUser.getCurrentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          orgData = snapshot.data.docs[0].data();
          clrbg = Color(int.parse(orgData["backgroundColor"]));
          clrobj = Color(int.parse(orgData["objectColor"]));
          clrtxt = Color(int.parse(orgData["fontColor"]));

          if (snapshot.hasData && snapshot.data.docs != null) {
            return Scaffold(
              backgroundColor: Color(int.parse(orgData["backgroundColor"])),
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
                                  text: "Total Members",
                                  clr: clrtxt,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Card(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30.0, horizontal: 25),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        NunitoText(
                                          text:
                                              "Total ${docs[0].data()["type"] == "Education" ? "Teachers" : "Managers"}",
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                          clr: clrtxt,
                                        ),
                                        StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection("members")
                                              .where("type",
                                                  isEqualTo:
                                                      docs[0].data()["type"] ==
                                                              "Education"
                                                          ? "Teacher"
                                                          : "Manager")
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return NunitoText(
                                                text: snapshot.data.docs.length
                                                    .toString(),
                                                fontSize: 40,
                                                fontWeight: FontWeight.w900,
                                                clr: clrtxt,
                                              );
                                            } else {
                                              return NunitoText(
                                                text: "N/A",
                                                fontSize: 40,
                                                fontWeight: FontWeight.w900,
                                                clr: clrtxt,
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
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
                                    child: TotalManagers(
                                      orgData: orgData,
                                    ),
                                  ),
                                );
                              },
                            ),
                            GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Card(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30.0, horizontal: 25),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        NunitoText(
                                          text:
                                              "Total ${docs[0].data()["type"] == "Education" ? "Students" : "Employees"}",
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                          clr: clrtxt,
                                        ),
                                        StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection("members")
                                              .where("type",
                                                  isEqualTo:
                                                      docs[0].data()["type"] ==
                                                              "Education"
                                                          ? "Student"
                                                          : "Employee")
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return NunitoText(
                                                text: snapshot.data.docs.length
                                                    .toString(),
                                                fontSize: 40,
                                                fontWeight: FontWeight.w900,
                                                clr: clrtxt,
                                              );
                                            } else {
                                              return NunitoText(
                                                text: "N/A",
                                                fontSize: 40,
                                                fontWeight: FontWeight.w900,
                                                clr: clrtxt,
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
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
                                    child: TotalEmployee(
                                      orgData: orgData,
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        );
                      }),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  updateDataToDb() async {
    await _currentUser.updatePushNotifications(true);
  }
}
