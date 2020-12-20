import 'package:ezonset/View/Screens/category_view.dart';
import 'package:ezonset/View/Widgets/GigViews/gig_view_one.dart';
import 'package:ezonset/View/Widgets/SearchBar/SearchWidget.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class BuyerMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          SearchWidget(),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              "Popular Categories",
              style: TextStyle(
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w900,
                  fontSize: 20),
            ),
          ),
          Flexible(
            flex: 0,
            child: Container(
              height: 200,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10),
                    child: GestureDetector(
                      child: GigViewOne(
                        gigTitle: "Demo Category $index",
                        image: "assets/images/gigImage.jpeg",
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeIn,
                            child: CategoryView(),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              "Popular Services",
              style: TextStyle(
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w900,
                  fontSize: 20),
            ),
          ),
          Flexible(
            flex: 0,
            child: Container(
              height: 200,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10),
                    child: GigViewOne(
                      gigTitle: "Demo Service ${index}",
                      image: "assets/images/gigImage.jpeg",
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
