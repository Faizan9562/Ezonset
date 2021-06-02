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

class AdminAddMembers extends StatefulWidget {
  Map orgData;
  AdminAddMembers({this.orgData});

  _AdminAddMembersState createState() => _AdminAddMembersState();
}

class _AdminAddMembersState extends State<AdminAddMembers> {
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

    OurUser myUser;
    setState(() {
      myUser = _currentUser.getCurrentUser;
    });

    return Scaffold(
      backgroundColor: clrbg,
      appBar: AppBar(
        title: Text(
          "Add Members",
          style: TextStyle(color: clrtxt),
        ),
          
        centerTitle: true,
        leading: Icon(Icons.menu, color: Colors.black),
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        child: CircularProfileAvatar(
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NunitoText(
                            text: "AVIVA",
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            clr: clrtxt,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          NunitoText(
                            text: "Admin : Edward Evans",
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            clr: clrtxt,
                          ),
                        ],
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: NunitoText(
                            text: "Corporate",
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            clr: clrtxt,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
                child: Align(
                  alignment: Alignment.center,
                  child: NunitoText(
                    text: "Add Members",
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    clr: clrtxt,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30.0, horizontal: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          NunitoText(
                            text: "#fa230sadsa",
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            clr: clrtxt,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          NunitoText(
                            text:
                                "Send this code to the people you want to add in your organization",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            align: TextAlign.center,
                            clr: clrtxt,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: EdgeInsets.all(30),
                            child: GradientButton(
                              title: "COPY THIS CODE",
                              clrs: [Color(0xffF7931E), Color(0xffF7931E)],
                              onpressed: () {
                                AchievementView(
                                  context,
                                  color: Colors.green,
                                  icon: Icon(
                                    FontAwesomeIcons.copy,
                                    color: Colors.white,
                                  ),
                                  title: "Success !",
                                  elevation: 20,
                                  subTitle:
                                      "The code is copied to your clipboard",
                                  isCircle: true,
                                )..show();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  updateDataToDb() async {
    await _currentUser.updatePushNotifications(true);
  }
}
