import 'package:flutter/material.dart';
import 'package:sense_flutter_application/models/preference/preference_model.dart';

class PreferenceProvider with ChangeNotifier {
  UserLodgingPreferenceResultModel? _lodgingPreference;
  UserLodgingPreferenceResultModel? get lodgingPreference => _lodgingPreference;

  UserLodgingPreferenceResultModel? hello;

  void initLodgingPreference({
    required UserLodgingPreferenceResultModel preference,
    bool notify = false,
  }) {
    _lodgingPreference = preference;
    if (notify) notifyListeners();
  }
}
