import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:crisislink/Controller/user_controller.dart';
import 'package:crisislink/Model/user.dart';
import 'package:crisislink/View/About/contact_us.dart';
import 'package:crisislink/View/About/rate_us.dart';
import 'package:crisislink/View/About/tell_others.dart';
import 'package:crisislink/View/Auth/login.dart';
import 'package:crisislink/View/Homepage/homepage_admin.dart';
import 'package:crisislink/View/User%20View/StempDashboard/homepage_stemp.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:getwidget/components/drawer/gf_drawer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class StempDashboard extends StatefulWidget {
  OurUser myUser;

  StempDashboard({this.myUser});

  @override
  _StempDashboardState createState() => _StempDashboardState();
}

class _StempDashboardState extends State<StempDashboard>
    with TickerProviderStateMixin {
  GlobalKey _bottomNavigationKey = GlobalKey();

//====================Class Variables==================
  int _page = 1;
  int _pageView = 1;
  OurUser currentUser;
//#####################################################

//====================View Pages========================

  @override
  void initState() {
    super.initState();
  }
//#################################################

  @override
  Widget build(BuildContext context) {
//===================Local Variables=======================
    UserController _curruser = Provider.of<UserController>(context);
    AnimationController _animationController;
    Animation<double> animation;
    var _pageController = PageController(initialPage: 1);
    setState(() {
      currentUser = _curruser.getCurrentUser;
    });
//#########################################################

//==================LOCAL WIDGET LISTS======================

    final iconList = <IconData>[
      FontAwesomeIcons.listAlt,
      FontAwesomeIcons.mailBulk,
      FontAwesomeIcons.search,
    ];

    final _pages = [
      null,
      StempHomepage(),
      null,
    ];

//###########################################################

    Widget pageViewSection() {
      return PageView(
        children: _pages,
        onPageChanged: (index) {
          setState(
            () {
              print("PageView index = $index");
              _page = index;
            },
          );
        },
        controller: _pageController,
      );
    }

    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;

//====================SCAFFOLD================================
    return Scaffold(
        backgroundColor: Colors.white,
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
        drawer: GFDrawer(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 0,
                child: GestureDetector(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: h * 2.48,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: w * 5.092,
                                    vertical: h * 2.4886),
                                child: CircularProfileAvatar(
                                  currentUser.avatarUrl ?? "",
                                  radius: w * 8.462,
                                  backgroundColor: Colors.transparent,
                                  borderWidth: 1,
                                  borderColor: Colors.deepPurpleAccent,
                                  elevation: 20.0,
                                  errorWidget: (context, url, error) {
                                    return Icon(
                                      Icons.face,
                                      size: w * 25.462,
                                    );
                                  },
                                  cacheImage: true,
                                  onTap: () {
                                    _pageController.animateToPage(0,
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.linear);
                                    Navigator.pop(context);
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
                          ),
                          Flexible(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    currentUser.displayName ?? "Faizan",
                                    textScaleFactor: 1,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.w900,
                                        fontSize: w * 4.5833,
                                        letterSpacing: 1),
                                  ),
                                  Text(
                                    currentUser.email ?? "Hyrax9562@yahoo.com",
                                    textScaleFactor: 1,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.w500,
                                        fontSize: w * 3.0555,
                                        color: Color(0xff00D7CC),
                                        letterSpacing: 0.5),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    _pageController.animateToPage(0,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.linear);
                    Navigator.pop(context);
                  },
                ),
              ),
              Expanded(
                flex: 0,
                child: Divider(),
              ),
              Column(
                children: <Widget>[
                  // GestureDetector(
                  //   child: ListTile(
                  //     contentPadding: EdgeInsets.only(
                  //         right: w * 12.7314,
                  //         top: h * 1.2443,
                  //         left: w * 5.0925),
                  //     title: Container(
                  //       alignment: Alignment.center,
                  //       height: h * 6.2217,
                  //       child: Row(
                  //         children: <Widget>[
                  //           Padding(
                  //             padding: EdgeInsets.symmetric(
                  //                 horizontal: w * 2.037, vertical: h * 0.9954),
                  //             child: Icon(
                  //               FontAwesomeIcons.solidCreditCard,
                  //               color: Colors.deepOrange,
                  //             ),
                  //           ),
                  //           Padding(
                  //             padding: EdgeInsets.symmetric(
                  //                 horizontal: w * 2.037, vertical: h * 0.9954),
                  //             child: Text(
                  //               "Subscription",
                  //               textScaleFactor: 1,
                  //               textAlign: TextAlign.left,
                  //               style: TextStyle(
                  //                 fontFamily: "Nunito",
                  //                 fontWeight: FontWeight.w700,
                  //                 fontSize: w * 3.819,
                  //                 letterSpacing: 1,
                  //                 color: Color(0xff2a3d66),
                  //               ),
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       PageTransition(
                  //         type: PageTransitionType.rightToLeft,
                  //         duration: Duration(milliseconds: 200),
                  //         curve: Curves.easeIn,
                  //         child: null,
                  //       ),
                  //     );
                  //   },
                  // ),
                  GestureDetector(
                    child: ListTile(
                      contentPadding: EdgeInsets.only(
                          right: w * 12.7314,
                          top: h * 1.2443,
                          left: w * 5.0925),
                      title: Container(
                        alignment: Alignment.center,
                        height: h * 6.2217,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: w * 2.037, vertical: h * 0.9954),
                              child: Icon(
                                Icons.settings,
                                color: Colors.deepOrange,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: w * 2.037, vertical: h * 0.9954),
                              child: Text(
                                "Settings",
                                textScaleFactor: 1,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.w700,
                                    fontSize: w * 3.819,
                                    letterSpacing: 1,
                                    color: Color(0xff2a3d66)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   PageTransition(
                      //     type: PageTransitionType.rightToLeft,
                      //     duration: Duration(milliseconds: 200),
                      //     curve: Curves.easeIn,
                      //     child: Settings(
                      //       myUser: currentUser,
                      //     ),
                      //   ),
                      // );
                    },
                  ),
                  GestureDetector(
                    child: ListTile(
                      contentPadding: EdgeInsets.only(
                          right: w * 12.7314,
                          top: h * 1.2443,
                          left: w * 5.0925),
                      title: Container(
                        alignment: Alignment.center,
                        height: h * 6.2217,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: w * 2.037, vertical: h * 0.9954),
                              child: Icon(
                                FontAwesomeIcons.starHalfAlt,
                                color: Colors.deepOrange,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: w * 2.037, vertical: h * 0.9954),
                              child: Text(
                                "Rate us",
                                textScaleFactor: 1,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w700,
                                  fontSize: w * 3.819,
                                  letterSpacing: 1,
                                  color: Color(0xff132743),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                          child: RateUs(myUser: currentUser),
                        ),
                      );
                    },
                  ),
                  GestureDetector(
                    child: ListTile(
                      contentPadding: EdgeInsets.only(
                          right: w * 12.7314,
                          top: h * 1.2443,
                          left: w * 5.0925),
                      title: Container(
                        alignment: Alignment.center,
                        height: h * 6.2217,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: w * 2.037, vertical: h * 0.9954),
                              child: Icon(
                                FontAwesomeIcons.share,
                                color: Colors.deepOrange,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: w * 2.037, vertical: h * 0.9954),
                              child: Text(
                                "Tell others",
                                textScaleFactor: 1,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w700,
                                  fontSize: w * 3.819,
                                  letterSpacing: 1,
                                  color: Color(0xff2a3d66),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                          child: TellOthers(
                            myUser: currentUser,
                          ),
                        ),
                      );
                    },
                  ),
                  GestureDetector(
                    child: ListTile(
                      contentPadding: EdgeInsets.only(
                          right: w * 12.7314,
                          top: h * 1.2443,
                          left: w * 5.0925),
                      title: Container(
                        alignment: Alignment.center,
                        height: h * 6.2217,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: w * 2.037, vertical: h * 0.9954),
                              child: Icon(
                                FontAwesomeIcons.shareAlt,
                                color: Colors.deepOrange,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: w * 2.037, vertical: h * 0.9954),
                              child: Text(
                                "Contact us",
                                textScaleFactor: 1,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: "Nunito",
                                  fontWeight: FontWeight.w700,
                                  fontSize: w * 3.819,
                                  letterSpacing: 1,
                                  color: Color(0xff2a3d66),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                          child: ContactUs(
                            myUser: currentUser,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Divider(),
                      GestureDetector(
                        child: ListTile(
                          contentPadding: EdgeInsets.only(
                              right: w * 12.7314,
                              top: h * 1.2443,
                              left: w * 5.0925),
                          title: Container(
                            alignment: Alignment.center,
                            height: h * 6.2217,
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: w * 2.037,
                                      vertical: h * 0.9954),
                                  child: Icon(
                                    FontAwesomeIcons.signOutAlt,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: w * 2.037,
                                      vertical: h * 0.9954),
                                  child: Text(
                                    "Sign Out",
                                    textScaleFactor: 1,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      letterSpacing: 1,
                                      color: Color(0xff2a3d66),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        onTap: () async {
                          String userId = _curruser.getCurrentUser.uid;

                          bool _returnString = await _curruser.signOut();
                          if (_returnString == "Success") {
                            // FirebaseDatabase()
                            //     .reference()
                            //     .child('userStatus')
                            //     .child(userId)
                            //     .update({
                            //   "status": "offline",
                            //   "Uid": userId,
                            // });

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                                (route) => false);
                          } else {
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Error Signing Out !"),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // endDrawer: ChatScreen(
        //   currentUsr: currentUser,
        //   receiver: userFriend,
        // ),
        bottomNavigationBar: AnimatedBottomNavigationBar(
            splashColor: Colors.deepOrangeAccent,
            activeColor: Colors.deepOrangeAccent,
            icons: iconList,
            activeIndex: _page,
            inactiveColor: Colors.black,
            notchAndCornersAnimation: animation,
            splashSpeedInMilliseconds: 300,
            notchSmoothness: NotchSmoothness.softEdge,
            gapLocation: GapLocation.none,
            leftCornerRadius: 32,
            rightCornerRadius: 32,
            onTap: (index) {
              setState(() {
                _pageView = index;
                _pageController.animateToPage(index,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.linear);
              });
            }),
        body: Container(
          child: pageViewSection(),
        ));
  }
}

//###############################################################
