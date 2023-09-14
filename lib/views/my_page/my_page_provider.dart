import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as Io;

import 'package:sense_flutter_application/models/login/login_model.dart';

class MyPageProvider with ChangeNotifier {

  XFile? _selectImage;
  XFile? get selectImage => _selectImage;
  /// base64string
  String _updateImageString = '';
  String get updateImageString => _updateImageString;

  String _name = '';
  String get name => _name;

  String _loadName = '';
  String get loadName => _loadName;

  String _phone = '';
  String get phone => _phone;

  String _birthday = '';
  String get birthday => _birthday;

  String _loadBirthday = '';
  String get loadBirthday => _loadBirthday;

  String _email = '';
  String get email => _email;

  /// 내 정보 수정 - 성별
  List<bool> _updateGenderState = [false, false];
  List<bool> get updateGenderState => _updateGenderState;

  bool _agree = false;
  bool get agree => _agree;

  bool _pushAlarm = false;
  bool get pushAlarm => _pushAlarm;

  bool _marketingAlarm = false;
  bool get marketingAlarm => _marketingAlarm;

  int _genderState = -1;
  int get genderState => _genderState;

  int _relationState = -1;
  int get relationState => _relationState;

  int _mbti = -1;
  int get mbti => _mbti;

  int _saveMbti = -1;
  int get saveMbti => _saveMbti;

  int _ownCar = -1;
  int get ownCar => _ownCar;

  /// 처음 불러온 정보 저장용, 저장 버튼 업데이트용
  int _loadGender = -1;
  int get loadGender => _loadGender;

  int _loadRelation = -1;
  int get loadRelation => _loadRelation;

  int _loadMbti = -1;
  int get loadMbti => _loadMbti;

  int _loadOwnCar = -1;
  int get loadOwnCar => _loadOwnCar;

  bool _basicButton = false;
  bool get basicButton => _basicButton;

  bool _moreButton = false;
  bool get moreButton => _moreButton;

  String _myPageName = '';
  String get myPageName => _myPageName;

  int _loadYear = 0;
  int get loadYear => _loadYear;

  int _loadMonth = 0;
  int get loadMonth => _loadMonth;

  int _loadDay = 0;
  int get loadDay => _loadDay;

  int _year = 0;
  int get year => _year;

  int _month = 0;
  int get month => _month;

  int _day = 0;
  int get day => _day;

  void myPageNameInit(String state) {
    _myPageName = state;
  }

  void myPageNameChange() {
    _myPageName = _name;
    PresentUserInfo.username = _name;
    notifyListeners();
  }

  void genderInit(int state) {
    _genderState = state;
    _loadGender = state;
  }

  void genderStateChange(int state) {
    _genderState = state;
    doesActiveButton() == true ? _moreButton = true : _moreButton = false;
    notifyListeners();
  }

  void relationInit(int state) {
    _relationState = state;
    _loadRelation = state;
  }

  void relationStateChange(int state) {
    _relationState = state;
    doesActiveButton() == true ? _moreButton = true : _moreButton = false;
    notifyListeners();
  }

  void mbtiInit(int state) {
    _mbti = state;
    _saveMbti = state;
    _loadMbti = state;
  }

  void mbtiChange(int state) {
    _mbti = state;
    doesActiveButton() == true ? _moreButton = true : _moreButton = false;
    notifyListeners();
  }

  void saveMbtiChange() {
    _saveMbti = _mbti;
    doesActiveButton() == true ? _moreButton = true : _moreButton = false;
    notifyListeners();
  }

  void ownCarInit(int state) {
    _ownCar = state;
    _loadOwnCar = state;
  }

  void ownCarChange(int state) {
    _ownCar = state;
    doesActiveButton() == true ? _moreButton = true : _moreButton = false;
    notifyListeners();
  }

  void moreButtonChange(bool state) {
    _moreButton = state;
    notifyListeners();
  }

  /// button active logic
  bool doesActiveButton() {
    return (_loadGender != _genderState) || (_loadRelation != _relationState) || (_loadMbti != _saveMbti) || (_loadOwnCar != _ownCar);
  }

  void pushAlarmChange(bool state) {
    _pushAlarm = state;
    notifyListeners();
  }

  void marketingAlarmChange(bool state) {
    _marketingAlarm = state;
    notifyListeners();
  }

  void xfileStateChange(XFile? state) async {
    _selectImage = state;

    final bytes = await Io.File(state!.path).readAsBytes();
    String convertString = base64Encode(bytes);

    _updateImageString = convertString;

    if(doesActiveBasicButton() == true) {
      _basicButton = true;
    } else {
      _basicButton = false;
    }
    notifyListeners();
  }

  void nameInit(String name) {
    _loadName = name;
    _name = name;
  }

  void nameStateChange(String name) {
    print(_loadName);
    print(_name);
    _name = name;
    if(doesActiveBasicButton() == true) {
      _basicButton = true;
      notifyListeners();
    } else {
      _basicButton = false;
      notifyListeners();
    }
  }

  void phoneStateChange(String phone) {
    _phone = phone;
    notifyListeners();
  }

  void birthdayInit(String birthday) {
    _loadBirthday = birthday;
    _birthday = birthday;
    List<String> result = birthday!.split('-');
    _year = int.parse(result.elementAt(0));
    _month = int.parse(result.elementAt(1));
    _day = int.parse(result.elementAt(2));
  }

  void birthdayStateChange(String birthday) {
    _birthday = birthday;
    _loadBirthday = birthday;
    if(doesActiveBasicButton() == true) {
      _basicButton = true;
      notifyListeners();
    } else {
      _basicButton = false;
      notifyListeners();
    }
  }

  void emailStateChange(String email) {
    _email = email;
    notifyListeners();
  }

  // void genderStateChange(List<bool> state) {
  //   _updateGenderState = state;
  //   notifyListeners();
  // }

  void withdrawalAgreeChange(bool state) {
    _agree = state;
    notifyListeners();
  }

  void basicButtonChange(bool state) {
    _basicButton = state;
    notifyListeners();
  }

  bool doesActiveBasicButton() {
    return (_selectImage != null) || (_loadName != _name) || (_loadBirthday != _birthday);
  }

  void updateInfoInit() {
    _updateImageString = '';
    _selectImage = null;
    _name = '';
    _phone = '';
    _birthday = '';
    _basicButton = false;
    _genderState = -1;
    _relationState = -1;
    _mbti = -1;
    _ownCar = -1;
    _moreButton = false;
  }
}