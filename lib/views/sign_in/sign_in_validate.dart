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
    pattern = r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d\w\W]{6,16}$";
    RegExp regExp = RegExp(pattern.toString());
    if(!regExp.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  bool nameValidate(String value) {
    pattern = r"^[가-힣]{2,7}$";
    RegExp regExp = RegExp(pattern.toString());
    if(!regExp.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }
}