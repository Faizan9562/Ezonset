

import 'package:ezonset/controller/validationController/validation_item.dart';
import 'package:flutter/material.dart';

class LoginValidation with ChangeNotifier {

  ValidationItem _email = ValidationItem(value: null, error: null);
  ValidationItem _password = ValidationItem(value: null, error: null);

  ValidationItem get email => _email;
  ValidationItem get password => _password;

  bool get isValid {
    if(_email.value != null && _password.value != null && _email.value != "" && _password.value != "") {
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
      _email = ValidationItem(value: null, error: "MUST BE A VALID EMAIL");
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
      _password = ValidationItem(value: null, error: "MUST BE ATLEAST 5 CHARACTER LONG");
    }
    notifyListeners();
  }
}