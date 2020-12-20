import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezonset/Model/user.dart';
import "package:flutter/material.dart";
import 'package:page_transition/page_transition.dart';

class Notifications extends StatelessWidget {
  OurUser myUser;

  Notifications({this.myUser});

  List<DocumentSnapshot> notifications;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        width: w * 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 0,
              child: Padding(
                padding: EdgeInsets.only(
                    top: h * 3.733, left: w * 5.0925, right: w * 7.638),
                child: Text(
                  "Notifications",
                  textScaleFactor: 1,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w900,
                      fontSize: w * 7.638),
                ),
              ),
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  // var data = notifications[index].data;
                  // Timestamp timeStamp = data["time"];
                  // var date =
                  //     timeago.format(timeStamp.toDate()) ;
                  return Notifi(
                    text: "This is the notification $index",
                    type: "Diary",
                    time: "5 Min ago",
                    read: false,
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class Notifi extends StatelessWidget {
  final String type;
  final String text;
  final String time;
  final bool read;
  const Notifi({this.text, this.time, this.type, this.read});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;

    print(type);
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: w * 5.092, vertical: h * 2.488),
      child: Row(
        children: <Widget>[
          getIcon(type),
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 2.03),
              child: Column(
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        text,
                        textScaleFactor: 1,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontFamily: "Nunito"),
                      )),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: h * 0.622),
                      child: Text(
                        time,
                        textScaleFactor: 1,
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(color: Colors.grey, fontSize: w * 2.5462),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          !read
              ? Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.fiber_manual_record,
                    color: Colors.red,
                    size: 15,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

Widget generateIcon({List<Color> clr, String img}) {
  return Column(
    children: <Widget>[
      Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
          gradient: LinearGradient(
              colors: clr,
              begin: Alignment.bottomLeft,
              end: Alignment.topRight),
        ),
        child: Container(
          padding: EdgeInsets.all(15),
          alignment: Alignment.center,
          child: Image.asset(img),
        ),
      ),
    ],
  );
}

getIcon(String type) {
  switch (type) {
    case "Gallery":
      return generateIcon(
        clr: [Color(0xffF7DB00), Color(0xffF7A100)],
        img: "assets/dashboard/gallery.png",
      );
      break;

    case "Moods":
      return generateIcon(
        clr: [Color(0xff9A01D6), Color(0xffC701D6)],
        img: "assets/dashboard/mood.png",
      );
      break;

    case "PlaylistMusic":
      return generateIcon(
        clr: [Color(0xffE90E5A), Color(0xffE9139A)],
        img: "assets/dashboard/playlist.png",
      );
      break;

    case "PlaylistFun":
      return generateIcon(
        clr: [Color(0xffE90E5A), Color(0xffE9139A)],
        img: "assets/dashboard/playlist.png",
      );
      break;

    case "PlaylistDrama":
      return generateIcon(
        clr: [Color(0xffE90E5A), Color(0xffE9139A)],
        img: "assets/dashboard/playlist.png",
      );
      break;

    case "PlaylistInfo":
      return generateIcon(
        clr: [Color(0xffE90E5A), Color(0xffE9139A)],
        img: "assets/dashboard/playlist.png",
      );
      break;

    case "PlaylistLife":
      return generateIcon(
        clr: [Color(0xffE90E5A), Color(0xffE9139A)],
        img: "assets/dashboard/playlist.png",
      );
      break;

    case "PlaylistMovies":
      return generateIcon(
        clr: [Color(0xffE90E5A), Color(0xffE9139A)],
        img: "assets/dashboard/playlist.png",
      );
      break;

    case "Diary":
      return generateIcon(
        clr: [Color(0xffD32760), Color(0xffED606D)],
        img: "assets/images/events.png",
      );
      break;

    case "TodoForMe":
      return generateIcon(
        clr: [Color(0xffFFAB30), Color(0xffFF7139)],
        img: "assets/dashboard/memo.png",
      );
      break;

    case "TodoList":
      return generateIcon(
        clr: [Color(0xffFFAB30), Color(0xffFF7139)],
        img: "assets/dashboard/memo.png",
      );
      break;

    case "Events":
      return generateIcon(
        clr: [Color(0xff00DEA5), Color(0xff00AA85)],
        img: "assets/dashboard/events.png",
      );
      break;

    case "Horoscope":
      return generateIcon(
        clr: [Color(0xffC757EF), Color(0xff9513EA)],
        img: "assets/dashboard/horoscope.png",
      );
      break;

    case "Emergency":
      return generateIcon(
        clr: [Color(0xffFF3131), Color(0xffFF5E20)],
        img: "assets/dashboard/sos.png",
      );
      break;

    case "Subscription":
      return generateIcon(
        clr: [Color(0xffF7DB00), Color(0xffF7A100)],
        img: "assets/dashboard/gallery.png",
      );
      break;

    case "User Status":
      return generateIcon(
        clr: [Color(0xff4FC174), Color(0xff00D7A9)],
        img: "assets/dashboard/device.png",
      );
      break;
    default:
  }
}
