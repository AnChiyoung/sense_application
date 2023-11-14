import 'package:flutter/material.dart';
import 'package:sense_flutter_application/models/preference/preference_model.dart';

class PreferenceProvider with ChangeNotifier {
  UserFoodPreferenceResultModel? _foodPreference;
  UserFoodPreferenceResultModel? get foodPreference => _foodPreference;
  UserLodgingPreferenceResultModel? _lodgingPreference;
  UserLodgingPreferenceResultModel? get lodgingPreference => _lodgingPreference;
  UserTravelPreferenceResultModel? _travelPreference;
  UserTravelPreferenceResultModel? get travelPreference => _travelPreference;

  void initFoodPreference({
    required UserFoodPreferenceResultModel preference,
    bool notify = false,
  }) {
    _foodPreference = preference;
    if (notify) notifyListeners();
  }

  void initLodgingPreference({
    required UserLodgingPreferenceResultModel preference,
    bool notify = false,
  }) {
    _lodgingPreference = preference;
    if (notify) notifyListeners();
  }

  void initTravelPreference({
    required UserTravelPreferenceResultModel preference,
    bool notify = false,
  }) {
    _travelPreference = preference;
    if (notify) notifyListeners();
  }
}
