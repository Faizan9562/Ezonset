import 'package:flutter/material.dart';

class GigViewTwo extends StatelessWidget {
  final String image;
  final String gigTitle;
  final String price;
  final String rating;
  final String index;
  const GigViewTwo({this.gigTitle, this.image, this.price, this.rating, this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 20.0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                Container(
                  child: Image.asset(
                    "assets/images/gigImage.jpeg",
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      Text(
                        "$rating",
                        style: TextStyle(
                            color: Colors.orange,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$gigTitle",
                        style: TextStyle(
                            fontFamily: "Nunito", fontWeight: FontWeight.w900),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "$price",
                        style: TextStyle(
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w900,
                            color: Colors.green),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
