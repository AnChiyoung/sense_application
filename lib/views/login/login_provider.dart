import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  bool _autoLoginState = false;
  bool get autoLoginState => _autoLoginState;

  void autoLoginBoxState(bool state, bool notify) {
    _autoLoginState = state;
    if (notify) notifyListeners();
  }

  bool _passwordSearchButtonState = false;
  bool get passwordSearchButtonState => _passwordSearchButtonState;
  String _authPhoneNumber = '';
  String get authPhoneNumber => _authPhoneNumber;

  void passwordSearchButtonStateChange(bool state, [String? phoneNumber]) {
    _passwordSearchButtonState = state;
    phoneNumber == null ? {} : _authPhoneNumber = phoneNumber;
    notifyListeners();
  }
}
