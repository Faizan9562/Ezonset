import 'package:flutter/material.dart';

class GigViewOne extends StatelessWidget {
  final String image;
  final String gigTitle;
  const GigViewOne({this.gigTitle, this.image});

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
      height: 170,
      width: 170,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Image.asset(
              image,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              width: double.infinity,
              color: Colors.white,
              child: Text(
                gigTitle,
                textAlign: TextAlign.left,
                textScaleFactor: 1,
                style: TextStyle(
                    fontFamily: "Nunito", fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
