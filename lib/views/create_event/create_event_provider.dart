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
  String _title = '';
  String get title => _title;

  int _category = -1;
  int get category => _category;

  int _target = -1;
  int get target => _target;

  String _date = '';
  String get date => _date;

  String _memo = '';
  String get memo => _memo;

  /// 실제로 저장되어서 메인화면에 표시할 city number string
  String _saveCity = '0';
  String get saveCity => _saveCity;

  /// bottom sheet에서 선택되고 있는 city number
  String _cityNumber = '1';
  String get cityNumber => _cityNumber;

  String _cityName = '서울';
  String get cityName => _cityName;

  bool _regionTotalSelector = false;
  bool get regionTotalSelector => _regionTotalSelector;

  List<bool> _subCityList = [];
  List<bool> get subCityList => _subCityList;

  bool _createEventButtonState = false;
  bool get createEventButtonState => _createEventButtonState;

  void titleChange(String state) {
    _title = state;
    /// non notify!!!
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
    _date = state.substring(0, 10);
    notifyListeners();
  }

  void cityChange(String cityName, String cityNumber) {
    _cityName = cityName;
    _cityNumber = cityNumber;
    notifyListeners();
  }

  void regionTotalSelectorChange(bool state) {
    _regionTotalSelector = state;
    notifyListeners();
  }

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

  void eventInitialize() {
    _title = '';
    _category = -1;
    _target = -1;
    _date = '';
    _cityNumber = '1';
    // _subCity = '';
    _memo = '';
    _categoryState = [false, false, false, false, false];
    _targetState = [false, false, false, false];
    // _categoryState.map((e) => e = false);
    // _targetState.map((e) => e = false);
    _createEventButtonState = false;
    notifyListeners();
  }
}