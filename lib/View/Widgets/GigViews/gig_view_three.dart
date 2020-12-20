import 'package:flutter/material.dart';

class GigViewThree extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          ),
        ],
      ),
      height: 230,
      width: 170,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Image.asset(
              "assets/images/gigImage.jpeg",
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(top: 5),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.orangeAccent,
                      ),
                      Text(
                        "5.0",
                        style: TextStyle(
                            color: Colors.orangeAccent,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    color: Colors.white,
                    child: Text(
                      "This Is another Title for some other service",
                      textAlign: TextAlign.left,
                      textScaleFactor: 1,
                      style: TextStyle(
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerRight,
                    child: Text(
                      "\$25",
                      style: TextStyle(
                          fontFamily: "Nunito",
                          color: Colors.green,
                          fontWeight: FontWeight.w900,
                          fontSize: 18),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
