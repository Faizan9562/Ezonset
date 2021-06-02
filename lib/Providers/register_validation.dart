import 'package:flutter/material.dart';
import './validation_item.dart';

class RegisterValidation with ChangeNotifier {
  ValidationItem _email = ValidationItem(value: null, error: null);
  ValidationItem _password = ValidationItem(value: null, error: null);
  ValidationItem _confirmPass = ValidationItem(value: null, error: null);

  ValidationItem get email => _email;
  ValidationItem get password => _password;
  ValidationItem get confirmPass => _confirmPass;

  bool get isValid {
    if(_email.value != null && _password.value != null && _confirmPass.value != null && _email.value != "" && _password.value != "" && _confirmPass.value != "") {
       return true;
    } else {
      return false;
    }
  }

  void changeEmail(String value){
    if (value.contains("@")) {
      _email = ValidationItem(value: value, error: null);
    }
    else if (value == "") {
      _email = ValidationItem(value: value, error: null);
    }
    else {
      _email = ValidationItem(value: null, error: "Register using a valid email. Not using a valid email may limit your user experience !");
    }
    notifyListeners();
  }

  void changePassword(String value){
    if (value.length >= 6) {
      _password = ValidationItem(value: value, error: null);
    } else if (value == "") {
      _password = ValidationItem(value: value, error: null);
    }
    else {
      _password = ValidationItem(value: null, error: "The password must be atleast 6 characters long.");
    }
    notifyListeners();
  }


  void changeConfirmPass(String value){
    if (value == _password.value) {
      _confirmPass = ValidationItem(value: value, error: null);
    } else if (value == "") {
      _confirmPass = ValidationItem(value: value, error: null);
    }
    else {
      _confirmPass = ValidationItem(value: null, error: "The Passwords do not match.");
    }
    print("Password: ${_password.value} \n Confirm Password: ${_confirmPass.value}");
    notifyListeners();
  }




}