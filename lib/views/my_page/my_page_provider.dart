import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as Io;

class MyPageProvider with ChangeNotifier {

  XFile? _selectImage;
  XFile? get selectImage => _selectImage;
  /// base64string
  String _updateImageString = '';
  String get updateImageString => _updateImageString;

  String _name = '';
  String get name => _name;

  String _phone = '';
  String get phone => _phone;

  String _birthday = '';
  String get birthday => _birthday;

  String _email = '';
  String get email => _email;

  /// 내 정보 수정 - 성별
  List<bool> _updateGenderState = [false, false];
  List<bool> get updateGenderState => _updateGenderState;

  void xfileStateChange(XFile? state) async {
    _selectImage = state;

    final bytes = await Io.File(state!.path).readAsBytes();
    String convertString = base64Encode(bytes);

    _updateImageString = convertString;
    notifyListeners();
  }

  void nameStateChange(String name) {
    _name = name;
    // notifyListeners();
  }

  void phoneStateChange(String phone) {
    _phone = phone;
    notifyListeners();
  }

  void birthdayStateChange(String birthday) {
    _birthday = birthday;
    notifyListeners();
  }

  void emailStateChange(String email) {
    _email = email;
    notifyListeners();
  }

  void genderStateChange(List<bool> state) {
    _updateGenderState = state;
    notifyListeners();
  }
}