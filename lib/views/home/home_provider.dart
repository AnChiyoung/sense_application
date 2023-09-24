import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {

  int _selectHomeIndex = 0;
  int get selectHomeIndex => _selectHomeIndex;

  void selectHomeIndexChange(int state, bool notify) {
    _selectHomeIndex = state;
    if(notify == true) {
      notifyListeners();
    }
  }
}