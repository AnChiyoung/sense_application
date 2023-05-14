import 'package:flutter/cupertino.dart';
import 'package:sense_flutter_application/models/sign_in/kakao_user_info_model.dart';

class SigninProvider with ChangeNotifier {
  List<bool> _checkState = [false, false, false, false];
  List<bool> get checkState => _checkState;

  bool _signinButtonState = false;
  bool get signinButtonState => _signinButtonState;

  void policyCheckStateChange(List<bool> state) {
    _checkState = state;
    (state[0] == true && state[1] == true) ? _signinButtonState = true : _signinButtonState = false;
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

  bool _nameValidateState = false;
  bool get nameValidateState => _nameValidateState;

  void nameValidateStateChange(bool state) {
    _nameValidateState = state;
    notifyListeners();
  }

  List<bool> _stepChange = [true, false, false, false];
  List<bool> get stepChange => _stepChange;

  void stepChangeState(List<bool> state) {
    _stepChange = state;
    notifyListeners();
  }

  List<bool> _genderChange = [false, false];
  List<bool> get genderChange => _genderChange;

  void genderChangeState(List<bool> state) {
    _genderChange = state;
    notifyListeners();
  }

  bool _basicInfoButtonState = false;
  bool get basicInfoButtonState => _basicInfoButtonState;
  String _phoneNumber = '';
  String get phoneNumber => _phoneNumber;

  void basicInfoButtonStateChange(bool state, String phoneNumber) {
    _basicInfoButtonState = state;
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  bool _timerState = false;
  bool get timerState => _timerState;

  void timerStateChange(bool state) {
    _timerState = state;
    notifyListeners();
  }

  /// 미사용 방식, 추후 기회가 된다면 fit to model about provider 방식으로 구현해볼 것
  // KakaoUserModel? _kakaoUserModel;
  // KakaoUserModel? get kakaoUserModel => _kakaoUserModel;
  //
  // void kakaoUserPreset(KakaoUserModel model) {
  //   _kakaoUserModel = model;
  //   notifyListeners();
  // }

  bool _timeValidate = false;
  bool get timeValidate => _timeValidate;

  void timeValidateChange(bool state) {
    _timeValidate = state;
    notifyListeners();
  }

  bool _authValidate = false;
  bool get authValidate => _authValidate;

  void authValidateChange(bool state) {
    _authValidate = state;
    notifyListeners();
  }

  // bool _resendButton = false;
  // bool get resendButton => _resendButton;
  //
  // void resendButtonState(bool state) {
  //   _resendButton = state;
  //   notifyListeners();
  // }
}