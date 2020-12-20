
import 'package:ezonset/Constants/gradient_const.dart';
import 'package:ezonset/Constants/size_const.dart';
import 'package:ezonset/RootController/root.dart';
import 'package:ezonset/View/Screens/homepage.dart';
import 'package:ezonset/View/Widgets/progressBtn/flutter_progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image/image.dart' as Im;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ezonset/Model/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezonset/Controller/userController/userController.dart';
import 'package:provider/provider.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/services.dart';
import 'package:strings/strings.dart';

class ProfileSetup extends StatefulWidget {
  _ProfileSetupState createState() => _ProfileSetupState();
}

class _ProfileSetupState extends State<ProfileSetup> {
  List _locations = [
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
  String _currentLocation = "United States";
  String gender = "Male";
  var avatar;

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

  bool isUploading = false;
  File file;
  ImagePicker img = ImagePicker();

  handleChooseFromGallery(String uid) async {
    var getImage = await img.getImage(
        source: ImageSource.gallery, maxWidth: 1920, maxHeight: 1080);
    File file = File(getImage.path);
    setState(() {
      this.file = file;
    });
    if (file != null) {
      await uploadToStorage(uid);
    }
  }

  uploadToStorage(String uid) async {
    setState(() {
      isUploading = true;
    });
    await compressImage();
    String mediaUrl = await uploadImage(file, uid);
    await updatePostInFirestore(mediaUrl: mediaUrl, uid: uid);

    setState(() {
      isUploading = false;
      postId = Uuid().v4();
    });
  }

  compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image imageFile = Im.decodeImage(file.readAsBytesSync());
    final compressedImageFile = File("$path/img_$postId.jpg")
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 90));
    setState(() {
      file = compressedImageFile;
    });
  }

  Future<String> uploadImage(imageFile, String uid) async {
    StorageUploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child("profilePictures/$uid.jpg")
        .putFile(imageFile);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }

  updatePostInFirestore({String mediaUrl, String uid}) async {
    print("THE POST ID IS $postId");
    print(uid);
    await Firestore.instance.collection("users").document(uid).updateData({
      "avatarUrl": mediaUrl,
    });
  }

  bool _male = true;
  bool _famele = false;
  UserController _currentUser;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;

    _currentUser = Provider.of<UserController>(context, listen: false);

    OurUser myUser;
    setState(() {
      myUser = _currentUser.getCurrentUser;
    });

    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background/profile_setup.png"),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height: h * 8.71040,
              ),
              Image.asset(
                'assets/images/logov3.png',
                scale: 1.5,
              ),
              SizedBox(
                height: h * 6.2217,
              ),
              GestureDetector(
                child: StreamBuilder<DocumentSnapshot>(
                    stream: Firestore.instance
                        .collection("users")
                        .document(myUser.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.data.data["avatarUrl"] != null) {
                        print(snapshot.data.data);
                        avatar = snapshot.data.data["avatarUrl"];
                        return CircularProfileAvatar(
                          avatar,
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
                          cacheImage: true,
                          borderColor: Colors.black,
                          borderWidth: 5,
                          elevation: 10,
                          radius: w * 12.7314,
                        );
                      } else {
                        return CircularProfileAvatar(
                          "",
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
                          cacheImage: true,
                          borderColor: Colors.black,
                          borderWidth: 5,
                          elevation: 10,
                          radius: w * 12.7314,
                        );
                      }
                    }),
                onTap: () {
                  setState(() async {
                    await handleChooseFromGallery(myUser.uid);
                  });
                },
              ),
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
                    "Your Username",
                    _uNameController,
                    [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]"))]),
              ),
              Wrap(children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      w * 2.0370, h * 0.9954, w * 2.0370, h * 0.9954),
                  child: locationColorBox(
                      SIGNUP_BACKGROUND, "Country", _currentLocation),
                ),
              ]),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    w * 5.09259, h * 2.4886, w * 5.09259, h * 2.4886),
                child: shadowColorBox(
                    SIGNUP_CARD_BACKGROUND, "GENDER", "Male", "Female"),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    w * 2.0370, h * 0.9954, w * 2.0370, h * 0.9954),
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
              color: Colors.black38,
              blurRadius: 05,
              offset: Offset(1.0, 1.0),
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

  Widget shadowColorBox(
      Gradient gradient, String title, String male, String famale) {
    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;

    return Padding(
      padding: EdgeInsets.only(
        left: w * 7.63888,
        right: w * 7.63888,
        bottom: h * 0.99547,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Flexible(
            child: Align(
              alignment: Alignment.center,
              child: GestureDetector(
                child: Container(
                    width: w * 12.731,
                    height: h * 6.2217,
                    decoration: _male
                        ? BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 30,
                              offset: Offset(1.0, 9.0),
                            ),
                          ], shape: BoxShape.circle, color: Colors.black)
                        : BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black38,
                                blurRadius: 30,
                                offset: Offset(1.0, 9.0),
                              ),
                            ],
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: w * 3.3101, vertical: h * 1.6176),
                      child: Image.asset(
                        "assets/background/male.png",
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
                    width: w * 12.731,
                    height: h * 6.2217,
                    decoration: _famele
                        ? BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black38,
                                blurRadius: 30,
                                offset: Offset(1.0, 9.0),
                              ),
                            ],
                            shape: BoxShape.circle,
                            color: Colors.black,
                          )
                        : BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black38,
                                blurRadius: 30,
                                offset: Offset(1.0, 9.0),
                              ),
                            ],
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: w * 3.3101, vertical: h * 1.6176),
                      child: Image.asset(
                        "assets/background/female.png",
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
              color: Colors.black38,
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
    await _currentUser.updateDisplay(camelize(myName));
    await _currentUser.updateUsername(myUsername);
    await _currentUser.updateCountry(_currentLocation);
    await _currentUser.updateGender(gender);
    await _currentUser.updatePushNotifications();
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
              borderRadius: 20,
              color: Color(0xff00d8cd),
              animate: false,
              defaultWidget: const Text(
                'Next',
                style: TextStyle(
                  letterSpacing: 2,
                  color: Colors.white,
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w900,
                ),
                textScaleFactor: 1,
                textAlign: TextAlign.center,
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
                    if(avatar == null) {
                      await _currentUser.updateDisplay(camelize(myName));
                      dpFailedSnackBar(context);
                    }
                    else {
                      try {
                        var _ref = Firestore.instance
                            .collection("users")
                            .where("username", isEqualTo: myUsername)
                            .getDocuments();
                        QuerySnapshot docs;
                        docs = await _ref;

                        print(docs.documents);
                        if (docs.documents.length > 0) {
                          updateFailedSnackBar(context);
                        } else {
                          await updateDataToDb();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => OurRoot()));
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
