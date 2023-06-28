import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sense_flutter_application/models/add_event/add_event_model.dart';
import 'package:sense_flutter_application/models/recommended_event/recommended_model.dart';

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

  List<RecommendedModel> _selectCategory = [];
  List<RecommendedModel> get selectCategory => _selectCategory;

  int _index = 0;
  int get index => _index;

  List<bool> _likeStateModel = [];
  List<bool> get likeStateModel => _likeStateModel;

  bool _select = false;
  bool get select => _select;

  bool _likeState = false;
  bool get likeState => _likeState;

  bool _selectState = false;
  bool get selectState => _selectState;

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

  void productSelectState(bool state) {
    _select = state;
    notifyListeners();
  }

  void tagSelect(List<RecommendedModel> model, int index) {
    _selectCategory = model;
    _index = index;
    notifyListeners();
  }

  void likeStateChange(bool state) {
    _likeState = state;
    notifyListeners();
  }

  void selectStateChange(bool state) {
    _selectState = state;
    notifyListeners();
  }
}