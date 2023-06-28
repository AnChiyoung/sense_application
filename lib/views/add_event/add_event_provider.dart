import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddEventProvider with ChangeNotifier {
  bool _buttonState = false;
  bool get buttonState => _buttonState;

  bool _contactListButtonState = false;
  bool get contactListButtonState => _contactListButtonState;

  bool _allCheckState = false;
  bool get allCheckState => _allCheckState;

  String _selectedDay = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String get selectedDay => _selectedDay;

  bool _dateSelectButtonState = false;
  bool get dateSelectButtonState => _dateSelectButtonState;

  void nextButtonState(bool state) {
    _buttonState = state;
    notifyListeners();
  }

  void nextButtonReset() {
    _buttonState = false;
    notifyListeners();
  }

  void contactListNextButtonState(bool state) {
    _contactListButtonState = state;
    notifyListeners();
  }

  void contactListAllCheckState(bool state) {
    _allCheckState = state!;
    notifyListeners();
  }

  void dayViewUpdate(String date) {
    _selectedDay = date;
    notifyListeners();
  }

  void dayViewReset() {
    _selectedDay = DateFormat('yyyy-MM-dd').format(DateTime.now());
    notifyListeners();
  }

  void dateSelectNextButton(bool state) {
    _dateSelectButtonState = state;
    notifyListeners();
  }

  void dateSelectNextButtonReset() {
    _dateSelectButtonState = false;
    notifyListeners();
  }
}