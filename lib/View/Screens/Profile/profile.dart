import 'package:ezonset/Model/user.dart';
import 'package:ezonset/View/Screens/Settings/settings.dart';
import 'package:ezonset/View/Widgets/ImageView/image_view.dart';
import "package:flutter/material.dart";
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image/image.dart' as Im;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Profile extends StatefulWidget {
  OurUser myUser;

  Profile({this.myUser,});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool more = false;
  String postId = Uuid().v4();
  bool isUploading = false;
  File file;
  ImagePicker img = ImagePicker();


  convertDate(String date) {
    if (date != null) {
      var newStr = date.substring(0, 10) + ' ' + date.substring(11, 23);
      DateTime dt = DateTime.parse(newStr);
      return DateFormat("EEE, d MMM yyyy").format(dt);
    } else {
      return "N/A";
    }
  }

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

  @override
  Widget build(BuildContext context) {


    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: w * 3.8194, vertical: h * 1.8665),
                child: Container(
                  alignment: Alignment.center,
                  height: h * 6.2217,
                  child: Text(
                    "My Profile",
                    style: TextStyle(
                      fontSize: w * 5.0925,
                      color: Colors.black,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                    textScaleFactor: 1,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: w * 2.5462, vertical: h * 1.2443),
                child: Container(
                  alignment: Alignment.center,
                  child: CircularProfileAvatar(
                    "assets/images/avatar.png",
                    radius: w * 20,
                    backgroundColor: Colors.transparent,
                    borderWidth: 1,
                    borderColor: Colors.deepOrangeAccent,
                    elevation: 20.0,
                    errorWidget: (context, url, error) {
                      return Icon(
                        Icons.face,
                        size: w * 25.462,
                      );
                    },
                    cacheImage: true,
                    onTap: () {
                      setState(() async {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeIn,
                            child: ImageView(
                              url: widget.myUser.avatarUrl,
                            ),
                          ),
                        );
                        // await handleChooseFromGallery(widget.myUser.uid);
                        // Navigator.of(context).pushNamedAndRemoveUntil(
                        //     '/splash', (Route<dynamic> route) => false);
                      });
                    },
                    animateFromOldImageOnUrlChange: true,
                    placeHolder: (context, url) {
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: w * 2.5462, vertical: h * 1.2443),
                child: Text(
                   widget.myUser.displayName,
                  style: TextStyle(
                      fontFamily: "Nunito", fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Text(
                "@${widget.myUser.useranme}",
                  
                  style: TextStyle(
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: w * 5.092, vertical: h * 2.4886),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(w * 5.092),
                        side: BorderSide(color: Colors.deepOrangeAccent,),
                      ),
                      child: const Text(
                        'Edit Profile Details',
                        style: TextStyle(color: Colors.deepOrangeAccent,),
                        textScaleFactor: 1,
                      ),
                      color: Colors.white,
                      elevation: 10.0,
                      splashColor: Color(0xff671AFC),
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeIn,
                            child: Settings(
                              myUser: widget.myUser,
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: w * 5.092, vertical: h * 2.4886),
                child: Column(
                  children: <Widget>[
                    CardDetailRow(
                      myUser: widget.myUser,
                      icon: Icon(Icons.alternate_email),
                      type: "Email",
                      val: widget.myUser.email,
                      clr: Colors.grey[200],
                    ),
                    CardDetailRow(
                      myUser: widget.myUser,
                      icon: Icon(Icons.outlined_flag),
                      type: "Country",
                      val: widget.myUser.country,
                      clr: Colors.grey[20],
                    ),
                    CardDetailRow(
                      myUser: widget.myUser,
                      icon: Icon(Icons.schedule),
                      type: "Phone Number",
                      val: widget.myUser.phone ?? "Not Currently Set",
                      clr: Colors.grey[200],
                    ),
                    more
                        ? CardDetailRow(
                            myUser: widget.myUser,
                            icon: Icon(FontAwesomeIcons.venusMars),
                            type: "Gender",
                            val: widget.myUser.gender,
                            clr: Colors.grey[20],
                          )
                        : Container(),
                    more
                        ? CardDetailRow(
                            myUser: widget.myUser,
                            icon: Icon(Icons.person_outline),
                            type: "Account Type",
                            // val: widget.userFriend.displayName,
                            val: "Buyer",
                            clr: Colors.grey[200],
                          )
                        : Container(),
                    more
                        ? CardDetailRow(
                            myUser: widget.myUser,
                            icon: Icon(Icons.fingerprint),
                            type: "UID",
                            val: widget.myUser.uid,
                            clr: Colors.grey[20],
                          )
                        : Container(),
                    more
                        ? CardDetailRow(
                            myUser: widget.myUser,
                            icon: Icon(Icons.schedule),
                            type: "Account Created",
                            val: "${widget.myUser.accountCreated.toDate().day.toString()}-${widget.myUser.accountCreated.toDate().month.toString()}-${widget.myUser.accountCreated.toDate().year.toString()}",
                            clr: Colors.grey[200],
                          )
                        : Container(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: w * 5.092, vertical: h * 2.4886),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(w * 5.092),
                          ),
                        ),
                        child: Text(
                          more ? "- Show less" : "+ Show More",
                          textScaleFactor: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: "Nunito"),
                        ),
                        onPressed: () {
                          setState(() {
                            more = !more;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CardDetailRow extends StatelessWidget {
  const CardDetailRow(
      {@required this.myUser, this.icon, this.type, this.val, this.clr});

  final OurUser myUser;
  final String type;
  final Icon icon;
  final String val;
  final Color clr;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: clr,
                borderRadius: BorderRadius.all(
                  Radius.circular(w * 5.092),
                ),
              ),
              height: h * 6.2217,
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: w * 2.5462,
                  ),
                  icon,
                  SizedBox(
                    width: w * 2.5462,
                  ),
                  Text(
                    type,
                    textScaleFactor: 1,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontFamily: "Nunito"),
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 2.5462),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          val,
                          textScaleFactor: 1,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w700,
                              color: val == "Not Currently Set"
                                  ? Colors.red
                                  : Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
