import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crisislink/Controller/user_controller.dart';
import 'package:crisislink/Model/user.dart';
import 'package:crisislink/View/Conversation/main_chat_screen.dart';
import 'package:crisislink/View/User%20View/StempDashboard/create_query.dart';
import 'package:crisislink/View/User%20View/StempDashboard/select_TM.dart';
import 'package:crisislink/Widgets/TextWidgets/nunito_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CompletedConvo extends StatefulWidget {
  Map orgData;

  CompletedConvo({this.orgData});

  @override
  _CompletedConvoState createState() => _CompletedConvoState();
}

class _CompletedConvoState extends State<CompletedConvo> {
  TextEditingController _uNameController = TextEditingController();

  TextEditingController _nameController = TextEditingController();

  String postId = Uuid().v4();

  UserController _currentUser;

  Color clrbg;

  Color clrobj;

  Color clrtxt;

  List<QueryDocumentSnapshot> pendingDocs;

  String orgPicture;

  List<QueryDocumentSnapshot> data;
  Map receiverMap;

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
          clrbg = Color(int.parse(widget.orgData["backgroundColor"]));
          clrobj = Color(int.parse(widget.orgData["objectColor"]));
          clrtxt = Color(int.parse(widget.orgData["fontColor"]));

          if (snapshot.hasData && snapshot.data.docs != null) {
            return Scaffold(
              backgroundColor: widget.orgData != null
                  ? Color(int.parse(widget.orgData["backgroundColor"]))
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
                                  widget.orgData["organizationLogo"] ?? "",
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
                                        "${widget.orgData["organizationName"]}",
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  NunitoText(
                                    text:
                                        "${widget.orgData["type"]} Organization",
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
                                text: "Completed Tickets",
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("ticketsRoom")
                                .where("otherPersonId",
                                    isEqualTo: _currentUser.getCurrentUser.uid)
                                .where("status", isEqualTo: "close")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                data = snapshot.data.docs;
                                return ListView.builder(
                                  itemCount: data.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection("tickets")
                                            .where("ticketId",
                                                isEqualTo: data[index]
                                                    .data()["ticketId"])
                                            .orderBy("timestamp",
                                                descending: true)
                                            .snapshots(),
                                        // ignore: missing_return
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            receiverMap =
                                                snapshot.data.docs[0].data();
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 20),
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  elevation: 10,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20.0),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Flexible(
                                                                child:
                                                                    NunitoText(
                                                                  text:
                                                                      "${snapshot.data.docs[0].data()["subject"]}",
                                                                  fontSize: 14,
                                                                  align:
                                                                      TextAlign
                                                                          .left,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 10),
                                                              NunitoText(
                                                                text:
                                                                    "20th December, 2020",
                                                                fontSize: 14,
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
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            NunitoText(
                                                              text: "From : ",
                                                              fontSize: 14,
                                                            ),
                                                            NunitoText(
                                                              text:
                                                                  "${receiverMap["sender_userName"]}",
                                                              fontSize: 14,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Center(
                                              child: Container(),
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
                            }),
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeIn,
                              child: ChatScreen(
                                currentUsr: _currentUser.getCurrentUser,
                                receiverMap: receiverMap,
                                status: "close",
                              ),
                            ),
                          );
                        },
                      ),
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
  }
}
