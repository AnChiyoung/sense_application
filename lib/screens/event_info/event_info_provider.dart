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

  /// event info
  List<bool> _eventInfoTabState = [true, false];
  List<bool> get eventInfoTabState => _eventInfoTabState;

  void eventInfoTabStateChange(List<bool> state) {
    _eventInfoTabState = state;
    // if(_eventInfoTabState.elementAt(0) == true) {
    //   _title = '이벤트';
    // } else {
    //   _title = '추천 요청하기';
    // }
    notifyListeners();
  }

  /// 추천 탭 상태
  // bool _isRecommend = false;
  // bool get isRecommend => _isRecommend;

  /// 추천 진행 중?
  bool _isStepping = false;
  bool get isStepping => _isStepping;
  bool _recommendRequestState = false;
  bool get recommendRequestState => _recommendRequestState;

  /// 상단 타이틀
  String _title = '이벤트';
  String get title => _title;

  /// 추천 탭 정보 스텝
  int _eventRecommendStep = 1;
  int get eventRecommendStep => _eventRecommendStep;

  List<bool> _recommendCategory = [false, false, false, false, false, false];
  List<bool> get recommendCategory => _recommendCategory;
  
  List<int> _recommendCategoryNumber = [];
  List<int> get recommendCategoryNumber => _recommendCategoryNumber;

  int _totalCost = 0;
  int get totalCost => _totalCost;

  List<int> _costs = [];
  List<int> get costs => _costs;

  List<List<bool>> _costBool = [];
  List<List<bool>> get costBool => _costBool;

  String _recommendMemo = '';
  String get recommendMemo => _recommendMemo;

  void recommendInitialize() {
    _isStepping = false;
    _eventRecommendStep = 1;
    _recommendCategory.clear();
    _recommendCategory = [false, false, false, false, false, false];
    _recommendCategoryNumber.clear();
    _recommendRequestState = false;
    _totalCost = 0;
    _costs.clear();
    _costBool.clear();
    _recommendMemo = '';
    notifyListeners();
  }

  void isSteppingStateChange(bool state) {
    _isStepping = state;
    notifyListeners();
  }

  void isFinishRecommendRequest(bool state) {
    _recommendRequestState = state;
    notifyListeners();
  }

  void titleChange(String state) {
    _title = state;
    notifyListeners();
  }

  // void isRecommendStateChange(bool state) {
  //   _isRecommend = state;
  //   notifyListeners();
  // }

  void eventRecommendStepChange(int state) {
    _eventRecommendStep = state;
    notifyListeners();
  }

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

  void costSelectorChange(int index, int costIndex) {
    _costBool[index] = [false, false, false, false, false, false, false, false, false, false, false, false];
    _costBool[index][costIndex] = true;
    notifyListeners();
  }

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

  void recommendMemoChange(String state) {
    _recommendMemo = state;
    notifyListeners();
  }

  /// recommend category 선택 후, 비용 리스트 생성
  void recommendCostListInit() {
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

  void recommendCostChange(int state, int index) {

  }
}