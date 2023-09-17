import 'package:flutter/cupertino.dart';

class AnimationProvider with ChangeNotifier {
  bool _homeAddButton = false;
  bool get homeAddButton => _homeAddButton;

  void homeAddButtonState(bool state) {
    _homeAddButton = state;
    notifyListeners();
  }
}