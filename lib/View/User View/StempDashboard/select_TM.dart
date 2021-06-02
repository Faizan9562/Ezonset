import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crisislink/Controller/user_controller.dart';
import 'package:crisislink/Model/user.dart';
import 'package:crisislink/View/User%20View/StempDashboard/create_query.dart';
import 'package:crisislink/View/User%20View/StempDashboard/select_TM.dart';
import 'package:crisislink/Widgets/TextWidgets/nunito_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class SelectTM extends StatefulWidget {
  @override
  _SelectTMState createState() => _SelectTMState();
}

class _SelectTMState extends State<SelectTM> {
  TextEditingController _uNameController = TextEditingController();

  TextEditingController _nameController = TextEditingController();

  String postId = Uuid().v4();

  UserController _currentUser;

  Map orgData;

  Color clrbg;

  Color clrobj;

  Color clrtxt;

  List<QueryDocumentSnapshot> tmDocs;

  String orgPicture;

  List<QueryDocumentSnapshot> data;

  getData(String id) async {
    var data = await FirebaseFirestore.instance
        .collection("CrisisLink")
        .where("organizationID", isEqualTo: id)
        .get();

    setState(() {
      orgData = data.docs[0].data();
    });
  }

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
            .collection("users")
            .where("uid", isEqualTo: _currentUser.getCurrentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          print(snapshot.data.docs[0].data()["organzationID"]);
          getData(snapshot.data.docs[0].data()["organzationID"]);
          clrbg = Color(int.parse(orgData["backgroundColor"]));
          clrobj = Color(int.parse(orgData["objectColor"]));
          clrtxt = Color(int.parse(orgData["fontColor"]));

          if (snapshot.hasData && snapshot.data.docs != null) {
            return Scaffold(
              backgroundColor: orgData != null
                  ? Color(int.parse(orgData["backgroundColor"]))
                  : Colors.white,
              body: Container(
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
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
                                    orgData["organizationLogo"] ?? "",
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
                                      text: "${orgData["organizationName"]}",
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    NunitoText(
                                      text: "${orgData["type"]} Organization",
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
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                NunitoText(
                                  text:
                                      "Select ${orgData["type"] == "Education" ? "Teachers" : "Managers"}",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("users")
                              .where("type",
                                  isEqualTo: orgData["type"] == "Education"
                                      ? "Teacher"
                                      : "Manager")
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              tmDocs = snapshot.data.docs;
                              return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: tmDocs.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 20),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          elevation: 10,
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Flexible(
                                                        child:
                                                            CircularProfileAvatar(
                                                          tmDocs[index].data()[
                                                                  "avatarUrl"] ??
                                                              "",
                                                          backgroundColor:
                                                              Colors.black,
                                                          initialsText: Text(
                                                            "Display HERE",
                                                            textScaleFactor: 1,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Nunito",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                fontSize:
                                                                    w * 3.6388,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          cacheImage: true,
                                                          borderColor:
                                                              Colors.white,
                                                          borderWidth: 5,
                                                          elevation: 0,
                                                          radius: w * 10,
                                                        ),
                                                      ),
                                                      SizedBox(width: 20),
                                                      Flexible(
                                                        child: NunitoText(
                                                          text:
                                                              "${tmDocs[index].data()["displayName"]}",
                                                          fontSize: 22,
                                                          align: TextAlign.left,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Divider(
                                                  thickness: 2,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    NunitoText(
                                                      text:
                                                          "${orgData["type"] == "Education" ? "Teacher" : "Manager"}",
                                                      fontSize: 14,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
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
                                          child: CreateQuery(
                                            orgData: orgData,
                                            tmData: tmDocs[index].data(),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        )
                      ],
                    ),
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
  }
}
