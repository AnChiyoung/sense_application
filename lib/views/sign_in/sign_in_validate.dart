import 'package:flutter/material.dart';

class SigninValidate {
  Pattern? pattern;

  bool emailValidate(String value) {
    pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern.toString());
    if(!regExp.hasMatch(value)){
      return false;
    } else {
      return true;
    }
  }

  bool passwordValidate(String value) {
    // pattern = r"^(?=.*?[a-z])(?=.*?[0-9]){6,16}$";
    pattern = r"";
    RegExp regExp = RegExp(pattern.toString());
    if(!regExp.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }
}