import 'package:flutter/cupertino.dart';

class CreateEventImproveProvider with ChangeNotifier {

  /// create event step
  /// 0 : 이벤트 유형
  /// 1 : 이벤트 대상
  /// 2 : 이벤트 날짜
  /// 3 : 이벤트 위치
  int _eventStepNumber = -1;
  int get eventStepNumber => _eventStepNumber;

  /// 생성된 이벤트 아이디
  int _eventUniqueId = -1;
  int get eventUniqueId => _eventUniqueId;

  /// 이벤트 타이틀
  String _title = '';
  String get title => _title;

  /// 이벤트 바텀시트용 유형
  int _selectCategory = -1;
  int get selectCategory => _selectCategory;

  /// 이벤트 유형
  int _category = -1;
  int get category => _category;

  /// 이벤트 바텀시트용 대상
  int _selectTarget = -1;
  int get selectTarget => _selectTarget;

  /// 이벤트 타겟
  int _target = -1;
  int get target => _target;

  /// 이벤트 바텀시트용 날짜
  String _selectDate = '';
  String get selectDate => _selectDate;

  /// 이벤트 날짜
  String _date = '';
  String get date => _date;

  /// 이벤트 메모
  String _memo = '';
  String get memo => _memo;

  bool _createEventButtonState = false;
  bool get createEventButtonState => _createEventButtonState;

  void createButtonStateChange(bool state) {
    _createEventButtonState = state;
    notifyListeners();
  }

  void createEventUniqueId(int id) {
    _eventUniqueId = id;
  }

  /// title function
  void titleChange(String changeTitle) {
    _title = changeTitle;
  }

  /// category function
  void selectCategoryChange(int changeNumber) {
    _selectCategory = changeNumber;
    notifyListeners();
  }

  void saveCategoryChange() {
    _category = _selectCategory;
    notifyListeners();
  }

  void selectCategorySink() {
    _selectCategory = _category;
  }

  /// target function
  void selectTargetChange(int changeNumber) {
    _selectTarget = changeNumber;
    notifyListeners();
  }

  void saveTargetChange() {
    _target = _selectTarget;
    notifyListeners();
  }

  void selectTargetSink() {
    _selectTarget = _target;
  }

  /// date function
  void dateChange(String state) {
    if(state.isEmpty) {
      _date = state;
    } else {
      _date = state.substring(0, 10);
    }
    _date = state;
    notifyListeners();
  }

  /// memo function
  void memoChange(String changeMemo) {
    _memo = changeMemo;
  }

  /// touch 할 때 어떤 바텀시트를 노출시킬 것인지
  void eventStepState(int state) {
    _eventStepNumber = state;
    notifyListeners();
  }

  /// clear function
  void createEventClear() {
    _eventUniqueId = -1;
    _eventStepNumber = -1;
    _title = '';
    _selectCategory = -1;
    _category = -1;
    _selectTarget = -1;
    _target = -1;
    _date = '';
    _memo = '';
    notifyListeners();
  }
}