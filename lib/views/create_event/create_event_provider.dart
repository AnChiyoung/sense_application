import 'package:flutter/cupertino.dart';
import 'package:sense_flutter_application/models/event/region_model.dart';

class CreateEventProvider with ChangeNotifier {

  int _eventUniqueId = -1;
  int get eventUniqueId => _eventUniqueId;

  void createEventUniqueId(int id) {
    _eventUniqueId = id;
    /// non notify!!!
  }

  /// event date area
  String _title = '이벤트';
  String get title => _title;

  int _category = -1;
  int get category => _category;

  int _target = -1;
  int get target => _target;

  String _date = '';
  String get date => _date;

  String _memo = '';
  String get memo => _memo;

  /// new region 20230810
  int _city = -1;
  int get city => _city;

  int _tempCity = -1;
  int get tempCity => _tempCity;

  List<int> _subCity = [];
  List<int> get subCity => _subCity;

  bool _totalBoxState = false;
  bool get totalBoxState => _totalBoxState;

  List<List<bool>> _subCityState = [
    [false, false, false, false, false, false,
      false, false, false, false, false, false,
      false, false, false, false, false, false,
      false, false, false],
    [false, false, false,
      false, false, false,
      false, false, false,
      false, false, false, false,
      false, false, false,],
    [false, false, false,
      false, false, false,
      false, false, false,
      false, false],
    [false, false, false,
      false, false, false,
      false, false, false, false,
      false, false, false, false],
    [false, false, false,
      false, false, false, false,
      false, false, false, false],
    [false, false, false,
      false, false, false, false,
      false, false, false, false],
    [false, false, false,
      false, false,
      false, false, false, false,
      false, false, false,],
    [false, false, false, false,
      false, false,
      false, false, false,
      false, false, false, false,
      false, false, false,],
    [false, false, false,
      false, false, false]
  ];
  List<List<bool>> get subCityState => _subCityState;

  void cityChange() {
    _city = _tempCity;
    notifyListeners();
  }

  /// 저장 버튼 누르기 전 사용자에게 보이는 도시 이름 표기 용도
  void tempCityChange(int state, bool notify) {
    _tempCity = state;
    if(!_subCityState[state].contains(false)) {
      _totalBoxState = true;
    } else {
      _totalBoxState = false;
    }
    if(notify == true) {
      notifyListeners();
    } else {
    }
  }

  void totalBoxStateChange(bool state, int indexState) {
    _totalBoxState = state;
    int cityIndex = indexState == -1 ? 0 : indexState;
    if(_totalBoxState == true) {
      for(int i = 0; i < _subCityState[cityIndex].length; i++) {
        _subCityState[cityIndex][i] = true;
      }
      // _subCityState[cityIndex][0] = true;
      // _subCityState[cityIndex][1] = true;
    } else {
      for(int i = 0; i < _subCityState[cityIndex].length; i++) {
        _subCityState[cityIndex][i] = false;
      }
      // _subCityState[cityIndex][0] = false;
      // _subCityState[cityIndex][1] = false;
    }
    notifyListeners();
  }

  void boxStateChange(bool state, int cityIndexState, int index) {
    _subCityState[cityIndexState][index] = state;
    if(!_subCityState[cityIndexState].contains(false)) {
      _totalBoxState = true;
    } else {
      _totalBoxState = false;
    }
    // if((_subCityState[cityIndexState][0] && _subCityState[cityIndexState][1]) == false) {
    //   _totalBoxState = false;
    // } else {
    //   _totalBoxState = true;
    // }

    /// 아래 건은 전체 검사, 비활성 부분에 대해서는 x
    // if(_subCityState[cityIndexState].contains(false)) {
    //   _totalBoxState = false;
    // } else {
    //   _totalBoxState = true;
    // }
    notifyListeners();
  }

  void totalBoxStatCheck(int cityIndex) {
    if(!_subCityState[cityIndex].contains(false)) {
      _totalBoxState = true;
    } else {
      _totalBoxState = false;
    }
    notifyListeners();
  }

  void saveRegionChange() {
    print('city : $_tempCity');
    if(_tempCity == -1) {
      _tempCity = 0;
    }
    _city = _tempCity;
    if(_subCityState[0][0] == true) {
      _subCity.contains(1) ? {} : _subCity.add(1) ;
    } else {
      _subCity.contains(1) ? _subCity.remove(1) : {};
    }

    if(_subCityState[0][1] == true) {
      _subCity.contains(2) ? {} : _subCity.add(2);
    } else {
      _subCity.contains(2) ? _subCity.remove(2) : {};
    }
    // print(_city);
    // print(_tempCity);
    // print(_subCityState[0]);
    // print(_subCity);
    notifyListeners();
  }

  /// 실제로 저장되어서 메인화면에 표시할 city number string
  // String _saveCity = '0';
  // String get saveCity => _saveCity;

  /// bottom sheet에서 선택되고 있는 city number
  // String _cityNumber = '1';
  // String get cityNumber => _cityNumber;
  //
  // String _cityName = '서울 강남';
  // String get cityName => _cityName;

  bool _regionTotalSelector = false;
  bool get regionTotalSelector => _regionTotalSelector;

  List<bool> _subCityList = [];
  List<bool> get subCityList => _subCityList;

  bool _createEventButtonState = false;
  bool get createEventButtonState => _createEventButtonState;

  void titleChange(String state) {
    _title = state;
    /// non notify!!!
    notifyListeners();
  }

  void createButtonStateChange(bool state) {
    _createEventButtonState = state;
    notifyListeners();
  }

  void categoryChange(int state) {
    _category = state;
    notifyListeners();
  }

  void targetChange(int state) {
    _target = state;
    notifyListeners();
  }

  void dateChange(String state) {
    // _date = state.substring(0, 10);
    if(state.isEmpty) {
      _date = state;
    } else {
      _date = state.substring(0, 10);
    }
    _date = state;
    notifyListeners();
  }

  // void cityChange(String cityName, String cityNumber) {
  //   _cityName = cityName;
  //   _cityNumber = cityNumber;
  //   notifyListeners();
  // }

  void regionTotalSelectorChange(bool state) {
    _regionTotalSelector = state;
    notifyListeners();
  }

  // void tester(String state) {
  //   _saveCity = state;
  //   notifyListeners();
  // }

  // void cityChange(String state, String nameState) {
  //   _city = state;
  //   _cityName = nameState;
  //   notifyListeners();
  // }

  // void cityListChange(List<City> state) {
  //   _cityList = state;
  //   // notifyListeners();
  // }

  // void subCityChange(List<bool> state) {
  //   _subCityList = state;
  //   // notifyListeners();
  //   /// non notify!!!
  // }

  // void subCityElementChange(bool state, index) {
  //   _subCityList[index] = state;
  //   notifyListeners();
  // }

  // void regionTotalSelectorChange(bool state) {
  //   _regionTotalSelector = state;
  //   notifyListeners();
  // }

  // void subCityChange(String state) {
  //   _subCity = state;
  //   notifyListeners();
  // }

  void memoChange(String state) {
    _memo = state;
    /// non notify!!!
  }



  double _safeAreaTopPadding = 0.0;
  double get safeAreaTopPadding => _safeAreaTopPadding;

  double _safeAreaBottomPadding = 0.0;
  double get safeAreaBottomPadding => _safeAreaBottomPadding;

  void safeAreaPaddingChange(double safeAreaTopPadding, double safeAreaBottomPadding) {
    _safeAreaTopPadding = safeAreaTopPadding;
    _safeAreaBottomPadding = safeAreaBottomPadding;
    /// non notify!!!!
  }

  /// ui controller provider
  List<bool> _categoryState = [false, false, false, false, false];
  List<bool> get categoryState => _categoryState;

  /// final data
  int _selectCategory = 0;
  int get selectCategory => _selectCategory;

  void categoryStateChange(List<bool> state) {
    _categoryState = state;
    // /// final data create
    // _selectCategoryList.clear();
    // state.asMap().forEach((index, element) {
    //   if(element == true) {
    //     _selectCategoryList.add(index);
    //   } else {
    //     /// nothing!!!
    //   }
    // });
    notifyListeners();
  }

  List<bool> _targetState = [false, false, false, false];
  List<bool> get targetState => _targetState;

  void targetStateChange(List<bool> state) {
    _targetState = state;
    notifyListeners();
  }

  String _nonSaveDate = '';
  String get nonSaveDate => _nonSaveDate;

  void dateStateChange(String state) {
    _nonSaveDate = state;
    /// non notify!!!
  }

  void regionInitialize() {
    _city = -1;
    _tempCity = -1;
    _subCity.clear();
    for(int i = 0; i < 9; i++) {
      for(int j = 0; j < _subCityState[i].length; j++) {
        _subCityState[i][j] = false;
      }
    }
    _totalBoxState = false;
  }

  void eventInitialize() {
    _title = '';
    _category = -1;
    _target = -1;
    _date = '';
    _city = -1;
    _tempCity = -1;
    _subCity.clear();
    for(int i = 0; i < 9; i++) {
      _subCityState[i].forEach((element) {
        element = false;
      });
    }
    _totalBoxState = false;
    _memo = '';
    _categoryState = [false, false, false, false, false];
    _targetState = [false, false, false, false];
    _createEventButtonState = false;
    notifyListeners();
  }



  /// from event info provider
  /// event alarm, public type
  bool _isAlarm = false;
  bool get isAlarm => _isAlarm;

  String _publicType = 'PRIVATE';
  String get publicType => _publicType;

  void isAlarmChange(bool state) {
    _isAlarm = state;
  }

  void publicTypeChange(String state) {
    _publicType = state;
  }

  /// 계획 탭인지, 추천 탭인지
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

  void recommendStep02Init() {
    _totalCost = 0;
    _costs.clear();
    _costBool.clear();
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

  void recommendFinish() {
    _recommendRequestState = true;
    _isStepping = false;
    _eventRecommendStep = 1;
    _recommendCategory.clear();
    _recommendCategory = [false, false, false, false, false, false];
    _totalCost = 0;
    _costs.clear();
    _costBool.clear();
    _recommendMemo = '';
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