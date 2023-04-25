import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  bool _autoLoginState = false;
  bool get autoLoginState => _autoLoginState;

  void autoLoginBoxState(bool state) {
    _autoLoginState = state;
    notifyListeners();
  }
}