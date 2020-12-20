import "package:flutter/material.dart";
import 'dart:io';
import 'package:flutter/services.dart';


class AppRetainWidget extends StatelessWidget {
  final Widget child;

  AppRetainWidget({this.child});

  final _channel = const MethodChannel('com.example/app_retain');

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Platform.isAndroid) {
          if (Navigator.of(context).canPop()) {
            print("here");
            return true;
          } else {
            print("Not Invoked i think");
            _channel.invokeMethod('sendToBackground');
            return false;
          }
        } else {
          return true;
        }
      },
      child: child,
    );
  }
}