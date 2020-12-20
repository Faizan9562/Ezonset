import 'package:ezonset/Controller/validationController/register_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TF1 extends StatelessWidget {
  final String hintTitle;
  final String title;
  final TextEditingController controller;
  final String Function(String) onChange;
  final bool obs;

  TF1({this.title, this.controller, this.hintTitle, this.onChange, this.obs});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obs ?? false,
        inputFormatters: [
          LengthLimitingTextInputFormatter(70),
        ],
        controller: controller,
        decoration: new InputDecoration(
          hintText: hintTitle,
          labelText: title,
          labelStyle: TextStyle(color: Colors.black, fontFamily: "Nunito"),
          fillColor: Colors.black,
          enabledBorder: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(50),
            borderSide: new BorderSide(
              color: Colors.black,
            ),
          ),
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(50),
            borderSide: new BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(50),
            borderSide: new BorderSide(
              color: Colors.deepOrange,
            ),
          ),
          // fillColor: Colors.green
        ),
        keyboardType: TextInputType.text,
        minLines: 1,
        maxLines: 1,
        onChanged: (text) {
          onChange(text);
        });
  }
}
