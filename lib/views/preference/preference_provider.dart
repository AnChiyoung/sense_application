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

mixin FoodPreferenceProvider on ChangeNotifier {
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

  void resetFoodPreference({bool notify = false}) {
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

  void onTapSpicy(int level, {bool notify = false}) {
    _spicyList = List.generate(level, (index) => index + 1);

    if (notify) notifyListeners();
  }

  void onTapSweet(int level, {bool notify = false}) {
    _sweetList = List.generate(level, (index) => index + 1);

    if (notify) notifyListeners();
  }

  void onTapSalty(int level, {bool notify = false}) {
    _saltyList = List.generate(level, (index) => index + 1);

    if (notify) notifyListeners();
  }

  void changeFoodLikeMemo(String state, {bool notify = false}) {
    _foodLikeMemo = state;
    if (notify) notifyListeners();
  }

  void changeFoodDislikeMemo(String state, {bool notify = false}) {
    _foodDislikeMemo = state;
    if (notify) notifyListeners();
  }

  Future<dynamic> saveFoodPreference({bool notify = false}) async {
    dynamic result = await PreferenceRepository().postFoodPreference({
      'price': _limitFoodPrice ? -1 : _foodPrice,
      'like_memo': _foodLikeMemo,
      'dislike_memo': _foodDislikeMemo,
      'foods': _foodList,
      'spicy_tastes': _spicyList.map((e) => 5 - e + 1).toList(),
      'sweet_tastes': _sweetList.map((e) => 10 - e + 1).toList(),
      'salty_tastes': _saltyList.map((e) => 15 - e + 1).toList(),
    });

    if (notify) notifyListeners();
    return result;
  }
}

mixin LodgingPreferenceProvider on ChangeNotifier {
  int _lodgingPrice = 0;
  int get lodgingPrice => _lodgingPrice;

  bool _limitLodgingPrice = false;
  bool get limitLodgingPrice => _limitLodgingPrice;

  List<int> _lodgingTypeList = [];
  List<int> get lodgingTypeList => _lodgingTypeList;

  List<int> _lodgingEnvironmentList = [];
  List<int> get lodgingEnvironmentList => _lodgingEnvironmentList;

  List<int> _lodgingOptionList = [];
  List<int> get lodgingOptionList => _lodgingOptionList;

  String _lodgingLikeMemo = '';
  String get lodgingLikeMemo => _lodgingLikeMemo;

  String _lodgingDislikeMemo = '';
  String get lodgingDislikeMemo => _lodgingDislikeMemo;

  void resetLodgingPreference({bool notify = false}) {
    _lodgingPrice = 0;
    _limitLodgingPrice = false;
    _lodgingTypeList = [];
    _lodgingEnvironmentList = [];
    _lodgingOptionList = [];
    _lodgingLikeMemo = '';
    _lodgingDislikeMemo = '';

    if (notify) notifyListeners();
  }

  void changeLodgingPrice(int state, {bool notify = false}) {
    _lodgingPrice = state;
    if (notify) notifyListeners();
  }

  void changeLimitLodgingPrice(bool state, {bool notify = false}) {
    _limitLodgingPrice = state;
    if (notify) notifyListeners();
  }

  void onTapLodgingType(int elementId, {bool notify = false}) {
    final nextValue = [..._lodgingTypeList];
    if (_lodgingTypeList.contains(elementId)) {
      nextValue.remove(elementId);
    } else {
      nextValue.add(elementId);
    }
    _lodgingTypeList = nextValue;

    if (notify) notifyListeners();
  }

  void onTapLodgingEnvironment(int elementId, {bool notify = false}) {
    final nextValue = [..._lodgingEnvironmentList];
    if (_lodgingEnvironmentList.contains(elementId)) {
      nextValue.remove(elementId);
    } else {
      nextValue.add(elementId);
    }
    _lodgingEnvironmentList = nextValue;

    if (notify) notifyListeners();
  }

  void onTapLodgingOption(int elementId, {bool notify = false}) {
    final nextValue = [..._lodgingOptionList];
    if (_lodgingOptionList.contains(elementId)) {
      nextValue.remove(elementId);
    } else {
      nextValue.add(elementId);
    }
    _lodgingOptionList = nextValue;

    if (notify) notifyListeners();
  }

  void changeLodgingLikeMemo(String state, {bool notify = false}) {
    _lodgingLikeMemo = state;
    if (notify) notifyListeners();
  }

  void changeLodgingDislikeMemo(String state, {bool notify = false}) {
    _lodgingDislikeMemo = state;
    if (notify) notifyListeners();
  }

  Future<dynamic> saveLodgingPreference({bool notify = false}) async {
    dynamic result = await PreferenceRepository().postLodgingPreference({
      'price': _limitLodgingPrice ? -1 : _lodgingPrice,
      'like_memo': _lodgingLikeMemo,
      'dislike_memo': _lodgingDislikeMemo,
      'types': _lodgingTypeList,
      'environments': _lodgingEnvironmentList,
      'options': _lodgingOptionList,
    });

    if (notify) notifyListeners();
    return result;
  }
}

class PreferenceProvider
    with
        ChangeNotifier,
        PreferenceResultProvider,
        FoodPreferenceProvider,
        LodgingPreferenceProvider {
  int _step = 1;
  int get step => _step;

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

  @override
  void resetFoodPreference({bool notify = false}) {
    _step = 1;
    super.resetFoodPreference(notify: notify);
  }

  @override
  void resetLodgingPreference({bool notify = false}) {
    _step = 1;
    super.resetLodgingPreference(notify: notify);
  }
}
