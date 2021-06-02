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

class StempHomepage extends StatefulWidget {
  @override
  _StempHomepageState createState() => _StempHomepageState();
}

class _StempHomepageState extends State<StempHomepage> {
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

  Map receiverMap;

  getData() async {
    var data2 = await FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: _currentUser.getCurrentUser.uid)
        .get();

    var data = await FirebaseFirestore.instance
        .collection("CrisisLink")
        .where("organizationID",
            isEqualTo: data2.docs[0].data()["organzationID"])
        .get();
    setState(() {
      orgData = data.docs[0].data();
    });
  }

  Future<String> getData2() async {
    var data2 = await FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: _currentUser.getCurrentUser.uid)
        .get();

    return data2.docs[0].data()["organzationID"];
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
    getData();
    clrbg = Color(int.parse(orgData["backgroundColor"]));
    clrobj = Color(int.parse(orgData["objectColor"]));
    clrtxt = Color(int.parse(orgData["fontColor"]));
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              duration: Duration(milliseconds: 200),
              curve: Curves.easeIn,
              child: SelectTM(),
            ),
          );
        },
        backgroundColor: Colors.black,
      ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NunitoText(
                        text: "Total Conversations",
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                      NunitoText(
                        text: "3",
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      )
                    ],
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("ticketsRoom")
                      .where("my_Id",
                          isEqualTo: _currentUser.getCurrentUser.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    //
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
                                      isEqualTo: data[index].data()["ticketId"])
                                  .snapshots(),
                              builder: (context, snapshot) {
                                //
                                if (snapshot.hasData) {
                                  receiverMap = snapshot.data.docs[0].data();
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
                                                            .spaceBetween,
                                                    children: [
                                                      Flexible(
                                                        child: NunitoText(
                                                          text:
                                                              "${snapshot.data.docs[0].data()["subject"]}",
                                                          fontSize: 14,
                                                          align: TextAlign.left,
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
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
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    NunitoText(
                                                      text: "To : ",
                                                      fontSize: 14,
                                                    ),
                                                    NunitoText(
                                                      text:
                                                          "${snapshot.data.docs[0].data()["otherPerson_name"]}",
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
                                          child: ChatScreen(
                                            currentUsr:
                                                _currentUser.getCurrentUser,
                                            receiverMap: receiverMap,
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
                              });
                        },
                      );
                    } else {
                      return Container(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
