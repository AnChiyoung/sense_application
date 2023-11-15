import 'package:flutter/cupertino.dart';

class TasteProvider with ChangeNotifier {
  int _presentStep = 1;
  int get presentStep => _presentStep;

  void presentStepChange(int state) {
    _presentStep = state;
    notifyListeners();
  }

  bool _foodButtonState = true;
  bool get foodButtonState => _foodButtonState;

  void foodButtonStateChange(bool state) {
    _foodButtonState = state;
    notifyListeners();
  }

  int _beforePrice = 0;
  int get beforePrice => _beforePrice;
  int _foodPrice = 0;
  int get foodPrice => _foodPrice;

  void beforePriceChange(int state) {
    _beforePrice = state;
    _foodPrice = state;
    notifyListeners();

    /// non notify!!!
  }

  void foodPriceChange(int state) {
    _foodPrice = state;
    notifyListeners();
  }

  List<bool> _foodSelector = [false, false, false, false, false, false, false, false, false];
  List<bool> get foodSelector => _foodSelector;

  List<int> _selectorDirection = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> get selectorDirection => _selectorDirection;

  void foodSelectorChange(int index, bool state) {
    _foodSelector[index] = state;

    /// 선택 카운트 재정렬
    int counting = 0;

    int originalNumber = _selectorDirection.elementAt(index);

    if (state == false) {
      _selectorDirection[index] = 0;
      for (int i = 0; i < _selectorDirection.length; i++) {
        if (_selectorDirection.elementAt(i) > originalNumber) {
          _selectorDirection[i] = _selectorDirection.elementAt(i) - 1;
        } else {}
      }
      print(_selectorDirection);
    } else {
      for (var elements in _selectorDirection) {
        if (elements != 0) {
          counting++;
        }
      }
      if (counting == 0) {
        counting = 1;
      } else {
        counting++;
      }

      _selectorDirection[index] = counting;
      // _selectorDirection
    }
    print(_selectorDirection);
    print(counting);
    notifyListeners();
  }

  // void selectorDirectionChange(List<int> state) {
  //   _selectorDirection = state;
  //   notifyListeners();
  // }

  List<bool> _spicySelector = [false, false, false, false, false];
  List<bool> get spicySelector => _spicySelector;

  void spicySelectorChange(int index, bool state) {
    _spicySelector[index] = state;
    notifyListeners();
  }

  List<bool> _candySelector = [false, false, false, false, false];
  List<bool> get candySelector => _candySelector;

  void candySelectorChange(int index, bool state) {
    _candySelector[index] = state;
    notifyListeners();
  }

  List<bool> _saltySelector = [false, false, false, false, false];
  List<bool> get saltySelector => _saltySelector;

  void saltySelectorChange(int index, bool state) {
    _saltySelector[index] = state;
    notifyListeners();
  }

  String _foodStep06 = '';
  String get foodStep06 => _foodStep06;

  void foodStep06Change(String state) {
    _foodStep06 = state;
    notifyListeners();
  }

  String _foodStep07 = '';
  String get foodStep07 => _foodStep07;

  void foodStep07Change(String state) {
    _foodStep07 = state;
    notifyListeners();
  }

  void foodTasteInit() {
    _presentStep = 1;
    _foodButtonState = true;
    _beforePrice = 0;
    _foodPrice = 0;
    _foodSelector = [false, false, false, false, false, false, false, false, false];
    _selectorDirection = [0, 0, 0, 0, 0, 0, 0, 0, 0];
    _spicySelector = [false, false, false, false, false];
    _candySelector = [false, false, false, false, false];
    _saltySelector = [false, false, false, false, false];
    _foodStep06 = '';
    _foodStep07 = '';
    notifyListeners();
  }

  /// lodging area
  int _lodgingPresentStep = 1;
  int get lodgingPresentStep => _lodgingPresentStep;

  void lodgingPresentStepChange(int state) {
    _lodgingPresentStep = state;
    notifyListeners();
  }

  int _lodgingBeforePrice = 0;
  int get lodgingBeforePrice => _lodgingBeforePrice;
  int _lodgingPrice = 0;
  int get lodgingPrice => _lodgingPrice;

  void lodgingBeforePriceChange(int state) {
    _lodgingBeforePrice = state;
    _lodgingPrice = state;
    notifyListeners();

    /// non notify!!!
  }

  void lodgingPriceChange(int state) {
    _lodgingPrice = state;
    notifyListeners();
  }

  final List<bool> _lodgingSelector = [false, false, false, false, false, false];
  List<bool> get lodgingSelector => _lodgingSelector;

  void lodgingSelectorChange(int index, bool state) {
    _lodgingSelector[index] = state;
    notifyListeners();
  }

  final List<bool> _lodgingEnvSelector = [false, false, false, false, false, false];
  List<bool> get lodgingEnvSelector => _lodgingEnvSelector;

  void lodgingEnvSelectorChange(int index, bool state) {
    _lodgingEnvSelector[index] = state;
    notifyListeners();
  }

  final List<bool> _lodgingToolSelector = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<bool> get lodgingToolSelector => _lodgingToolSelector;

  void lodgingToolSelectorChange(int index, bool state) {
    _lodgingToolSelector[index] = state;
    notifyListeners();
  }

  String _lodgingStep05 = '';
  String get lodgingStep05 => _lodgingStep05;

  void lodgingStep05Change(String state) {
    _lodgingStep05 = state;
    notifyListeners();
  }

  String _lodgingStep06 = '';
  String get lodgingStep06 => _lodgingStep06;

  void lodgingStep06Change(String state) {
    _lodgingStep06 = state;
    notifyListeners();
  }

  /// travel area
  int _travelPresentStep = 1;
  int get travelPresentStep => _travelPresentStep;

  void travelPresentStepChange(int state) {
    _travelPresentStep = state;
    notifyListeners();
  }

  int _travelBeforePrice = 0;
  int get travelBeforePrice => _travelBeforePrice;
  int _travelPrice = 0;
  int get travelPrice => _travelPrice;

  void travelBeforePriceChange(int state) {
    _travelBeforePrice = state;
    _travelPrice = state;
    notifyListeners();

    /// non notify!!!
  }

  void travelPriceChange(int state) {
    _travelPrice = state;
    notifyListeners();
  }

  final List<bool> _distanceSelector = [false, false, false, false, false];
  List<bool> get distanceSelector => _distanceSelector;

  void distanceSelectorChange(int index, bool state) {
    _distanceSelector[index] = state;
    notifyListeners();
  }

  final List<bool> _themeSelector = [false, false, false, false, false, false];
  List<bool> get themeSelector => _themeSelector;

  void themeSelectorChange(int index, bool state) {
    _themeSelector[index] = state;
    notifyListeners();
  }

  final List<bool> _peopleSelector = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<bool> get peopleSelector => _peopleSelector;

  void peopleSelectorChange(int index, bool state) {
    _peopleSelector[index] = state;
    notifyListeners();
  }

  String _travelStep05 = '';
  String get travelStep05 => _travelStep05;

  void travelStep05Change(String state) {
    _travelStep05 = state;
    notifyListeners();
  }

  String _travelStep06 = '';
  String get travelStep06 => _travelStep06;

  void travelStep06Change(String state) {
    _travelStep06 = state;
    notifyListeners();
  }
}
