import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sense_flutter_application/models/add_event/add_event_model.dart';

class RecommendedEventProvider with ChangeNotifier {
  bool _buttonState = false;
  bool get buttonState => _buttonState;

  bool _priceNextButton = false;
  bool get priceNextButton => _priceNextButton;

  bool _regionNextButton = false;
  bool get regionNextButton => _regionNextButton;

  int _regionSelectState = -1;
  int get regionSelectState => _regionSelectState;

  List<bool> _subRegionList = [];
  List<bool> get subRegionList => _subRegionList;

  bool _memoNextButton = false;
  bool get memoNextButton => _memoNextButton;

  bool _recommendedButton = false;
  bool get recommendedButton => _recommendedButton;

  bool _editMode = false;
  bool get editMode => _editMode;

  String _editName = AddEventModel.eventInfoName;
  String get editName => _editName;

  String _editTitle = AddEventModel.eventInfoTitle;
  String get editTitle => _editTitle;

  String _editCategory = AddEventModel.eventTypeModel;
  String get editCategory => _editCategory;

  String _editDate = AddEventModel.dateModel;
  String get editDate => _editDate;

  String _editMemo = AddEventModel.memoModel;
  String get editMemo => _editMemo;

  String _selectCategory = '';
  String get selectCategory => _selectCategory;

  bool _select = false;
  bool get select => _select;

  void nextButtonState(bool state) {
    _buttonState = state;
    notifyListeners();
  }

  void nextButtonReset() {
    _buttonState = false;
    notifyListeners();
  }

  void priceNextButtonState(bool state) {
    _priceNextButton = state;
    notifyListeners();
  }

  void priceNextButtonReset() {
    _priceNextButton = false;
    notifyListeners();
  }

  void regionNextButtonState(bool state) {
    _regionNextButton = state;
    notifyListeners();
  }

  void regionNextButtonReset() {
    _regionNextButton = false;
    notifyListeners();
  }

  void regionSelectStateChange(int state) {
    _regionSelectState = state;
    notifyListeners();
  }

  void regionSelectStateReset() {
    _regionSelectState = -1;
    notifyListeners();
  }

  void subRegionBoolListReset() {
    _subRegionList.clear();
    notifyListeners();
  }

  void memoNextButtonState(bool state) {
    _memoNextButton = state;
    notifyListeners();
  }

  void memoNextButtonStateReset() {
    _memoNextButton = false;
    notifyListeners();
  }

  void recommendedButtonState() {

  }

  void isEditMode(bool state) {
    _editMode = state;
    notifyListeners();
  }

  void titleChange() {
    _editTitle = AddEventModel.eventInfoTitle;
    _editName = AddEventModel.eventInfoName;
    _editCategory = AddEventModel.eventTypeModel;
    _editDate = AddEventModel.dateModel;
    _editMemo = AddEventModel.memoModel;

    print(_editTitle + '/' + _editName);
    notifyListeners();
  }

  void categoryChange(String category) {
    _selectCategory = category;
    notifyListeners();
  }

  void productSelectState(bool state) {
    _select = state;
    notifyListeners();
  }
}