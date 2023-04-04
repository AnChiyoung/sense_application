import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecommendedEventProvider with ChangeNotifier {
  bool _buttonState = false;
  bool get buttonState => _buttonState;

  bool _priceNextButton = false;
  bool get priceNextButton => _priceNextButton;

  bool _regionNextButton = false;
  bool get regionNextButton => _regionNextButton;

  int _regionSelectState = -1;
  int get regionSelectState => _regionSelectState;

  List<bool> _subRegionList = [];
  List<bool> get subRegionList => _subRegionList;

  void nextButtonState(bool state) {
    _buttonState = state;
    notifyListeners();
  }

  void nextButtonReset() {
    _buttonState = false;
    notifyListeners();
  }

  void priceNextButtonState(bool state) {
    _priceNextButton = state;
    notifyListeners();
  }

  void priceNextButtonReset() {
    _priceNextButton = false;
    notifyListeners();
  }

  void regionNextButtonState(bool state) {
    _regionNextButton = state;
    notifyListeners();
  }

  void regionNextButtonReset() {
    _regionNextButton = false;
    notifyListeners();
  }

  void regionSelectStateChange(int state) {
    _regionSelectState = state;
    notifyListeners();
  }

  void regionSelectStateReset() {
    _regionSelectState = -1;
    notifyListeners();
  }

  void subRegionBoolListReset() {
    _subRegionList.clear();
    notifyListeners();
  }
}