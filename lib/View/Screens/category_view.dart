import 'package:ezonset/View/Screens/gig_view_main.dart';
import 'package:ezonset/View/Widgets/GigViews/gig_view_two.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class CategoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.lightBlue, Colors.blue],
                    stops: [0.0, 0.9],
                  ),
                ),
                child: Text(
                  "Logo Design",
                  textScaleFactor: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: GigViewTwo(
                      gigTitle: "This is a demo Logo Design Title $index",
                      price: "\$${index + 25}",
                      rating: "5.0",
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                          child: GigMain(
                            title: "This is a demo Logo Design Title $index",
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
