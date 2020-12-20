import 'package:achievement_view/achievement_view.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:ezonset/Model/user.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TellOthers extends StatelessWidget {
  OurUser myUser;

  TellOthers({this.myUser});

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: h * 6.2217,
              ),
              Expanded(
                flex: 0,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Tell Others",
                        textScaleFactor: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w900,
                            fontSize: w*6.111),
                      ),
                      Text(
                        "Send our link to others to invite them to Ezonset",
                        textScaleFactor: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w500,
                            fontSize: w*4.074),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: w * 7.638, vertical: h * 3.733),
                      child: Image.asset(
                        "assets/images/tellOther.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: w * 5.092, vertical: h * 2.488),
                      // child: Text(
                      //   "Tell others to join our app and be a part of The Ciayn fam, where we connect the ones who care for eachother",
                      //   textScaleFactor: 1,
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //       fontFamily: "Nunito",
                      //       fontWeight: FontWeight.w500,
                      //       fontSize: 16),
                      // ),
                      child: RichText(
                        textScaleFactor: 1,
                        textAlign: TextAlign.center,
                        text: new TextSpan(
                          style: new TextStyle(
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w500,
                              fontSize: w*4.074, color: Colors.black),
                          children: <TextSpan>[
                            new TextSpan(
                              text:
                                  'Tell others to join our app and be a part of\n',
                              style: TextStyle(
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            new TextSpan(
                              text: 'The Ezonset family ',
                              style: TextStyle(
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xff00D7CC)),
                            ),
                            new TextSpan(
                              text:
                                  'where we meet our business needs',
                              style: TextStyle(
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 0,
                child: Container(
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(w * 3.5833),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: w * 2.5462, vertical: h * 1.3),
                      child: Text(
                        "Copy Link",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        textScaleFactor: 1,
                      ),
                    ),
                    onPressed: () async {
                      await ClipboardManager.copyToClipBoard(
                          "https://play.google.com/store/apps/details?id=com.Ezonset.ciayn");
                      AchievementView(context,
                          color: Colors.green,
                          title: "Link Copied to clipboard !",
                          elevation: 50,
                          duration: Duration(seconds: 4),
                          icon: Icon(
                            FontAwesomeIcons.checkCircle,
                            color: Colors.white,
                          ),
                          subTitle:
                              "Send the copied link to your friend. Once they register, send the request and ask to accept your request.",
                          isCircle: true, listener: (status) {
                        print(status);
                      })
                        ..show();
                    },
                    color: Color(0xff0071BC),
                  ),
                ),
              ),
              SizedBox(
                height: h * 6.2217,
              )
            ],
          ),
        ),
      ),
    );
  }
}
