import 'package:flutter/cupertino.dart';

class CreateEventImproveProvider with ChangeNotifier {

  int _visitCount = 0;
  int get visitCount => _visitCount;
  int _recommendCount = 0;
  int get recommendCount => _recommendCount;

  void countInfoChange(int visit, int recommend) {
    _visitCount = visit;
    _recommendCount = recommend;
    // notifyListeners();
  }

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

  void createButtonStateChange(bool state) {
    _createEventButtonState = state;
    notifyListeners();
  }

  void createEventUniqueId(int id) {
    _eventUniqueId = id;
  }

  /// title function
  void titleChange(String changeTitle, bool notify) {
    _title = changeTitle;
    if(notify == false) {
    } else {
      notifyListeners();
    }
  }

  /// category function
  void selectCategoryChange(int changeNumber) {
    _selectCategory = changeNumber;
    notifyListeners();
  }

  void saveCategoryChange(int? state, bool notify) {
    if(state == null) {
      print('edit select : $_selectCategory');
      _category = _selectCategory;
    } else {
      _category = state;
    }
    if(notify == false) {
    } else {
      notifyListeners();
    }
  }

  void selectCategorySink() {
    _selectCategory = _category;
  }

  /// target function
  void selectTargetChange(int changeNumber) {
    _selectTarget = changeNumber;
    notifyListeners();
  }

  void saveTargetChange(int? state, bool notify) {
    if(state == null) {
      _target = _selectTarget;
    } else {
      _target = state;
    }
    if(notify == false) {
    } else {
      notifyListeners();
    }
  }

  void selectTargetSink() {
    _selectTarget = _target;
  }

  /// date function
  void dateSelectChange(String state) {
    print(state);
    _selectDate = state;
  }

  void dateChange(String state, bool notify) {
    _selectDate = state;
    if(state.isEmpty) {
      _date = '';
    } else {
      _date = state.substring(0, 10);
    }
    // _date = state;
    if(notify == true) {
      notifyListeners();
    } else {
    }
  }

  /// memo function
  void memoChange(String changeMemo, bool notify) {
    _memo = changeMemo;
    if(notify == true) {
      notifyListeners();
    }
  }

  /// touch 할 때 어떤 바텀시트를 노출시킬 것인지
  void eventStepState(int state) {
    _eventStepNumber = state;
    notifyListeners();
  }

  /// clear function
  void createEventClear(bool? isIdClear) {
    if(isIdClear == null) {
      _eventUniqueId = -1;
    } else {}
    _eventStepNumber = -1;
    _title = '';
    _selectCategory = -1;
    _category = -1;
    _selectTarget = -1;
    _target = -1;
    _date = '';
    _memo = '';
    _createEventButtonState = false;
    notifyListeners();
  }

//////////////////////////////////////////////// event info view
  bool _isStepping = false;
  bool get isStepping => _isStepping;

  /// 계획 탭인지, 추천 탭인지
  List<bool> _eventInfoTabState = [true, false];
  List<bool> get eventInfoTabState => _eventInfoTabState;

  void isSteppingStateChange(bool state) {
    _isStepping = state;
    notifyListeners();
  }

  void tabChange(List<bool> state) {
    _eventInfoTabState = state;
    notifyListeners();
  }

  void eventInfoTabStateChange(List<bool> state) {
    _eventInfoTabState = state;
    notifyListeners();
  }

  /// calendar -> event info, create event -> event info
  void eventDataLoad(String title, int category, int target, String date, String memo) {
    _title = title;
    _category = category;
    _target = target;
    _date = date;
    _memo = memo;
    _selectCategory = category - 1;
    _selectTarget = target - 1;
    _selectDate = date;
    _eventInfoTabState = [true, false];
    _visitCount = 0;
    _recommendCount = 0;
  }

  void drawerDataLoad(bool alarm, String publicType) {
    _isAlarm = alarm;
    _publicType = publicType;
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void isLoadingStateChange(bool state) {
    _isLoading = state;
    notifyListeners();
  }




  String _public = '-visit_count';
  String get public => _public;

  void totalButtonChange(String state) {
    _public = state;
    notifyListeners();
  }

  String _recommendCommentString = '';
  String get recommendCommentString => _recommendCommentString;

  void recommendCommentChange(String state) {
    _recommendCommentString = state;
    notifyListeners();
  }

  int _useRebuild = 0;
  int get useRebuild => _useRebuild;

  void useRebuildChange() {
    _useRebuild++;
    notifyListeners();
  }
}