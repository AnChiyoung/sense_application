import 'package:flutter/cupertino.dart';

class SigninProvider with ChangeNotifier {
  List<bool> _checkState = [false, false, false, false];
  List<bool> get checkState => _checkState;

  bool _signinButtonState = false;
  bool get signinButtonState => _signinButtonState;

  void policyCheckStateChange(List<bool> state) {
    _checkState = state;
    (state[0] == true && state[1] == true) ? _signinButtonState = true : _signinButtonState = false;
    // int checkCount = 0;
    // for(bool value in state) {
    //   value == true ? checkCount++ : {};
    // }
    // checkCount >= 2 ? _signinButtonState = true : _signinButtonState = false;
    notifyListeners();
  }

  bool _emailValidateState = false;
  bool get emailValidateState => _emailValidateState;

  void emailValidateStateChange(bool state) {
    _emailValidateState = state;
    notifyListeners();
  }

  bool _passwordValidateState = false;
  bool get passwordValidateState => _passwordValidateState;

  void passwordValidateStateChange(bool state) {
    _passwordValidateState = state;
    notifyListeners();
  }

  bool _repeatPasswordValidateState = false;
  bool get repeatPasswordValidateState => _repeatPasswordValidateState;

  void repeatPasswordValidateStateChange(bool state) {
    _repeatPasswordValidateState = state;
    notifyListeners();
  }

  bool _emailPasswordButtonState = false;
  bool get emailPasswordButtonState => _emailPasswordButtonState;

  void emailPasswordButtonStateChange(bool state) {
    _emailPasswordButtonState = state;
    notifyListeners();
  }
}