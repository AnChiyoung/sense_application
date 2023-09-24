import 'package:flutter/cupertino.dart';

class StoreProvider with ChangeNotifier {
  List<bool> _storeMenuSelector = [false, false, false, false, false, false];
  List<bool> get storeMenuSelector => _storeMenuSelector;

  List<int> _storeMenuSelectNumber = [];
  List<int> get storeMenuSelectNumber => _storeMenuSelectNumber;

  void recommendCategoryValueChange(bool state, int index) {
    _storeMenuSelector[index] = state;

    /// bool to number
    _storeMenuSelector.asMap().forEach((index, value) {
      if(value == true) {
        if(_storeMenuSelectNumber.contains(index + 1) == true) {
        } else {
          _storeMenuSelectNumber.add(index + 1);
        }
      } else {
        if(_storeMenuSelectNumber.contains(index + 1) == true) {
          _storeMenuSelectNumber.remove(index + 1);
        } else {
        }
      }
    });
    notifyListeners();
  }
}