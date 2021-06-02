import 'package:crisislink/View/Auth/getting_Started.dart';
import 'package:crisislink/View/Auth/register.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:page_transition/page_transition.dart';
import './privacy_policy.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => Register()),
    );
  }

  Widget _buildImage(String assetName) {
    final w = MediaQuery.of(context).size.width / 100;

    return Container(
      child: Align(
        child: Image.asset('assets/$assetName', width: w * 89.120),
        alignment: Alignment.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;

    print("width $w");
    print("height $h");

    var pageDecoration = PageDecoration(
      bodyFlex: 10,
      imageFlex: 12,
      descriptionPadding:
          EdgeInsets.fromLTRB(w * 7.638, 0.0, w * 7.638, h * 1.9909),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return SafeArea(
      child: IntroductionScreen(
        key: introKey,
        pages: [
          PageViewModel(
              titleWidget: Text(
                "Lets Get You Connected !",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              bodyWidget: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(w * 4.5833),
                  side: BorderSide(color: Colors.blue),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 2.5462),
                  child: Text(
                    "GETTING STARTED",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    textScaleFactor: 1,
                  ),
                ),
                onPressed: () {
                  _onIntroEnd(context);
                },
                color: Color(0xff27AADF),
              ),
              image: Padding(
                padding: EdgeInsets.only(
                    top: h * 12.4434, right: w * 13, left: w * 13),
                child: _buildImage('images/onboard1.png'),
              ),
              decoration: PageDecoration(
                bodyFlex: 10,
                imageFlex: 20,
                descriptionPadding:
                    EdgeInsets.fromLTRB(w * 7.638, 0.0, w * 7.638, h * 1.9909),
                pageColor: Colors.white,
                imagePadding: EdgeInsets.zero,
              )),
        ],
        onDone: () => _onIntroEnd(context),
        //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: true,
        skipFlex: 0,
        nextFlex: 0,
        skip: Container(
          decoration: BoxDecoration(
            color: Color(0xff8C47FB),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(w * 10.185),
                bottomRight: Radius.circular(w * 10.185),
                topLeft: Radius.circular(w * 10.185),
                bottomLeft: Radius.circular(w * 10.185)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Text(
              "Skip",
              style: TextStyle(color: Colors.white),
              textScaleFactor: 1,
            ),
          ),
        ),
        next: const Icon(Icons.arrow_forward),
        done: const Text(
          'Done',
          style: TextStyle(fontWeight: FontWeight.w600),
          textScaleFactor: 1,
        ),
        dotsDecorator: const DotsDecorator(
          size: Size(4.2, 4.2),
          color: Color(0xFFBDBDBD),
          activeSize: Size(12.0, 5.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25.0),
            ),
          ),
        ),
      ),
    );
  }
}
