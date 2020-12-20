import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0, left: 20, right: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 2,
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search Services",
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                  contentPadding: EdgeInsets.only(
                    left: 20,
                    bottom: 20,
                    top: 20,
                    right: 20,
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                onSubmitted: (text) {},
                onChanged: (val) {},
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                },
                icon: Icon(Icons.search, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}