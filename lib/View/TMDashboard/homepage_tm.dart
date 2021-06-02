import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crisislink/Controller/user_controller.dart';
import 'package:crisislink/Model/user.dart';
import 'package:crisislink/View/TMDashboard/completed_convo.dart';
import 'package:crisislink/View/TMDashboard/pending_convo.dart';
import 'package:crisislink/View/User%20View/StempDashboard/create_query.dart';
import 'package:crisislink/View/User%20View/StempDashboard/select_TM.dart';
import 'package:crisislink/Widgets/TextWidgets/nunito_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class TMHomepage extends StatefulWidget {
  @override
  _TMHomepageState createState() => _TMHomepageState();
}

class _TMHomepageState extends State<TMHomepage> {
  TextEditingController _uNameController = TextEditingController();

  TextEditingController _nameController = TextEditingController();

  String postId = Uuid().v4();

  UserController _currentUser;

  Map orgData;

  Color clrbg;

  Color clrobj;

  Color clrtxt;

  List<QueryDocumentSnapshot> pendingDocs;
  List<QueryDocumentSnapshot> closeDocs;
  String orgPicture;

  List<QueryDocumentSnapshot> data;

  getData(String id) async {
    var data = await FirebaseFirestore.instance
        .collection("CrisisLink")
        .where("organizationID", isEqualTo: id)
        .get();

    setState(() {
      orgData = data.docs[0].data();
      clrbg = Color(int.parse(orgData["backgroundColor"]));
      clrobj = Color(int.parse(orgData["objectColor"]));
      clrtxt = Color(int.parse(orgData["fontColor"]));
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
          if (snapshot.hasData && snapshot.data.docs != null) {
            getData(snapshot.data.docs[0].data()["organzationID"]);
            if (orgData != null) {
              return Scaffold(
                backgroundColor: orgData != null
                    ? Color(int.parse(orgData["backgroundColor"]))
                    : Colors.white,
                body: Container(
                  child: SafeArea(
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
                                  text: "My Conversations",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("ticketsRoom")
                                .where("status", isEqualTo: "open")
                                .where("otherPersonId",
                                    isEqualTo: _currentUser.getCurrentUser.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                pendingDocs = snapshot.data.docs;
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
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: NunitoText(
                                                        text:
                                                            "PENDING CONVERSATIONS",
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
                                                        "${pendingDocs.length}",
                                                    fontSize: 25,
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
                                        child: PendingConvo(
                                          orgData: orgData,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return Container(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                        StreamBuilder<dynamic>(
                            stream: FirebaseFirestore.instance
                                .collection("ticketsRoom")
                                .where("status", isEqualTo: "close")
                                .where("otherPersonId",
                                    isEqualTo: _currentUser.getCurrentUser.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                closeDocs = snapshot.data.docs;
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
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: NunitoText(
                                                        text:
                                                            "COMPLETED CONVERSATIONS",
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
                                                    text: "${closeDocs.length}",
                                                    fontSize: 25,
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
                                        child: CompletedConvo(
                                          orgData: orgData,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
