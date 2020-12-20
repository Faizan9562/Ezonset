
import 'package:achievement_view/achievement_view.dart';
import 'package:android_power_manager/android_power_manager.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezonset/Model/user.dart';
import 'package:ezonset/View/Screens/Settings/TOS.dart';
import 'package:ezonset/View/Screens/Settings/privacy_policy.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/components/toggle/gf_toggle.dart';
import 'package:getflutter/types/gf_toggle_type.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image/image.dart' as Im;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Settings extends StatefulWidget {
  OurUser myUser;

  Settings({this.myUser});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String phone;
  bool valid = false;
  FirebaseUser user;
  String postId = Uuid().v4();
  bool isUploading = false;
  File file;
  ImagePicker img = ImagePicker();
  String _isIgnoringBatteryOptimizations = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<String> _checkBatteryOptimizations() async {
    String isIgnoringBatteryOptimizations;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      isIgnoringBatteryOptimizations =
          '${await AndroidPowerManager.isIgnoringBatteryOptimizations}';
    } on PlatformException {
      isIgnoringBatteryOptimizations = 'Failed to get platform version.';
    }
    return isIgnoringBatteryOptimizations;
  }

  Future<void> initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    String isIgnoringBatteryOptimizations = await _checkBatteryOptimizations();
    setState(() {
      _isIgnoringBatteryOptimizations = isIgnoringBatteryOptimizations;
    });
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
    TextEditingController nameController = new TextEditingController();
    TextEditingController currentPasswordController =
        new TextEditingController();
    TextEditingController newPasswordController = new TextEditingController();
    TextEditingController confirmPasswordController =
        new TextEditingController();

    String currPassError;

    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;

    failedSnackBar(BuildContext context, String error) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error,
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

    _onAlertforEditName(context) {
      AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.NO_HEADER,
          title: "Edit Name",
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: w * 5.092, vertical: h * 2.488),
              child: TextField(
                  controller: nameController,
                  decoration: new InputDecoration(
                    labelText: "Enter new name",
                    labelStyle:
                        TextStyle(color: Colors.black, fontFamily: "Nunito"),
                    fillColor: Colors.black,
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(w * 6.3657),
                      borderSide: new BorderSide(
                        color: Color(0xff671AFC),
                      ),
                    ),
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(w * 6.3657),
                      borderSide: new BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(w * 6.3657),
                      borderSide: new BorderSide(
                        color: Color(0xff671AFC),
                      ),
                    ),
                    // fillColor: Colors.green
                  ),
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: null),
            ),
          ),
          dismissOnBackKeyPress: true,
          isDense: false,
          btnOkText: "Change Name",
          btnOkOnPress: () {
            if (nameController.text.length < 3) {
              null;
            } else {
              Firestore.instance
                  .collection("users")
                  .document(widget.myUser.uid)
                  .updateData({"displayName": nameController.text});
            }
            nameController.clear();
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/splash', (Route<dynamic> route) => false);
          })
        ..show();
    }

    _onAlertforEditPhone() {
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.NO_HEADER,
        title: "Edit Phone",
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: w * 5.092, vertical: h * 2.488),
            child: InternationalPhoneNumberInput(
              inputDecoration: InputDecoration(
                isDense: true,
                alignLabelWithHint: true,
                enabledBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(w * 6.3657),
                  borderSide: new BorderSide(
                    color: Color(0xff671AFC),
                  ),
                ),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(w * 6.3657),
                  borderSide: new BorderSide(
                    color: Colors.black,
                  ),
                ),
                focusedBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(w * 6.3657),
                  borderSide: new BorderSide(
                    color: Color(0xff671AFC),
                  ),
                ),
              ),
              searchBoxDecoration: InputDecoration(
                isDense: true,
                alignLabelWithHint: true,
                enabledBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(w * 6.3657),
                  borderSide: new BorderSide(
                    color: Color(0xff671AFC),
                  ),
                ),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(w * 6.3657),
                  borderSide: new BorderSide(
                    color: Colors.black,
                  ),
                ),
                focusedBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(w * 6.3657),
                  borderSide: new BorderSide(
                    color: Color(0xff671AFC),
                  ),
                ),
              ),
              onInputValidated: (value) {
                setState(() {
                  valid = value;
                });
              },
              autoFocusSearch: true,
              countrySelectorScrollControlled: true,
              autoValidate: true,
              formatInput: true,
              hintText: "Enter phone number",
              ignoreBlank: false,
              textStyle: TextStyle(fontFamily: "Nunito"),
              onInputChanged: (value) {
                phone = value.phoneNumber;
                print(phone);
              },
              selectorConfig: SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              ),
            ),
          ),
        ),
        dismissOnBackKeyPress: true,
        isDense: true,
        btnOk: RaisedButton(
          color: Color(0xff00CA6E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            "Change phone number",
            textScaleFactor: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "Nunito",
                fontWeight: FontWeight.w700,
                color: Colors.white),
          ),
          onPressed: () {
            if (valid) {
              Firestore.instance
                  .collection("users")
                  .document(widget.myUser.uid)
                  .updateData({
                "phone": phone.toString(),
              });
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/splash', (Route<dynamic> route) => false);
            } else {
              null;
            }
          },
        ),
      )..show();
    }

    _onAlertforChangePassword(BuildContext context) {
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.NO_HEADER,
        title: "Change Password",
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: w * 5.092, vertical: h * 2.488),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextField(
                  controller: currentPasswordController,
                  decoration: new InputDecoration(
                    labelText: "Enter current password",
                    labelStyle:
                        TextStyle(color: Colors.black, fontFamily: "Nunito"),
                    fillColor: Colors.black,
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(w * 6.3657),
                      borderSide: new BorderSide(
                        color: Color(0xff671AFC),
                      ),
                    ),
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(w * 6.3657),
                      borderSide: new BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(w * 6.3657),
                      borderSide: new BorderSide(
                        color: Color(0xff671AFC),
                      ),
                    ),
                    // fillColor: Colors.green
                  ),
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: null,
                ),
                SizedBox(
                  height: h * 1.244,
                ),
                TextField(
                  controller: newPasswordController,
                  decoration: new InputDecoration(
                    labelText: "Enter new Password",
                    labelStyle:
                        TextStyle(color: Colors.black, fontFamily: "Nunito"),
                    fillColor: Colors.black,
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(w * 6.3657),
                      borderSide: new BorderSide(
                        color: Color(0xff671AFC),
                      ),
                    ),
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(w * 6.3657),
                      borderSide: new BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(w * 6.3657),
                      borderSide: new BorderSide(
                        color: Color(0xff671AFC),
                      ),
                    ),
                    // fillColor: Colors.green
                  ),
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: null,
                ),
                SizedBox(
                  height: h * 1.244,
                ),
                TextField(
                  controller: confirmPasswordController,
                  decoration: new InputDecoration(
                    labelText: "Confirm new Password",
                    labelStyle:
                        TextStyle(color: Colors.black, fontFamily: "Nunito"),
                    fillColor: Colors.black,
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(w * 6.3657),
                      borderSide: new BorderSide(
                        color: Color(0xff671AFC),
                      ),
                    ),
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(w * 6.3657),
                      borderSide: new BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(w * 6.3657),
                      borderSide: new BorderSide(
                        color: Color(0xff671AFC),
                      ),
                    ),
                    // fillColor: Colors.green
                  ),
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: null,
                ),
              ],
            ),
          ),
        ),
        dismissOnBackKeyPress: true,
        isDense: true,
        btnOk: Builder(
          builder: (contxt) {
            return RaisedButton(
              color: Color(0xff00CA6E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                "Change Password",
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              onPressed: () async {
                AuthResult authResult;
                if (newPasswordController.text.length >= 6 &&
                    confirmPasswordController.text.length >= 6 &&
                    newPasswordController.text ==
                        confirmPasswordController.text) {
                  try {
                    FirebaseUser user =
                        await FirebaseAuth.instance.currentUser();
                    authResult = await user.reauthenticateWithCredential(
                        EmailAuthProvider.getCredential(
                            email: widget.myUser.email,
                            password: currentPasswordController.text));
                    authResult.user.updatePassword(newPasswordController.text);
                    AchievementView(context,
                        color: Colors.greenAccent,
                        title: "Success !",
                        elevation: 20,
                        subTitle: "Your password has been changed",
                        isCircle: true, listener: (status) {
                      print(status);
                    })
                      ..show();
                  } on PlatformException catch (e) {
                    AchievementView(context,
                        title: "Error !",
                        elevation: 20,
                        subTitle: "${e.message}",
                        isCircle: true, listener: (status) {
                      print(status);
                    })
                      ..show();
                  }
                } else {
                  AchievementView(context,
                      title: "Error!",
                      subTitle:
                          "The new password needs to be atleast 6 characters long and new password in both fields need to match !",
                      isCircle: true, listener: (status) {
                    print(status);
                  })
                    ..show();
                }
              },
            );
          },
        ),
      )..show();
    }

    _onAlertforEmailVerification() {
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.NO_HEADER,
        title: "Email Verification",
        body: Center(
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: w * 5.092, vertical: h * 0.488),
              child: Text(
                "Send Verification email on ${widget.myUser.email}\n\n Follow the link in the email to verify your account",
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Nunito",
                ),
              )),
        ),
        dismissOnBackKeyPress: true,
        isDense: true,
        btnOk: RaisedButton(
          color: Color(0xff00CA6E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            "Send Verification Request",
            textScaleFactor: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "Nunito",
                fontWeight: FontWeight.w700,
                color: Colors.white),
          ),
          onPressed: () async {
            FirebaseUser user = await FirebaseAuth.instance.currentUser();
            if (!user.isEmailVerified) {
              await user.sendEmailVerification();
              AchievementView(context,
                  title: "Success !",
                  elevation: 20,
                  subTitle:
                      "Verification request email sent to ${widget.myUser.email}. Make sure to check your Junk/spam folder for the email.",
                  isCircle: true, listener: (status) {
                print(status);
              })
                ..show();
            } else {
              AchievementView(context,
                  title: "Success !",
                  elevation: 20,
                  subTitle: "Email is already verified !",
                  isCircle: true, listener: (status) {
                print(status);
              })
                ..show();
            }
          },
        ),
      )..show();
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            child: Stack(
              children: <Widget>[
                Container(
                  height: h * 37.330,
                  decoration: new BoxDecoration(
                    color: Colors.deepOrangeAccent,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, w * 7.638),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: h * 2.4886,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: w * 5.092, vertical: h * 2.4886),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: w * 6.3657,
                          ),
                          SizedBox(
                            width: w * 1.273,
                          ),
                          Text(
                            "Settings",
                            textScaleFactor: 1,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w900,
                                fontSize: w * 6.3657,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: w * 3.819, vertical: h * 1.8665),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              w * 5.092,
                            ),
                          ),
                        ),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: w * 5.092,
                                    vertical: h * 2.4886),
                                child: Row(
                                  children: <Widget>[
                                    CircularProfileAvatar(
                                      widget.myUser.avatarUrl,
                                      radius: w * 6.3657,
                                      backgroundColor: Colors.transparent,
                                      borderWidth: 1,
                                      borderColor: Colors.deepOrangeAccent,
                                      elevation: 5.0,
                                      errorWidget: (context, url, error) {
                                        return Icon(
                                          Icons.face,
                                          size: w * 10,
                                        );
                                      },
                                      cacheImage: true,
                                      onTap: () async {
                                        await handleChooseFromGallery(
                                            widget.myUser.uid);
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                '/splash',
                                                (Route<dynamic> route) =>
                                                    false);
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
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: w * 2.5462,
                                          vertical: h * 1.2443),
                                      child: Text(
                                        widget.myUser.displayName,
                                        textScaleFactor: 1,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: "Nunito",
                                            letterSpacing: 0.5,
                                            fontSize: w * 5.092,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: h * 0.1244,
                                color: Colors.grey,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: w * 5.092,
                                    vertical: h * 2.4886),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: w * 5.092,
                                          vertical: h * 2.4886),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Profile Settings",
                                        textScaleFactor: 1,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: "Nunito",
                                            fontWeight: FontWeight.w900,
                                            color: Colors.orange),
                                      ),
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        color: Colors.transparent,
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: h * 2.4886),
                                              child: Text(
                                                "Edit Name",
                                                textScaleFactor: 1,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontFamily: "Nunito",
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            Icon(
                                              FontAwesomeIcons.arrowRight,
                                              size: 12,
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        _onAlertforEditName(context);
                                      },
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        color: Colors.transparent,
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: h * 2.4886),
                                              child: Text(
                                                "Edit Phone number",
                                                textScaleFactor: 1,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontFamily: "Nunito",
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            Icon(
                                              FontAwesomeIcons.arrowRight,
                                              size: 12,
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        _onAlertforEditPhone();
                                      },
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: h * 2.4886),
                                              child: Text(
                                                "Change Password",
                                                textScaleFactor: 1,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontFamily: "Nunito",
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            Icon(
                                              FontAwesomeIcons.arrowRight,
                                              size: 12,
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        _onAlertforChangePassword(context);
                                      },
                                    ),
                                    GestureDetector(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: h * 2.4886),
                                            child: Text(
                                              "Email Status",
                                              textScaleFactor: 1,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontFamily: "Nunito",
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: w * 2.0370),
                                                  child: FutureBuilder<
                                                      FirebaseUser>(
                                                    future: FirebaseAuth
                                                        .instance
                                                        .currentUser(),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        print(snapshot.data
                                                            .isEmailVerified);
                                                        return snapshot.data
                                                                .isEmailVerified
                                                            ? Text(
                                                                "Verified",
                                                                textScaleFactor: 1,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Nunito",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Color(
                                                                        0xff00CA6E)),
                                                              )
                                                            : Text(
                                                                "Not Verified",
                                                                textScaleFactor: 1,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Nunito",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .red),
                                                              );
                                                      } else {
                                                        return Text(
                                                          "Checking ...",
                                                          textScaleFactor: 1,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Nunito",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.red),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ),
                                                Icon(
                                                  FontAwesomeIcons.arrowRight,
                                                  size: w * 3.0555,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        _onAlertforEmailVerification();
                                      },
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: w * 5.092,
                                          vertical: h * 2.4886),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Notification Settings",
                                        textScaleFactor: 1,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: "Nunito",
                                            fontWeight: FontWeight.w900,
                                            color: Colors.orange),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: h * 2.4886),
                                          child: Text(
                                            "Push Notifications",
                                            textScaleFactor: 1,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontFamily: "Nunito",
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),
                                          ),
                                        ),
                                        GFToggle(
                                          onChanged: (val) {
                                            Firestore.instance.collection("users").document(widget.myUser.uid).updateData({
                                              "pushNotifications": val
                                            });
                                          },
                                          value: true,
                                          type: GFToggleType.android,
                                          enabledTrackColor: Colors.greenAccent,
                                        )
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: w * 5.092,
                                          vertical: h * 2.4886),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Application Settings",
                                        textScaleFactor: 1,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: "Nunito",
                                            fontWeight: FontWeight.w900,
                                            color: Colors.orange),
                                      ),
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        color: Colors.transparent,
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: h * 2.4886),
                                              child: Text(
                                                "Background Updates",
                                                textScaleFactor: 1,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontFamily: "Nunito",
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                w * 2.0370),
                                                    child:
                                                        _isIgnoringBatteryOptimizations ==
                                                                "true"
                                                            ? Text(
                                                                "Allowed",
                                                                textScaleFactor: 1,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Nunito",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Color(
                                                                        0xff00CA6E)),
                                                              )
                                                            : Text(
                                                                "Not Allowed",
                                                                textScaleFactor: 1,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Nunito",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                  ),
                                                  Icon(
                                                    FontAwesomeIcons.arrowRight,
                                                    size: w * 3.0555,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () async {
                                        await Permission.ignoreBatteryOptimizations.request();
                                        
                                      },
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: w * 5.092,
                                          vertical: h * 2.4886),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "About",
                                        textScaleFactor: 1,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: "Nunito",
                                            fontWeight: FontWeight.w900,
                                            color: Colors.orange),
                                      ),
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        color: Colors.transparent,
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: h * 2.4886),
                                              child: Text(
                                                "Terms and Conditions",
                                                textScaleFactor: 1,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontFamily: "Nunito",
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            Icon(
                                              FontAwesomeIcons.arrowRight,
                                              size: 12,
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          duration: Duration(milliseconds: 200),
                                          curve: Curves.easeIn,
                                          child: TOS()),
                                    );
                                      },
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        color: Colors.transparent,
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: h * 2.4886),
                                              child: Text(
                                                "Privacy Policy",
                                                textScaleFactor: 1,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontFamily: "Nunito",
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            Icon(
                                              FontAwesomeIcons.arrowRight,
                                              size: 12,
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          duration: Duration(milliseconds: 200),
                                          curve: Curves.easeIn,
                                          child: PrivacyPolicy()),
                                    );
                                      },
                                    ),
                                    // GestureDetector(
                                    //   child: Container(
                                    //     color: Colors.transparent,
                                    //     width: double.infinity,
                                    //     child: Row(
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.spaceBetween,
                                    //       children: <Widget>[
                                    //         Container(
                                    //           padding: EdgeInsets.symmetric(
                                    //               vertical: h * 2.4886),
                                    //           child: Text(
                                    //             "About us",
                                    //             textScaleFactor: 1,
                                    //             textAlign: TextAlign.left,
                                    //             style: TextStyle(
                                    //                 fontFamily: "Nunito",
                                    //                 fontWeight: FontWeight.w500,
                                    //                 color: Colors.black),
                                    //           ),
                                    //         ),
                                    //         Icon(
                                    //           FontAwesomeIcons.arrowRight,
                                    //           size: 12,
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    //   onTap: () {
                                    //     _onAlertforEditName(context);
                                    //   },
                                    // ),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   children: <Widget>[
                                    //     Container(
                                    //       padding: EdgeInsets.symmetric(
                                    //           vertical: h * 2.4886),
                                    //       child: Text(
                                    //         "Theme",
                                    //         textScaleFactor: 1,
                                    //         textAlign: TextAlign.left,
                                    //         style: TextStyle(
                                    //             fontFamily: "Nunito",
                                    //             fontWeight: FontWeight.w500,
                                    //             color: Colors.black),
                                    //       ),
                                    //     ),
                                    //     DayNightSwitcherIcon(
                                    //       isDarkModeEnabled: theme.darkTheme,
                                    //       onStateChanged: (isDarkModeEnabled) {
                                    //         setState(() {
                                    //           theme.toggleTheme();
                                    //         });
                                    //       },
                                    //     ),
                                    //   ],
                                    // ),
                                    // GestureDetector(
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.spaceBetween,
                                    //     children: <Widget>[
                                    //       Container(
                                    //         padding: EdgeInsets.symmetric(
                                    //             vertical: h * 2.4886),
                                    //         child: Text(
                                    //           "About Us",
                                    //           textScaleFactor: 1,
                                    //           textAlign: TextAlign.left,
                                    //           style: TextStyle(
                                    //               fontFamily: "Nunito",
                                    //               fontWeight: FontWeight.w500,
                                    //               color: Colors.black),
                                    //         ),
                                    //       ),
                                    //       Container(
                                    //         child: Row(
                                    //           children: <Widget>[
                                    //             Icon(
                                    //               FontAwesomeIcons.arrowRight,
                                    //               size: w * 3.0555,
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       )
                                    //     ],
                                    //   ),
                                    //   onTap: () {},
                                    // ),
                                    // GestureDetector(
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.spaceBetween,
                                    //     children: <Widget>[
                                    //       Container(
                                    //         padding: EdgeInsets.symmetric(
                                    //             vertical: h * 2.4886),
                                    //         child: Text(
                                    //           "Contact Us",
                                    //           textScaleFactor: 1,
                                    //           textAlign: TextAlign.left,
                                    //           style: TextStyle(
                                    //               fontFamily: "Nunito",
                                    //               fontWeight: FontWeight.w500,
                                    //               color: Colors.black),
                                    //         ),
                                    //       ),
                                    //       Container(
                                    //         child: Row(
                                    //           children: <Widget>[
                                    //             Icon(
                                    //               FontAwesomeIcons.arrowRight,
                                    //               size: w * 3.0555,
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       )
                                    //     ],
                                    //   ),
                                    //   onTap: () {},
                                    // ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
