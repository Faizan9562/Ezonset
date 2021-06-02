import 'dart:io';
import 'package:crisislink/Controller/user_controller.dart';
import 'package:crisislink/Model/messages.dart';
import 'package:crisislink/Model/user.dart';
import 'package:crisislink/Widgets/TextWidgets/nunito_text.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:firebase_core/firebase_core.dart';

import './cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:image/image.dart' as Im;
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './custom_tile.dart';

class ChatScreen extends StatefulWidget {
  OurUser currentUsr;
  OurUser receiver;
  List<String> chats;
  Map receiverMap;
  String status;

  ChatScreen({this.currentUsr, this.receiver, this.receiverMap, this.status});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FocusNode textFieldFocusNode = FocusNode();
  TextEditingController textFieldController = TextEditingController();
  ScrollController _listScrollController = ScrollController();
  // ImageUploadProvider _imageUploadProvider;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  String fcmToken;
  File file;
  ImagePicker img = ImagePicker();
  bool isUploading = false;
  String postId = Uuid().v4();
  String descrption;
  String blurHash;

  bool isWriting = false;
  bool showEmojiPicker = false;
  bool showTime = false;

  showKeyboard() => textFieldFocusNode.requestFocus();
  hideKeyboard() => textFieldFocusNode.unfocus();

  // ============= Emoji Container =================

  emojiContainer() {
    return EmojiPicker(
      bgColor: Theme.of(context).backgroundColor,
      indicatorColor: Colors.cyan,
      rows: 3,
      columns: 7,
      onEmojiSelected: (emoji, caterogy) {
        setState(() {
          isWriting = true;
        });

        textFieldController.text = textFieldController.text + emoji.emoji;
      },
    );
  }

  hideEmojiContainer() {
    setState(() {
      showEmojiPicker = false;
    });
  }

  showEmojiContainer() {
    setState(() {
      showEmojiPicker = true;
    });
  }

  // ============= Emoji Container =================

  // ============== IMAGGGEEE HANDLEEERR ==============

  handleTakePhoto() async {
    var getImage = await img.getImage(
        source: ImageSource.camera, maxHeight: 675, maxWidth: 960);
    File file = File(getImage.path);
    setState(() {
      this.file = file;
    });
  }

  compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image imageFile = Im.decodeImage(file.readAsBytesSync());
    final compressedImageFile = File("$path/diaryImg_$postId.jpg")
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 90));
    setState(() {
      file = compressedImageFile;
    });
  }

  // Future<String> getBlurHash(File imageFile) async {
  //   Uint8List bytes = await imageFile.readAsBytes();
  //   var blurHash = await BlurHash.encode(bytes, 2, 2);
  //   return blurHash;
  // }

  Future<String> uploadImage(imageFile, String uid) async {
    String downloadUrl;
    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child(widget.currentUsr.uid)
        .child("MessageImage")
        .child("path_$postId.jpg")
        .putFile(imageFile);
    await uploadTask.whenComplete(() async {
      print("about to aquire");
      downloadUrl = await uploadTask.snapshot.ref.getDownloadURL();
    });
    print("after aquire");
    return downloadUrl;
  }

  // void setImageMsg(String url, OurUser receiver, OurUser sender) async {
  //   Message _message;

  //   _message = Message.imageMessage(
  //       message: "Image",
  //       receiverId: receiver.uid,
  //       senderId: sender.uid,
  //       photoUrl: url,
  //       type: 'image',
  //       isSaved: false,
  //       serverTime: FieldValue.serverTimestamp());
  //   var map = _message.toImageMap();

  //   // add the data to Db
  //   print("uploading image to database");
  //   await FirebaseFirestore.instance
  //       .collection("messages")
  //       .doc(sender.chatRoomId)
  //       .collection("value")
  //       .add(map);
  // }

  // handleSubmit() async {
  //   setState(() {
  //     isUploading = true;
  //   });
  //   await compressImage();
  //   String mediaUrl = await uploadImage(file, widget.currentUsr.uid);
  //   blurHash = await getBlurHash(file);
  //   setImageMsg(mediaUrl, widget.receiver, widget.currentUsr);
  //   setState(() {
  //     isUploading = false;
  //     postId = Uuid().v4();
  //   });
  // }

  // handleChooseFromGallery() async {
  //   var getImage = await img.getImage(
  //       source: ImageSource.gallery, maxWidth: 1920, maxHeight: 1080);
  //   File file = File(getImage.path);
  //   setState(() {
  //     this.file = file;
  //   });
  //   if (file != null) {
  //     handleSubmit();
  //   }
  // }

  // handleTakePhotoFromCamera() async {
  //   await handleTakePhoto();
  //   await handleSubmit();
  // }

  // ============================================

  // ============= AppBar =================

  AppBar customAppBar(context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        color: Colors.black,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: [
        widget.currentUsr.type == "Student" ||
                widget.currentUsr.type == "Employee"
            ? GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 30,
                  ),
                ),
                onTap: () {
                  FirebaseFirestore.instance
                      .collection("ticketsRoom")
                      .doc(widget.receiverMap["ticketId"])
                      .update({
                    "status": "close",
                  });

                  Navigator.of(context).pop();
                },
              )
            : Container()
      ],
      centerTitle: false,
      title: titleWidget(),
    );
  }

  // DateTime getDate(dynamic timeStamp) {
  //   var date = DateTime.fromMillisecondsSinceEpoch(timeStamp);
  //   return date;
  // }

  // String timeAgo(DateTime d) {
  //   Duration diff = DateTime.now().difference(d);
  //   if (diff.inDays > 365)
  //     return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
  //   if (diff.inDays > 30)
  //     return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
  //   if (diff.inDays > 7)
  //     return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
  //   if (diff.inDays > 0)
  //     return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
  //   if (diff.inHours > 0)
  //     return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
  //   if (diff.inMinutes > 0)
  //     return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
  //   return "Just now";
  // }

  titleWidget() {
    // var _firebaseRefget = FirebaseDatabase()
    //     .reference()
    //     .child('userStatus')
    //     .child(widget.receiver.uid);

    return StreamBuilder(
      stream: null,
      builder: (context, snap) {
        if (snap.hasData &&
            !snap.hasError &&
            snap.data.snapshot.value != null) {
          //print(data);
          return Row(
            children: <Widget>[
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Icon(
              //     Icons.fiber_manual_record,
              //     color: data['status'] == "Online" &&
              //             timeAgo(getDate(data["time"])) == "Just now"
              //         ? Colors.green
              //         : Colors.grey,
              //     size: 10,
              //   ),
              // ),
              Text(
                widget.receiverMap["displayName"],
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Nunito", fontWeight: FontWeight.w800),
              )
            ],
          );
        } else {
          return Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.fiber_manual_record,
                  color: Colors.grey,
                  size: 10,
                ),
              ),
              NunitoText(
                  text: widget.receiverMap["otherPersonId"] !=
                          widget.currentUsr.uid
                      ? widget.receiverMap["otherPerson_name"]
                      : widget.receiverMap["sender_userName"])
            ],
          );
        }
      },
    );
  }

  // ============= AppBar =================

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FirebaseFirestore.instance
    //     .collection("features")
    //     .doc(widget.currentUsr.uid)
    //     .collection("activity")
    //     .doc("myActivity")
    //     .set({"message": FieldValue.serverTimestamp()}, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    firebaseMessaging.getToken().then((value) => fcmToken = value);
    // _imageUploadProvider = Provider.of<ImageUploadProvider>(context);
    UserController user = Provider.of<UserController>(context);
    widget.currentUsr = user.getCurrentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(context),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background/illus.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              child: Flexible(
                child: messageList(),
              ),
            ),
            // _imageUploadProvider.getviewState == ViewState.LOADING
            //     ? Container(
            //         alignment: Alignment.centerRight,
            //         margin: EdgeInsets.only(right: 15),
            //         child: CircularProgressIndicator(),
            //       )
            //     : Container(),
            chatControls(),
            showEmojiPicker ? Container(child: emojiContainer()) : Container(),
          ],
        ),
      ),
    );
  }

  // ============= Complete Message Section =================

  Widget messageList() {
    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("tickets")
          .where("otherPersonId", isEqualTo: widget.receiverMap["uid"])
          .orderBy("timestamp", descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data != null) {
          print("============================ ${snapshot.data.docs.length}");
          if (snapshot.data.docs.length < 1) {
            return Center(
                child: Image.asset(
              "assets/background/messageOnboard.png",
              width: 250,
            ));
          }

          SchedulerBinding.instance.addPostFrameCallback((_) {
            _listScrollController.animateTo(
                _listScrollController.position.minScrollExtent,
                duration: Duration(milliseconds: 250),
                curve: Curves.easeOut);
          });

          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: _listScrollController,
                  reverse: true,
                  padding: EdgeInsets.all(10),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        index == snapshot.data.docs.length - 1
                            ? Image.asset(
                                "assets/background/messageOnboard.png",
                                width: w * 63.657,
                              )
                            : Container(),
                        snapshot.data.docs[index]["subject"] != null
                            ? Text("${snapshot.data.docs[index]["subject"]}")
                            : Container(),
                        snapshot.data.docs[index]["subject"] != null
                            ? SizedBox(
                                height: 20,
                              )
                            : Container(),
                        chatMessageItem(snapshot.data.docs[index]),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget chatMessageItem(DocumentSnapshot snapshot) {
    Message _message = Message.fromMap(snapshot.data());
    print(_message.description);
    print(_message.senderId);
    print(widget.currentUsr.uid);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      child: Container(
        alignment: _message.senderId == widget.currentUsr.uid
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: _message.senderId == widget.currentUsr.uid
            ? senderLayout(_message, snapshot)
            : receiverLayout(_message, snapshot),
      ),
    );
  }

  Widget senderLayout(Message message, DocumentSnapshot doc) {
    Radius messageRadius = Radius.circular(10);

    // String date;
    // if (message.timestamp != null) {
    //   DateTime now = message.timestamp.toDate();
    //   date = "${now.hour}:${now.minute}";
    // }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 12.0, right: 10),
          // child: showTime
          //     ? Text(
          //         date ?? "",
          //         style: TextStyle(color: Colors.grey, fontSize: 10),
          //       )
          //     : Container(),
        ),
        GestureDetector(
          child: Container(
            margin: EdgeInsets.only(top: 12),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.65),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff06BEB6),
                  Color(0xff48B1BF),
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: messageRadius,
                topRight: messageRadius,
                bottomLeft: messageRadius,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: getMessage(message),
            ),
          ),
          onTap: () {
            // setState(() {
            //   showTime = !showTime;
            // });
          },
        ),
      ],
    );
  }

  Widget receiverLayout(Message message, DocumentSnapshot doc) {
    Radius messageRadius = Radius.circular(10);

    // String date;
    // if (message.timestamp != null) {
    //   DateTime now = message.timestamp.toDate();
    //   date = "${now.hour}:${now.minute}";
    // }

    return Row(
      children: <Widget>[
        GestureDetector(
          child: Container(
            margin: EdgeInsets.only(top: 12),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.65),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffEB3349),
                  Color(0xffF45C43),
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomRight: messageRadius,
                topRight: messageRadius,
                bottomLeft: messageRadius,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: getMessage(message),
            ),
          ),
          onTap: () {
            // setState(() {
            //   showTime = !showTime;
            // });
          },
        ),
        AnimatedContainer(
          duration: Duration(seconds: 3),
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 10),
            // child: showTime
            //     ? Text(
            //         date ?? "",
            //         style: TextStyle(color: Colors.grey, fontSize: 10),
            //       )
            //     : Container(),
          ),
        ),
      ],
    );
  }

  getMessage(Message message) {
    return message.type != "image"
        ? Text(
            message.description,
            style: TextStyle(color: Colors.white, fontSize: 16),
          )
        : message.photoUrl != null
            ? CachedImage(url: message.photoUrl)
            : Text("Image Url has error or null");
  }

  // ============= Complete Message Section =================

  // ============= Bottom TextField Section =================

  Widget chatControls() {
    setWritingTo(bool val) {
      setState(() {
        isWriting = val;
      });
    }

    pickImage({@required ImageSource source}) async {
      var getImage = await img.getImage(
          source: ImageSource.camera, maxHeight: 675, maxWidth: 960);
      File file = File(getImage.path);
      setState(() {
        this.file = file;
      });
      // UserController().uploadImage(
      //     image: file,
      //     receiver: widget.receiver,
      //     sender: widget.currentUsr,
      //     imageUploadProvider: _imageUploadProvider);
    }

    return widget.status == null
        ? Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextField(
                      keyboardType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.sentences,
                      controller: textFieldController,
                      focusNode: textFieldFocusNode,
                      maxLines: 3,
                      minLines: 1,
                      onTap: () => hideEmojiContainer(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      onChanged: (val) {
                        (val.length > 0 && val.trim() != "")
                            ? setWritingTo(true)
                            : setWritingTo(false);
                      },
                      decoration: InputDecoration(
                        hintText: "Type a message",
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(50.0),
                            ),
                            borderSide: BorderSide.none),
                        contentPadding: EdgeInsets.only(
                            left: 15, top: 5, bottom: 5, right: 40),
                        filled: true,
                        fillColor: Colors.blueGrey,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          if (!showEmojiPicker) {
                            // keyboard is visible
                            hideKeyboard();
                            showEmojiContainer();
                          } else {
                            //keyboard is hidden
                            showKeyboard();
                            hideEmojiContainer();
                          }
                        },
                        icon: Icon(
                          Icons.face,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )),
                isWriting
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                          onTap: () {
                            // handleChooseFromGallery();
                          },
                          child: Image.asset(
                            "assets/chat_screen/Mic_btn.png",
                            width: 35,
                          ),
                        ),
                      ),
                isWriting
                    ? Container()
                    : GestureDetector(
                        // onTap: () => handleTakePhotoFromCamera(),
                        child: Image.asset(
                        "assets/chat_screen/Camera_btn.png",
                        width: 35,
                      )),
                isWriting
                    ? Container(
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            color: Colors.purple, shape: BoxShape.circle),
                        child: IconButton(
                          icon: Icon(
                            Icons.send,
                            size: 15,
                          ),
                          onPressed: () {
                            sendMessage();
                          },
                        ))
                    : Container()
              ],
            ),
          )
        : Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: NunitoText(
                text: "This Ticket has been closed",
              ),
            ),
          );
  }

  Future<void> addMessageToDb(Message sendMessage, Message recMessage,
      OurUser sender, String receiver) async {
    var sendMap = sendMessage.toMap();
    var recMap = recMessage.toMap();

    await FirebaseFirestore.instance.collection("tickets").add(sendMap);

    // await DBRef.child("messages/${message.senderId}/${message.receiverId}")
    //     .push()
    //     .set({
    //   "senderId": map["senderId"],
    //   "receiverId": map['receiverId'],
    //   "type": map['type'],
    //   'message': map['message'],
    //   "timestamp": Timestamp.now().toDate().toString(),
    // });

    // await DBRef.child("messages/${message.receiverId}/${message.senderId}")
    //     .push()
    //     .set({
    //   "senderId": map["senderId"],
    //   "receiverId": map['receiverId'],
    //   "type": map['type'],
    //   'message': map['message'],
    //   "timestamp": Timestamp.now().toDate().toString(),
    // });
  }

  sendMessage() {
    var text = textFieldController.text;
    Message _sendMessage = Message(
      senderId: widget.currentUsr.uid,
      receiverId: widget.receiverMap["uid"],
      type: "text",
      description: text,
      otherPersonId: widget.receiverMap["uid"],
      receiverUserName: widget.receiverMap["username"],
      sender_userName: widget.currentUsr.useranme,
      timestamp: FieldValue.serverTimestamp(),

      // receiverId: widget.receiverMap["uid"],
      // senderId: widget.currentUsr.uid,
      // description: text,
      // type: "text",
      // otherPersonId: widget.receiverMap["uid"]
    );

    Message _recMessage = Message(
        receiverId: widget.receiverMap["uid"],
        senderId: widget.currentUsr.uid,
        type: "text",
        otherPersonId: widget.currentUsr.uid);

    setState(() {
      isWriting = false;
    });

    textFieldController.clear();
    addMessageToDb(_sendMessage, _recMessage, widget.currentUsr,
        widget.receiverMap["uid"]);
    // UserDatabase().addMessageToDb(_message, widget.currentUsr, widget.receiver);
    // UserDatabase().addNotification(widget.receiver.uid, text);
  }
  // ============= Bottom TextField Section =================
}

// ============= MODAL BOTTOM SHEEEET =================

class ModalTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Function ontap;

  const ModalTile({
    @required this.title,
    @required this.subtitle,
    @required this.icon,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: CustomTile(
        onTap: ontap,
        mini: false,
        leading: Container(
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.black,
          ),
          padding: EdgeInsets.all(10),
          child: Icon(
            icon,
            color: Colors.grey,
            size: 38,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

// ============= MODAL BOTTOM SHEEEET =================
