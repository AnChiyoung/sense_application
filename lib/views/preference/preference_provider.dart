import 'package:flutter/material.dart';
import 'package:sense_flutter_application/models/preference/preference_model.dart';
import 'package:sense_flutter_application/models/preference/preference_repository.dart';

mixin PreferenceResultProvider on ChangeNotifier {
  UserFoodPreferenceResultModel? _foodPreferenceResult;
  UserFoodPreferenceResultModel? get foodPreferenceResult => _foodPreferenceResult;
  UserLodgingPreferenceResultModel? _lodgingPreferenceResult;
  UserLodgingPreferenceResultModel? get lodgingPreferenceResult => _lodgingPreferenceResult;
  UserTravelPreferenceResultModel? _travelPreferenceResult;
  UserTravelPreferenceResultModel? get travelPreferenceResult => _travelPreferenceResult;

  void initFoodPreferenceResult({
    required UserFoodPreferenceResultModel preferenceResult,
    bool notify = false,
  }) {
    _foodPreferenceResult = preferenceResult;
    if (notify) notifyListeners();
  }

  void initLodgingPreferenceResult({
    required UserLodgingPreferenceResultModel preferenceResult,
    bool notify = false,
  }) {
    _lodgingPreferenceResult = preferenceResult;
    if (notify) notifyListeners();
  }

  void initTravelPreferenceResult({
    required UserTravelPreferenceResultModel preferenceResult,
    bool notify = false,
  }) {
    _travelPreferenceResult = preferenceResult;
    if (notify) notifyListeners();
  }
}

class PreferenceProvider with ChangeNotifier, PreferenceResultProvider {
  int _step = 1;
  int get step => _step;

  int _foodPrice = 0;
  int get foodPrice => _foodPrice;
  bool _limitFoodPrice = false;
  bool get limitFoodPrice => _limitFoodPrice;
  List<int> _foodList = [];
  List<int> get foodList => _foodList;
  List<int> _spicyList = [];
  List<int> get spicyList => _spicyList;
  List<int> _sweetList = [];
  List<int> get sweetList => _sweetList;
  List<int> _saltyList = [];
  List<int> get saltyList => _saltyList;
  String _foodLikeMemo = '';
  String get foodLikeMemo => _foodLikeMemo;
  String _foodDislikeMemo = '';
  String get foodDislikeMemo => _foodDislikeMemo;

  void stepChange({required int value, bool notify = false}) {
    _step = value;
    if (notify) notifyListeners();
  }

  void nextStep({bool notify = false}) {
    _step++;
    if (notify) notifyListeners();
  }

  void prevStep({bool notify = false}) {
    _step--;
    if (notify) notifyListeners();
  }

  void resetFoodPreference({bool notify = false}) {
    _step = 1;
    _foodPrice = 0;
    _limitFoodPrice = false;
    _foodList = [];
    _spicyList = [];
    _sweetList = [];
    _saltyList = [];
    _foodLikeMemo = '';
    _foodDislikeMemo = '';

    if (notify) notifyListeners();
  }

  void changeFoodPrice(int state, {bool notify = false}) {
    _foodPrice = state;
    if (notify) notifyListeners();
  }

  void changeLimitFoodPrice(bool state, {bool notify = false}) {
    _limitFoodPrice = state;
    if (notify) notifyListeners();
  }

  void selectFoodElement(int elementId, {bool notify = false}) {
    final nextValue = [..._foodList];
    if (_foodList.contains(elementId)) {
      nextValue.remove(elementId);
    } else {
      nextValue.add(elementId);
    }
    _foodList = nextValue;

    if (notify) notifyListeners();
  }

  void onTapSpicy(int id, {bool notify = false}) {
    final nextValue = [..._spicyList];
    if (_spicyList.contains(id)) {
      nextValue.remove(id);
    } else {
      nextValue.add(id);
    }
    _spicyList = nextValue;

    if (notify) notifyListeners();
  }

  void onTapSweet(int id, {bool notify = false}) {
    final nextValue = [..._sweetList];
    if (_sweetList.contains(id)) {
      nextValue.remove(id);
    } else {
      nextValue.add(id);
    }
    _sweetList = nextValue;

    if (notify) notifyListeners();
  }

  void onTapSalty(int id, {bool notify = false}) {
    final nextValue = [..._saltyList];
    if (_saltyList.contains(id)) {
      nextValue.remove(id);
    } else {
      nextValue.add(id);
    }
    _saltyList = nextValue;

    if (notify) notifyListeners();
  }

  void changeLikeMemo(String state, {bool notify = false}) {
    _foodLikeMemo = state;
    if (notify) notifyListeners();
  }

  void changeDislikeMemo(String state, {bool notify = false}) {
    _foodDislikeMemo = state;
    if (notify) notifyListeners();
  }

  Future<dynamic> saveFoodPreference({bool notify = false}) async {
    dynamic result = await PreferenceRepository().postFoodPreference({
      'price': _limitFoodPrice ? -1 : _foodPrice,
      'like_memo': _foodLikeMemo,
      'dislike_memo': _foodDislikeMemo,
      'foods': _foodList,
      'spicy_tastes': _spicyList,
      'sweet_tastes': _sweetList,
      'salty_tastes': saltyList,
    });

    if (notify) notifyListeners();

    return result;
  }
}
