import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String title;
  final Widget rightWidget;
  final Function onpressed;
  final List<Color> clrs;

   GradientButton({
    @required this.title,
    this.rightWidget,
    this.onpressed,
    this.clrs
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      padding: const EdgeInsets.all(0.0),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: clrs),
          borderRadius: BorderRadius.all(Radius.circular(80.0)),
        ),
        child: Container(
          padding: EdgeInsets.only(left: 30, right: 20),
          constraints: const BoxConstraints(
              minWidth: 88.0,
              minHeight: 60.0), // min sizes for Material buttons
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: rightWidget != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
            children: [
               Text(
                title,
                textAlign: TextAlign.center,
                textScaleFactor: 1,
                style: TextStyle(
                    fontFamily: "Nunito",
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1),
              ),
              SizedBox(width: 15,),
              rightWidget ?? Container()  
            ],
          ),
        ),
      ),
      onPressed: onpressed,
    );
  }
}
