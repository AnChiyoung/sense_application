import 'package:flutter/cupertino.dart';
import 'package:sense_flutter_application/models/event/region_model.dart';

class CreateEventProvider with ChangeNotifier {

  /// event date area
  String _title = '';
  String get title => _title;

  int _category = -1;
  int get category => _category;

  int _target = -1;
  int get target => _target;

  String _date = '';
  String get date => _date;

  /// 실제로 저장되어서 메인화면에 표시할 city number string
  String _saveCity = '0';
  String get saveCity => _saveCity;

  /// bottom sheet에서 선택되고 있는 city number
  String _city = '1';
  String get city => _city;

  String _cityName = '서울';
  String get cityName => _cityName;

  List<City> _cityList = [];
  List<City> get cityList => _cityList;

  List<bool> _subCityList = [];
  List<bool> get subCityList => _subCityList;

  bool _regionTotalSelector = false;
  bool get regionTotalSelector => _regionTotalSelector;

  // String _subCity = '';
  // String get subCity => _subCity;

  String _memo = '';
  String get memo => _memo;

  void titleChange(String state) {
    _title = state;
    /// non notify!!!
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
    _date = state.substring(0, 10);
    notifyListeners();
  }

  void cityChange(String state, String nameState) {
    _city = state;
    _cityName = nameState;
    notifyListeners();
  }

  void cityListChange(List<City> state) {
    _cityList = state;
    // notifyListeners();
  }

  void subCityChange(List<bool> state) {
    _subCityList = state;
    // notifyListeners();
    /// non notify!!!
  }

  void subCityElementChange(bool state, index) {
    _subCityList[index] = state;
    notifyListeners();
  }

  void regionTotalSelectorChange(bool state) {
    _regionTotalSelector = state;
    notifyListeners();
  }

  // void subCityChange(String state) {
  //   _subCity = state;
  //   notifyListeners();
  // }

  void memoChange(String state) {
    _memo = state;
    /// non notify!!!
  }

  /// create event step
  /// 0 : 이벤트 유형
  /// 1 : 이벤트 대상
  /// 2 : 이벤트 날짜
  /// 3 : 이벤트 위치
  int _eventStepNumber = -1;
  int get eventStepNumber => _eventStepNumber;

  void eventStepState(int state) {
    _eventStepNumber = state;
    notifyListeners();
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

  void categoryStateChange(List<bool> state) {
    _categoryState = state;
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

  void eventInitialize() {
    _title = '';
    _category = -1;
    _target = -1;
    _date = '';
    _city = '1';
    // _subCity = '';
    _memo = '';
    _categoryState = [false, false, false, false, false];
    _targetState = [false, false, false, false];
    // _categoryState.map((e) => e = false);
    // _targetState.map((e) => e = false);
    notifyListeners();
  }

  /// event info
  List<bool> _eventInfoTabState = [true, false];
  List<bool> get eventInfoTabState => _eventInfoTabState;

  void eventInfoTabStateChange(List<bool> state) {
    _eventInfoTabState = state;
    notifyListeners();
  }
}