import 'package:flutter/material.dart';

class HomeMenuProvider with ChangeNotifier {

  String _changeState = '';
  String get changeState => _changeState;

  void changeValue(String value) {
    _changeState = value;
    notifyListeners();
  }
}