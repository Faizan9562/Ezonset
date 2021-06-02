import 'package:achievement_view/achievement_view.dart';
import 'package:crisislink/Model/user.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  OurUser myUser;

  ContactUs({this.myUser});

  @override
  Widget build(BuildContext context) {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@ezonset.com',
    );

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
                        "Contact Us",
                        textScaleFactor: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w900,
                            fontSize: w * 6.111),
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
                          horizontal: w * 17.638, vertical: h * 3.733),
                      child: Image.asset(
                        "assets/images/contact.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: w * 5.092, vertical: h * 2.488),
                      child: Text(
                        "Feel free to contact us if you have any queries regarding your security, your account or our features.",
                        textScaleFactor: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w500,
                            fontSize: w * 4.074),
                      ),
                      // child: RichText(
                      //   textScaleFactor: 1,
                      //   textAlign: TextAlign.center,
                      //   text: new TextSpan(
                      //     style: new TextStyle(
                      //         fontFamily: "Nunito",
                      //         fontWeight: FontWeight.w500,
                      //         fontSize: 16, color: Colors.black),
                      //     children: <TextSpan>[
                      //       new TextSpan(
                      //         text:
                      //             'Tell others to join our app and be a part of\n',
                      //         style: TextStyle(
                      //           fontFamily: "Nunito",
                      //           fontWeight: FontWeight.w500,
                      //         ),
                      //       ),
                      //       new TextSpan(
                      //         text: 'The Ciayn fam ',
                      //         style: TextStyle(
                      //             fontFamily: "Nunito",
                      //             fontWeight: FontWeight.w900,
                      //             color: Color(0xff00D7CC)),
                      //       ),
                      //       new TextSpan(
                      //         text:
                      //             'where we connect the ones who care for eachother',
                      //         style: TextStyle(
                      //           fontFamily: "Nunito",
                      //           fontWeight: FontWeight.w500,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
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
                        "Contact Via Email",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        textScaleFactor: 1,
                      ),
                    ),
                    onPressed: () async {
                      launch(_emailLaunchUri.toString());
                    },
                    color: Colors.pink,
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
