
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sense_flutter_application/constants/logger.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';

class CEProvider with ChangeNotifier {

  /// event id
  int _eventUniqueId = -1;
  int get eventUniqueId => _eventUniqueId;

  @override
  void createEventUniqueId(int state) {
    _eventUniqueId = state;
  }

  /// safearea padding
  double _safeAreaTopPadding = 0.0;
  double get safeAreaTopPadding => _safeAreaTopPadding;

  double _safeAreaBottomPadding = 0.0;
  double get safeAreaBottomPadding => _safeAreaBottomPadding;

  @override
  void safeAreaPaddingChange(double safeAreaTopPadding, double safeAreaBottomPadding) {
    _safeAreaTopPadding = safeAreaTopPadding;
    _safeAreaBottomPadding = safeAreaBottomPadding;
  }

  String _title = '';
  String get title => _title;

  @override
  void titleChange(String state, bool notify) {
    _title = state;
    notify ? notifyListeners() : {};
  }

  List<String> categoryStringList = ["생일", "데이트", "여행", "모임", "비즈니스"];
  int _selectCategory = 0;
  int get selectCategory => _selectCategory;
  int _category = -1;
  int get category => _category;
  String _categoryString = '선택하기';
  String get categoryString => _categoryString;

  // 내부
  void categoryChangeToString(int state, bool notify) {
    _category = state;

    if(_category == -1) {
      _categoryString = "선택하기";
    } else {
      _categoryString = categoryStringList.elementAt(_category);
    }
    notify ? notifyListeners() : {};
  }

  // 디스플레이
  void selectCategoryChange(int state, bool notify) {
    _selectCategory = state;
    notify ? notifyListeners() : {};
  }

  // 디스플레이
  void categorySave() {
    categoryChangeToString(_selectCategory, true);
  }

  List<String> targetStringList = ["가족", "연인", "친구", "직장"];
  int _selectTarget = 0;
  int get selectTarget => _selectTarget;
  int _target = -1;
  int get target => _target;
  String _targetString = '선택하기';
  String get targetString => _targetString;

  // 내부
  void targetChangeToString(int state, bool notify) {
    _target = state;

    if(_target == -1) {
      _targetString = "선택하기";
    } else {
      _targetString = targetStringList.elementAt(_target);
    }
    notify ? notifyListeners() : {};
  }

  // 디스플레이
  void selectTargetChange(int state, bool notify) {
    _selectTarget = state;
    notify ? notifyListeners() : {};
  }

  // 디스플레이
  void targetSave() {
    targetChangeToString(_selectTarget, true);
  }

  String _date = '';
  String get date => _date;
  String _selectDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String get selectDate => _selectDate;

  void dateChangeToString(String state, bool notify) {
    _date = state.substring(0, 10);
    notify ? notifyListeners() : {};
  }

  void selectDateChange(String state, bool notify) {
    _selectDate = state.substring(0, 10);
    notify ? notifyListeners() : {};
  }

  void dateSave() {
    dateChangeToString(_selectDate, true);
  }

  // List<String> cityNameList = ['서울', '경기도', '인천', '강원도', '경상도', '전라도', '충청도', '부산', '제주'];
  // int _city = -1;
  // int get city => _city;
  // int _selectCity = 0;
  // int get selectCity => _selectCity;
  // String _cityString = '선택하기';
  // String get cityString => _cityString;
  //
  // // 내부
  // void cityChangeToString(int state, bool notify) {
  //   _city = state;
  //
  //   if(_city == -1) {
  //     _cityString = "선택하기";
  //   } else {
  //     _cityString = cityNameList.elementAt(_city);
  //   }
  //   notify ? notifyListeners() : {};
  // }
  //
  // // 디스플레이
  // void selectCityChange(int state, bool notify) {
  //   _selectCity = state;
  //   notify ? notifyListeners() : {};
  // }
  //
  // // 디스플레이
  // void citySave() {
  //   targetChangeToString(_selectCity, true);
  // }

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
      false, false, false], // 1~21
    [false, false, false,
      false, false, false,
      false, false, false,
      false, false, false, false,
      false, false, false,], // 22~37
    [false, false, false,
      false, false, false,
      false, false, false,
      false, false], // 38~48
    [false, false, false,
      false, false, false,
      false, false, false, false,
      false, false, false, false], // 49~62
    [false, false, false,
      false, false, false, false,
      false, false, false, false], // 63~73
    [false, false, false,
      false, false, false, false,
      false, false, false, false], // 74~84
    [false, false, false,
      false, false,
      false, false, false, false,
      false, false, false,], // 85~96
    [false, false, false, false,
      false, false,
      false, false, false,
      false, false, false, false,
      false, false, false,], // 97~112
    [false, false, false,
      false, false, false] // 113~118
  ];
  List<List<bool>> get subCityState => _subCityState;

  List<int> _saveSubCity = [];
  List<int> get saveSubCity => _saveSubCity;

  void cityChange() {
    _city = _tempCity;
    subRegionConvertToList();
    notifyListeners();
  }

  void cityInitLoad(int state) {
    _city = state;
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
    } else {
      for(int i = 0; i < _subCityState[cityIndex].length; i++) {
        _subCityState[cityIndex][i] = false;
      }
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

  /// 저장용 서브리지온
  void subRegionConvertToList() {
    int startIndex = 0;
    _saveSubCity.clear();

    if(_tempCity == 0) {
      startIndex = 1;
    } else if(_tempCity == 1) {
      startIndex = 22;
    } else if(_tempCity == 2) {
      startIndex = 38;
    } else if(_tempCity == 3) {
      startIndex = 49;
    } else if(_tempCity == 4) {
      startIndex = 63;
    } else if(_tempCity == 5) {
      startIndex = 74;
    } else if(_tempCity == 6) {
      startIndex = 85;
    } else if(_tempCity == 7) {
      startIndex = 97;
    } else if(_tempCity == 7) {
      startIndex = 113;
    }

    for(var e in _subCityState.elementAt(_tempCity)) {
      if(e == true) {
        _saveSubCity.add(startIndex);
      }
      startIndex++;
    }

    SenseLogger().debug(_saveSubCity.toString());
  }

  bool _regionTotalSelector = false;
  bool get regionTotalSelector => _regionTotalSelector;

  String _memo = '';
  String get memo => _title;

  @override
  void memoChange(String state, bool notify) {
    _memo = state;
    notify ? notifyListeners() : {};
  }

  bool _createEventButtonState = false;
  bool get createEventButtonState => _createEventButtonState;

  void createButtonStateChange(bool state) {
    _createEventButtonState = state;
    notifyListeners();
  }

  void createEventClear() {
    _title = '';
    _selectCategory = 0;
    _category = -1;
    _categoryString = '선택하기';
    _selectTarget = 0;
    _target = -1;
    _targetString = '선택하기';
    _date = '';
    _selectDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
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
  }

  void getModel(EventModel getModel) {
    titleChange(getModel.eventTitle!, false);
    selectCategoryChange(getModel.eventCategoryObject!.id! - 1, false);
    selectTargetChange(getModel.targetCategoryObject!.id! - 1, false);
    selectDateChange(getModel.eventDate!, false);
    cityInitLoad(getModel.city!.id! + 1);
    isAlarmChange(getModel.isAlarm!);
    publicTypeChange(getModel.publicType!);

    cityChange();
  }






  /// event info
  int _eventInfoTabState = 0;
  int get eventInfoTabState => _eventInfoTabState;

  void eventInfoTabChange(int state) {
    _eventInfoTabState = state;
    notifyListeners();
  }

  /// 이벤트 알람
  bool _isAlarm = false;
  bool get isAlarm => _isAlarm;

  /// 이벤트 공개 여부
  String _publicType = 'PRIVATE';
  String get publicType => _publicType;

  void isAlarmChange(bool state) {
    _isAlarm = state;
    notifyListeners();
  }

  void publicTypeChange(String state) {
    _publicType = state;
    notifyListeners();
  }

  void drawerDataLoad(bool alarm, String publicType) {
    _isAlarm = alarm;
    _publicType = publicType;
  }
}