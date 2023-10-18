import 'package:flutter/cupertino.dart';

class StoreProvider with ChangeNotifier {

  // PageController _storePageController = PageController(initialPage: 0);
  // PageController get storePageController => _storePageController;

  TextEditingController _storeSearchController = TextEditingController();
  TextEditingController get storeSearchController => _storeSearchController;

  // 최근 검색목록 누르면 서치박스에 배치하고 검색결과 노출
  void textBoxInputAndSearch(String searchTitle) {
    _storeSearchController.text = searchTitle;
    _isSearchView = false;
    notifyListeners();
  }

  bool _isSearchView = false;
  bool get isSearchView => _isSearchView;

  void searchViewChange(bool state) {
    _isSearchView = state;
    notifyListeners();
  }

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