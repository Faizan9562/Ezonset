import 'package:crisislink/Controller/user_controller.dart';
import 'package:crisislink/Model/user.dart';
import 'package:crisislink/View/ProfileViews/ProfileSetup/const/gradient_const.dart';
import 'package:crisislink/View/ProfileViews/ProfileSetup/const/size_const.dart';
import 'package:crisislink/Widgets/TextWidgets/nunito_text.dart';
import 'package:crisislink/Widgets/progressBtn/flutter_progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/services.dart';
import 'package:strings/strings.dart';
import './profile_setup2.dart';

class ProfileSetup extends StatefulWidget {
  _ProfileSetupState createState() => _ProfileSetupState();
}

class _ProfileSetupState extends State<ProfileSetup> {
  List _locations = [
    "Your Country",
    "Afghanistan",
    "Albania",
    "Algeria",
    "Andorra",
    "Angola",
    "Anguilla",
    "Antigua &amp; Barbuda",
    "Argentina",
    "Armenia",
    "Aruba",
    "Australia",
    "Austria",
    "Azerbaijan",
    "Bahamas",
    "Bahrain",
    "Bangladesh",
    "Barbados",
    "Belarus",
    "Belgium",
    "Belize",
    "Benin",
    "Bermuda",
    "Bhutan",
    "Bolivia",
    "Bosnia &amp; Herzegovina",
    "Botswana",
    "Brazil",
    "British Virgin Islands",
    "Brunei",
    "Bulgaria",
    "Burkina Faso",
    "Burundi",
    "Cambodia",
    "Cameroon",
    "Cape Verde",
    "Cayman Islands",
    "Chad",
    "Chile",
    "China",
    "Colombia",
    "Congo",
    "Cook Islands",
    "Costa Rica",
    "Cote D Ivoire",
    "Croatia",
    "Cruise Ship",
    "Cuba",
    "Cyprus",
    "Czech Republic",
    "Denmark",
    "Djibouti",
    "Dominica",
    "Dominican Republic",
    "Ecuador",
    "Egypt",
    "El Salvador",
    "Equatorial Guinea",
    "Estonia",
    "Ethiopia",
    "Falkland Islands",
    "Faroe Islands",
    "Fiji",
    "Finland",
    "France",
    "French Polynesia",
    "French West Indies",
    "Gabon",
    "Gambia",
    "Georgia",
    "Germany",
    "Ghana",
    "Gibraltar",
    "Greece",
    "Greenland",
    "Grenada",
    "Guam",
    "Guatemala",
    "Guernsey",
    "Guinea",
    "Guinea Bissau",
    "Guyana",
    "Haiti",
    "Honduras",
    "Hong Kong",
    "Hungary",
    "Iceland",
    "India",
    "Indonesia",
    "Iran",
    "Iraq",
    "Ireland",
    "Isle of Man",
    "Israel",
    "Italy",
    "Jamaica",
    "Japan",
    "Jersey",
    "Jordan",
    "Kazakhstan",
    "Kenya",
    "Kuwait",
    "Kyrgyz Republic",
    "Laos",
    "Latvia",
    "Lebanon",
    "Lesotho",
    "Liberia",
    "Libya",
    "Liechtenstein",
    "Lithuania",
    "Luxembourg",
    "Macau",
    "Macedonia",
    "Madagascar",
    "Malawi",
    "Malaysia",
    "Maldives",
    "Mali",
    "Malta",
    "Mauritania",
    "Mauritius",
    "Mexico",
    "Moldova",
    "Monaco",
    "Mongolia",
    "Montenegro",
    "Montserrat",
    "Morocco",
    "Mozambique",
    "Namibia",
    "Nepal",
    "Netherlands",
    "Netherlands Antilles",
    "New Caledonia",
    "New Zealand",
    "Nicaragua",
    "Niger",
    "Nigeria",
    "Norway",
    "Oman",
    "Pakistan",
    "Palestine",
    "Panama",
    "Papua New Guinea",
    "Paraguay",
    "Peru",
    "Philippines",
    "Poland",
    "Portugal",
    "Puerto Rico",
    "Qatar",
    "Reunion",
    "Romania",
    "Russia",
    "Rwanda",
    "Saint Pierre &amp; Miquelon",
    "Samoa",
    "San Marino",
    "Satellite",
    "Saudi Arabia",
    "Senegal",
    "Serbia",
    "Seychelles",
    "Sierra Leone",
    "Singapore",
    "Slovakia",
    "Slovenia",
    "South Africa",
    "South Korea",
    "Spain",
    "Sri Lanka",
    "St Kitts &amp; Nevis",
    "St Lucia",
    "St Vincent",
    "St. Lucia",
    "Sudan",
    "Suriname",
    "Swaziland",
    "Sweden",
    "Switzerland",
    "Syria",
    "Taiwan",
    "Tajikistan",
    "Tanzania",
    "Thailand",
    "Timor L'Este",
    "Togo",
    "Tonga",
    "Trinidad &amp; Tobago",
    "Tunisia",
    "Turkey",
    "Turkmenistan",
    "Turks &amp; Caicos",
    "Uganda",
    "Ukraine",
    "United Arab Emirates",
    "United Kingdom",
    "United States",
    "Uruguay",
    "Uzbekistan",
    "Venezuela",
    "Vietnam",
    "Yemen",
    "Zambia",
    "Zimbabwe"
  ];

  TextEditingController _uNameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  String postId = Uuid().v4();

  String myName = "";
  String myUsername = "";
  String _currentLocation = "Your Country";
  String gender = "Male";
  String interestedIn = "Female";

  updateFailedSnackBar(BuildContext context) {
    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;

    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Username Already Exists",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Nunito",
            fontWeight: FontWeight.w900,
            fontSize: 4 * w,
          ),
          textScaleFactor: 1,
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  dpFailedSnackBar(BuildContext context) {
    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;

    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Display Picture Not Uploaded !",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Nunito",
            fontWeight: FontWeight.w900,
            fontSize: 4 * w,
          ),
          textScaleFactor: 1,
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  void changeDropDownLocationItem(String selectedLocation) {
    setState(() {
      _currentLocation = selectedLocation;
    });
  }

  bool _male = true;
  bool _famele = false;

  bool _maleInterest = false;
  bool _fameleInterest = true;
  UserController _currentUser;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;

    _currentUser = Provider.of<UserController>(context);

    OurUser myUser;
    setState(() {
      myUser = _currentUser.getCurrentUser;
    });

    print(_currentUser.getCurrentUser.uid);

    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/profile_setup.png"),
                alignment: Alignment.center,
                repeat: ImageRepeat.repeatY),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height: h * 8.71040,
              ),
              Hero(
                tag: "Logo",
                child: Container(
                  width: 120,
                  child: Image.asset(
                    'assets/images/logo.png',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              NunitoText(
                text: "Setup your Profile",
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: NunitoText(
                  text:
                      "Make sure to use your correct information to avoid suspension",
                  clr: Colors.grey,
                  fontSize: 13,
                  align: TextAlign.center,
                ),
              ),
              SizedBox(
                height: h * 5.2217,
              ),
              StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(myUser.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Map<String, dynamic> data = snapshot.data.data();
                      if (data.containsKey("avatarUrl")) {
                        myUser.avatarUrl = data["avatarUrl"];
                      }
                    }
                    return CircularProfileAvatar(
                      myUser.avatarUrl ?? "",
                      backgroundColor: Colors.black,
                      initialsText: Text(
                        "+",
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w900,
                            fontSize: w * 7.6388,
                            color: Colors.white),
                      ),
                      animateFromOldImageOnUrlChange: true,
                      cacheImage: true,
                      borderColor: Colors.black,
                      borderWidth: 5,
                      elevation: 10,
                      radius: w * 12.7314,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) => AssetGiffyDialog(
                                  buttonOkText: Text(
                                    "Choose From Gallery",
                                    textScaleFactor: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Nunito",
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  image: Image.asset(
                                    "assets/gifs/1.gif",
                                    fit: BoxFit.cover,
                                  ),
                                  entryAnimation: EntryAnimation.TOP_LEFT,
                                  buttonOkColor: Color(0xff8D4BF5),
                                  title: Text(
                                    'Upload your Picture',
                                    textScaleFactor: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  description: Text(
                                    'It is highly advised to use your own image as a profile picture. Other people will see this photo in thier explore section. Our team will review your account based on this image.',
                                    textAlign: TextAlign.center,
                                    textScaleFactor: 1,
                                    style: TextStyle(fontFamily: "Nunito"),
                                  ),
                                  onOkButtonPressed: () async {
                                    await UserController().updateAvatar(
                                        _currentUser.getCurrentUser.uid);
                                    Navigator.of(context).pop();
                                  },
                                ));
                      },
                    );
                  }),
              SizedBox(
                height: h * 6.2217,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    w * 2.0370, h * 0.9954, w * 2.0370, h * 0.9954),
                child: fieldColorBox(
                    SIGNUP_BACKGROUND,
                    "Name",
                    "Your name",
                    _nameController,
                    [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"))]),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    w * 2.0370, h * 0.9954, w * 2.0370, h * 0.9954),
                child: fieldColorBox(
                    SIGNUP_BACKGROUND,
                    "USERNAME",
                    "Your Anonymous Username",
                    _uNameController,
                    [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]"))]),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    w * 2.0370, h * 0.5, w * 2.0370, h * 0.9954),
                child: nexButton("NEXT", context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget locationColorBox(
      Gradient gradient, String title, String currentLocation) {
    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;

    return Padding(
      padding: EdgeInsets.only(
        left: w * 7.63888,
        right: w * 7.63888,
        bottom: h * 0.99547,
      ),
      child: Container(
        height: h * 7.4660,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(w * 2.546),
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
              flex: 3,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: TEXT_SMALL_SIZE,
                  color: Colors.grey,
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w400,
                ),
                textScaleFactor: 1,
              ),
            ),
            Expanded(
              flex: 2,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isDense: false,
                  style: TextStyle(
                    fontSize: TEXT_NORMAL_SIZE,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  isExpanded: true,
                  onChanged: changeDropDownLocationItem,
                  items: _locations.map((items) {
                    return DropdownMenuItem<String>(
                      onTap: () {},
                      value: items,
                      child: Text(
                        items,
                        textScaleFactor: 1,
                      ),
                    );
                  }).toList(),
                  value: currentLocation,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget interestSelectionBox(
      Gradient gradient, String title, String male, String famale) {
    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;

    return Padding(
      padding: EdgeInsets.only(
        left: w * 7.63888,
        right: w * 7.63888,
        bottom: h * 0.99547,
      ),
      child: Column(
        children: [
          NunitoText(
            text: "You are interested in ?",
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Flexible(
                child: Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: Container(
                        width: 100,
                        height: 100,
                        decoration: _maleInterest
                            ? BoxDecoration(
                                // borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 10,
                                    offset: Offset(1.0, 9.0),
                                  ),
                                ],
                                shape: BoxShape.circle,
                                color: Colors.cyan,
                              )
                            : BoxDecoration(
                                // borderRadius: BorderRadius.circular(20),

                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: w * 3.3101, vertical: h * 1.6176),
                          child: Image.asset(
                            "assets/images/male.png",
                            scale: 3,
                          ),
                        )),
                    onTap: () {
                      setState(() {
                        _fameleInterest = false;
                        _maleInterest = true;
                        setState(() {
                          interestedIn = "Male";
                        });
                      });
                    },
                  ),
                ),
              ),
              Flexible(
                child: Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: Container(
                        width: 100,
                        height: 100,
                        decoration: _fameleInterest
                            ? BoxDecoration(
                                // borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 10,
                                    offset: Offset(1.0, 9.0),
                                  ),
                                ],
                                shape: BoxShape.circle,
                                color: Colors.cyan,
                              )
                            : BoxDecoration(
                                // borderRadius: BorderRadius.circular(20),

                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: w * 3.3101, vertical: h * 1.6176),
                          child: Image.asset(
                            "assets/images/female.png",
                            scale: 3,
                          ),
                        )),
                    onTap: () {
                      setState(() {
                        _fameleInterest = true;
                        _maleInterest = false;
                        setState(() {
                          interestedIn = "Female";
                        });
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget genderSelectionBox(
      Gradient gradient, String title, String male, String famale) {
    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;

    return Padding(
      padding: EdgeInsets.only(
        left: w * 7.63888,
        right: w * 7.63888,
        bottom: h * 0.99547,
      ),
      child: Column(
        children: [
          NunitoText(
            text: "Select your Gender",
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Flexible(
                child: Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: Container(
                        width: 100,
                        height: 100,
                        decoration: _male
                            ? BoxDecoration(
                                // borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 10,
                                    offset: Offset(1.0, 9.0),
                                  ),
                                ],
                                shape: BoxShape.circle,
                                color: Colors.cyan,
                              )
                            : BoxDecoration(
                                // borderRadius: BorderRadius.circular(20),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.black38,
                                //     blurRadius: 10,
                                //     offset: Offset(1.0, 9.0),
                                //   ),
                                // ],
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: w * 3.3101, vertical: h * 1.6176),
                          child: Image.asset(
                            "assets/images/male.png",
                            scale: 3,
                          ),
                        )),
                    onTap: () {
                      setState(() {
                        _famele = false;
                        _male = true;
                        setState(() {
                          gender = "Male";
                        });
                      });
                    },
                  ),
                ),
              ),
              Flexible(
                child: Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: Container(
                        width: 100,
                        height: 100,
                        decoration: _famele
                            ? BoxDecoration(
                                // borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 10,
                                    offset: Offset(1.0, 9.0),
                                  ),
                                ],
                                shape: BoxShape.circle,
                                color: Colors.cyan,
                              )
                            : BoxDecoration(
                                // borderRadius: BorderRadius.circular(20),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.black38,
                                //     blurRadius: 10,
                                //     offset: Offset(1.0, 9.0),
                                //   ),
                                // ],
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: w * 3.3101, vertical: h * 1.6176),
                          child: Image.asset(
                            "assets/images/female.png",
                            scale: 3,
                          ),
                        )),
                    onTap: () {
                      setState(() {
                        _famele = true;
                        _male = false;
                        setState(() {
                          gender = "Female";
                        });
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        ],
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
                        setState(() {
                          myName = _nameController.text;
                          myUsername = _uNameController.text.toLowerCase();
                          print(myName);
                          print(myUsername);
                        });
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
    UserController().updateDisplay(camelize(myName));
    await _currentUser.updateUsername(myUsername);
    await _currentUser.updatePushNotifications(true);
    await _currentUser.updateProfileSetupStep(1);
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
              color: Color(0xff31ACCE),
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
              onPressed: _nameController.text.length > 0 &&
                      _uNameController.text.length > 4
                  ? () async {
                      if (_currentUser.getCurrentUser.avatarUrl == null) {
                        await _currentUser.updateDisplay(camelize(myName));
                        dpFailedSnackBar(context);
                      } else {
                        try {
                          var _ref = FirebaseFirestore.instance
                              .collection("users")
                              .where("username", isEqualTo: myUsername)
                              .get();
                          QuerySnapshot docs;
                          docs = await _ref;

                          print(docs.docs);
                          if (docs.docs.length > 0) {
                            updateFailedSnackBar(context);
                          } else {
                            await updateDataToDb();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ProfileSetupTwo()));
                          }
                        } catch (e) {
                          print(e);
                        }
                      }
                    }
                  : null);
        },
      ),
    );
  }
}
