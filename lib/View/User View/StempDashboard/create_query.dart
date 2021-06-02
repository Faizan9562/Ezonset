import 'package:crisislink/Controller/user_controller.dart';
import 'package:crisislink/Widgets/TextWidgets/nunito_text.dart';
import 'package:crisislink/Widgets/progressBtn/flutter_progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CreateQuery extends StatefulWidget {
  CreateQuery({Key key, this.title, this.orgData, this.tmData})
      : super(key: key);

  final String title;
  final Map orgData;
  final Map tmData;

  @override
  _CreateQueryState createState() => _CreateQueryState();
}

TextEditingController _ticketSubjectController = TextEditingController();
TextEditingController _servicePriceController = TextEditingController();
TextEditingController _ticketDescriptionController = TextEditingController();
TextEditingController _serviceRequirementController = TextEditingController();
String selectedCategory = "";
String selectedDate = "";

class _CreateQueryState extends State<CreateQuery> {
  String displayPicture = "";
  String _currentCategory = "Graphics and Design";
  String _currentDay = "1";
  String keydoc = Uuid().v4();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;

    UserController _currentUser = Provider.of<UserController>(context);

    print(_currentUser.getCurrentUser.uid);

    void changeDropDownCategoryItem(String selectedCategory) {
      setState(() {
        _currentCategory = selectedCategory;
      });
    }

    void changeDropDownDayItem(String selectedDay) {
      setState(() {
        _currentDay = selectedDay;
      });
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            image: DecorationImage(
              image: AssetImage(
                "assets/images/logo.png",
              ),
            ),
          ),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return GestureDetector(
              child: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff4FC174), Color(0xff00D7A9)],
                  stops: [0.0, 0.9],
                ),
              ),
              alignment: Alignment.center,
              child: NunitoText(
                text: "Create New Query",
                align: TextAlign.center,
                fontWeight: FontWeight.w900,
                clr: Colors.white,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Align(
                alignment: Alignment.centerLeft,
                child: NunitoText(
                  text: "Enter Query Subject",
                  align: TextAlign.left,
                  letterSpacing: 0,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  w * 2.0370, h * 0.9954, w * 2.0370, h * 0),
              child: Padding(
                padding: EdgeInsets.only(
                  left: w * 7.63888,
                  right: w * 7.63888,
                  bottom: h * 0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: FractionalOffset(0.0, 0.4),
                      end: FractionalOffset(0.9, 0.7),
                      stops: [0.1, 0.9],
                      colors: [Colors.white, Colors.white],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple,
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
                              data: MediaQuery.of(context).copyWith(
                                  textScaleFactor: MediaQuery.of(context)
                                              .textScaleFactor >
                                          1.0
                                      ? 1.0
                                      : MediaQuery.of(context).textScaleFactor),
                              child: TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: 1,
                                controller: _ticketSubjectController,
                                decoration: InputDecoration(
                                  hintText: "Give a subject to your problem",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    fontSize: 15,
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
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Align(
                alignment: Alignment.centerLeft,
                child: NunitoText(
                  text: "Desribe your problem",
                  align: TextAlign.left,
                  letterSpacing: 0,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  w * 2.0370, h * 0.9954, w * 2.0370, h * 0),
              child: Padding(
                padding: EdgeInsets.only(
                  left: w * 7.63888,
                  right: w * 7.63888,
                  bottom: h * 0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: FractionalOffset(0.0, 0.4),
                      end: FractionalOffset(0.9, 0.7),
                      stops: [0.1, 0.9],
                      colors: [Colors.white, Colors.white],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple,
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
                              data: MediaQuery.of(context).copyWith(
                                  textScaleFactor: MediaQuery.of(context)
                                              .textScaleFactor >
                                          1.0
                                      ? 1.0
                                      : MediaQuery.of(context).textScaleFactor),
                              child: TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: 8,
                                controller: _ticketDescriptionController,
                                decoration: InputDecoration(
                                  hintText:
                                      "Enter a brief description of your service",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    fontSize: 15,
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
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: NunitoText(
                  text: "Your real name will be kept hidden",
                  align: TextAlign.center,
                  clr: Colors.grey,
                  fontSize: 12,
                )),
            SizedBox(
              height: 40,
            ),
            Container(
              width: 250,
              child: ProgressButton(
                borderRadius: 30,
                color: Colors.orange,
                animate: false,
                defaultWidget: NunitoText(
                  text: "Create Ticket",
                  fontWeight: FontWeight.w900,
                  clr: Colors.white,
                ),
                progressWidget: SpinKitThreeBounce(
                  color: Colors.white,
                  size: w * 5.0925,
                ),
                width: double.infinity,
                height: 5 * h,
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection("tickets")
                      .doc(keydoc)
                      .set({
                    "ticketId": keydoc,
                    "sender_Id": _currentUser.getCurrentUser.uid,
                    "receiver_Id": widget.tmData["uid"],
                    "timestamp": FieldValue.serverTimestamp(),
                    "type": "text",
                    "otherPersonId": widget.tmData["uid"],
                    "subject": _ticketSubjectController.text,
                    "description": _ticketDescriptionController.text,
                    "sender_userName": _currentUser.getCurrentUser.useranme,
                    "receiver_userName": widget.tmData["username"],
                    "otherPerson_name": widget.tmData["displayName"],
                    "status": "open",
                  });

                  await FirebaseFirestore.instance
                      .collection("ticketsRoom")
                      .doc(keydoc)
                      .set({
                    "ticketId": keydoc,
                    "my_Id": _currentUser.getCurrentUser.uid,
                    "otherPersonId": widget.tmData["uid"],
                    "status": "open",
                  });

                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
