import 'package:flutter/material.dart';

class StepProvider with ChangeNotifier {
  int _step = 1;
  int get step => _step;
  String _stepTitle = '만나서 반가워요!\n이름을 알려주세요';
  String get stepTitle => _stepTitle;

  void stepText() {
    if (_step == 1) {
      _stepTitle = "만나서 반가워요!\n이름을 알려주세요";
    } else if (_step == 2) {
      _stepTitle = "주민번호 앞 7자리를\n알려주세요";
    } else if (_step == 3) {
      _stepTitle = "연락처를\n입력해 주세요";
    } else if (_step == 4) {
      _stepTitle = "연락처를\n입력해 주세요";
    } else if (_step == 5) {
      _stepTitle = "인증번호 6자리를\n입력해 주세요";
    } else if (_step == 6) {
      _stepTitle = "이메일을\n작성해주세요";
    }
  }

  void addStep() {
    _step++;
    stepText();
    notifyListeners();
  }

  void removeStep() {
    _step--;
    stepText();
    notifyListeners();
  }

  void resetStep() {
    _step = 1;
    stepText();
    notifyListeners();
  }
}


class TermProvider with ChangeNotifier {
  bool _isFirstTerms = false;
  bool get isFirstTerms => _isFirstTerms;
  bool _isSecondTerms = false;
  bool get isSecondTerms => _isSecondTerms;
  bool _isThirdTerms = false;
  bool get isThirdTerms => _isThirdTerms;
  bool _isFourthTerms = false;
  bool get isFourthTerms => _isFourthTerms;

  void checkFirstTerms() {
    _isFirstTerms = !_isFirstTerms;
    notifyListeners();
  }

  void checkSecondTerms() {
    _isSecondTerms = !_isSecondTerms;
    notifyListeners();
  }

  void checkThirdTerms() {
    _isThirdTerms = !_isThirdTerms;
    notifyListeners();
  }

  void checkFourthTerms() {
    _isFourthTerms = !_isFourthTerms;
    notifyListeners();
  }

  void resetTerm() {
    _isFirstTerms = false;
    _isSecondTerms = false;
    _isThirdTerms = false;
    _isFourthTerms = false;
  }
}
