import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  final String hint;
  String label;
  Color focusedColor;
  Color disabledColor;
  Color enabledColor;
  Color iconColor;
  TextEditingController controller;
  TextInputType type;
  bool obsecureText;
  Icon icon;
  Function onEditingComplete;
  String Function(String) onChange;

  RoundedTextField(
      {this.controller,
      this.disabledColor,
      this.enabledColor,
      this.focusedColor,
      this.hint,
      this.icon,
      this.iconColor,
      this.label,
      this.obsecureText,
      this.onChange,
      this.onEditingComplete,
      this.type});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (text) {
        onChange(text);
      },
      controller: controller,
      keyboardType: type ?? TextInputType.text,
      obscureText: obsecureText ?? false,
      decoration: new InputDecoration(
          prefixIcon: icon ??
              Icon(
                Icons.lock,
                color: iconColor ?? Colors.cyan,
              ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: focusedColor ?? Color(0xff20B5D9), width: 2.0),
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 2.0),
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          hintText: hint ?? 'Your Value',
          labelText: label ?? "Value",
          labelStyle: TextStyle(
            fontFamily: "Nunito",
          ),
          hintStyle: TextStyle(fontFamily: "Nunito")),
    );
  }
}
