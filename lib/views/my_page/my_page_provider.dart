import 'package:flutter/cupertino.dart';

class MyPageProvider with ChangeNotifier {
  /// 내 정보 수정 - 성별
  List<bool> _updateGenderState = [false, false];
  List<bool> get updateGenderState => _updateGenderState;

  void genderStateChange(List<bool> state) {
    _updateGenderState = state;
    notifyListeners();
  }
}