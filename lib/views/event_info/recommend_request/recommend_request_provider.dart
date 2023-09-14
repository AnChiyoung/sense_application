import 'package:flutter/cupertino.dart';

class RecommendRequestProvider with ChangeNotifier {
  int _step = 1;
  int get step => _step;

  void stepChange(int step, bool notify) {
    print(_costs);
    _step = step;
    if(notify == true) {
      notifyListeners();
    } else {}
  }

  List<bool> _recommendCategory = [false, false, false, false, false, false];
  List<bool> get recommendCategory => _recommendCategory;

  List<int> _recommendCategoryNumber = [];
  List<int> get recommendCategoryNumber => _recommendCategoryNumber;

  void recommendCategoryValueChange(bool state, int index) {
    _recommendCategory[index] = state;
    /// bool to number
    _recommendCategory.asMap().forEach((index, value) {
      if(value == true) {
        if(_recommendCategoryNumber.contains(index + 1) == true) {
        } else {
          _recommendCategoryNumber.add(index + 1);
        }
      } else {
        if(_recommendCategoryNumber.contains(index + 1) == true) {
          _recommendCategoryNumber.remove(index + 1);
        } else {
        }
      }
    });
    /// asc sort
    _recommendCategoryNumber.sort((a, b) => a.compareTo(b));
    print(_recommendCategoryNumber);
    notifyListeners();
  }

  bool _recommendRequestState = false;
  bool get recommendRequestState => _recommendRequestState;

  int _totalCost = 0;
  int get totalCost => _totalCost;

  List<int> _costs = [];
  List<int> get costs => _costs;

  List<List<bool>> _costBool = [];
  List<List<bool>> get costBool => _costBool;

  String _recommendMemo = '';
  String get recommendMemo => _recommendMemo;

  /// 변경된 cost와 index로 리스트 변경 후, 합산
  void sumCostChange(int changeCost, int index) {
    _costs[index] = changeCost;
    if(_costs.isEmpty) {
      _totalCost = 0;
    } else {
      int? sum = 0;
      for (var element in _costs) {
        if(element == -1) {
          /// nothing
        } else {
          sum = (sum! + element);
        }
      }
      _totalCost = sum!;
    }
    notifyListeners();
  }

  /// recommend category 선택 후, 비용 리스트 생성
  void recommendCostListInit() {
    _totalCost = 0;
    _costs.clear();
    int index = 0;
    for (var element in _recommendCategoryNumber) {
      print('element : $element');
      /// category에 따라 초기비용 상이
      if(element == 1) {
        _costs.add(50000);
      } else if(element == 2) {
        _costs.add(200000);
      } else if(element == 3) {
        _costs.add(50000);
      } else if(element == 4) {
        _costs.add(10000);
      } else if(element == 5) {
        _costs.add(-1);
      } else if(element == 6) {
        _costs.add(50000);
      }
      // _costs.add(50000);

      _costBool.add([]);
      for(int i = 0; i < 12; i++) {
        if(i == 0) {
          _costBool.elementAt(index).add(true);
        } else {
          _costBool.elementAt(index).add(false);
        }
      }
      index++;
    }

    for (var element in _costs) {
      if(element == -1) {
        /// nothing
      } else {
        _totalCost = _totalCost + element;
      }
    }
    // notifyListeners();
    /// non notify!!!
  }

  void costSelectorChange(int index, int costIndex) {
    _costBool[index] = [false, false, false, false, false, false, false, false, false, false, false, false];
    _costBool[index][costIndex] = true;
    notifyListeners();
  }

  void recommendFinish() {
    _recommendRequestState = true;
    _step = 1;
    _recommendCategory.clear();
    _recommendCategory = [false, false, false, false, false, false];
    _totalCost = 0;
    _costs.clear();
    _costBool.clear();
    _recommendMemo = '';
    notifyListeners();
  }
}