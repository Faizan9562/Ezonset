import 'package:achievement_view/achievement_view.dart';
import 'package:ezonset/Model/user.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:launch_review/launch_review.dart';
import 'package:url_launcher/url_launcher.dart';

class RateUs extends StatelessWidget {
  OurUser myUser;

  RateUs({this.myUser});

  @override
  Widget build(BuildContext context) {
    final Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'support@ciayn.com',
        queryParameters: {'subject': 'Bug report by ${myUser.displayName}'});

    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(w * 12.731)),
            image: DecorationImage(
              image: AssetImage(
                "assets/images/logo.png",
              ),
            ),
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        width: w * 100,
        height: h * 100,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: h * 6.2217,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          "assets/images/rate.png",
                          fit: BoxFit.fill,
                          width: 50,
                        ),
                        Text(
                          "Rate Us",
                          textScaleFactor: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w900,
                              fontSize: w * 6.111),
                        ),
                        Image.asset(
                          "assets/images/rate.png",
                          fit: BoxFit.fill,
                          width: w * 12.731,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: w * 5.092, vertical: h * 2.488),
                child: Column(
                  children: [
                    SizedBox(
                      height: h * 2.4886,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xffFFE7E7),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: Color(0xffFF0000),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: w * 5.092, vertical: h * 2.488),
                            child: Text(
                              "We are a team of 2. We've created this app with extreme care, devotion and utmost love. But one cannot be perfect in this world. Ezonset may also be liable to errors that slipped through our eye. If you ever find one, please report it to us. We'll try to fix that for you ASAP.",
                              textScaleFactor: 1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w500,
                                  fontSize: w * 4.074),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: w * 2.5462, vertical: h * 1.244),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(w * 3.5833),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: w * 2.5462, vertical: h * 1.3),
                                child: Text(
                                  "Report a bug",
                                  style: TextStyle(
                                      fontFamily: "Nunito",
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800),
                                  textScaleFactor: 1,
                                ),
                              ),
                              onPressed: () async {
                                launch(_emailLaunchUri.toString());
                              },
                              color: Colors.pink,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: w * 5.092, vertical: h * 2.488),
                child: Column(
                  children: [
                    SizedBox(
                      height: w * 2.488,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xffD3FFD9),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Color(0xff00F388), width: 2),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: w * 5.092, vertical: h * 2.488),
                            child: Text(
                              "Your feedback means alot to us, we are trying our best to provide best user experience on Ezonset. Show us some love by rating us on playstore.",
                              textScaleFactor: 1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w500,
                                  fontSize: w * 4.074),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: w * 2.5462, vertical: h * 1.3),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(w * 3.5833),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: w * 2.5462, vertical: h * 1.3),
                                child: Text(
                                  "Feedback",
                                  style: TextStyle(
                                      fontFamily: "Nunito",
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800),
                                  textScaleFactor: 1,
                                ),
                              ),
                              onPressed: () async {
                                LaunchReview.launch(androidAppId: "com.facebook.katana");
                              },
                              color: Color(0xff00F388),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
