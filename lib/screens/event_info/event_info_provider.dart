import 'package:flutter/cupertino.dart';

enum RecommendCategory {
  GIFT,
  HOTEL,
  LUNCH,
  DINNER,
  ACTIVITY,
  PUB,
}

class EventInfoProvider with ChangeNotifier {
  /// 추천 탭 정보 스텝
  int _eventRecommendStep = 1;
  int get eventRecommendStep => _eventRecommendStep;

  List<bool> _recommendCategory = [true, false, false, false, false, false];
  List<bool> get recommendCategory => _recommendCategory;

  int _totalCost = 0;
  int get totalCost => _totalCost;

  List<int> _costs = [];
  List<int> get costs => _costs;

  String _recommendMemo = '';
  String get recommendMemo => _recommendMemo;

  void eventRecommendStepChange(int state) {
    _eventRecommendStep = state;
    notifyListeners();
  }

  void recommendCategoryValueChange(bool state, int index) {
    _recommendCategory[index] = state;
    notifyListeners();
  }

  /// 변경된 cost와 index로 리스트 변경 후, 합산
  void sumCostChange(int changeCost, int index) {
    if(_costs.isEmpty) {
      _totalCost = 0;
    } else {
      int sum = 0;
      for (var element in _costs) {
        sum = sum + element;
      }
      _totalCost = sum;
    }
    notifyListeners();
  }

  void recommendMemoChange(String state) {
    _recommendMemo = state;
    notifyListeners();
  }
}