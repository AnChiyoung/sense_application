import 'package:flutter/material.dart';
import 'package:sense_flutter_application/models/preference/preference_model.dart';
import 'package:sense_flutter_application/api/api.dart';

class PreferenceRepository {
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
  };

  Future<List<PreferenceFoodModel>> getPreferenceFoodList() async {
    try {
      final response = await ApiRequest().getList<PreferenceFoodModel>(
        url: '/foods',
        fromJson: PreferenceFoodModel.fromJson,
      );

      return response.data;
    } catch (e) {
      debugPrint('getPreferenceFoodList(): ${e.toString()}');
      return [];
    }
  }

  Future<List<PreferenceTasteModel>> _getPreferenceTasteList(
      {required EnumPreferenceTasteType tasteType}) async {
    try {
      final response = await ApiRequest().getList<PreferenceTasteModel>(
        url: '/tastes',
        fromJson: PreferenceTasteModel.fromJson,
        params: {
          'type': tasteType.value,
        },
      );

      return response.data;
    } catch (e) {
      debugPrint('_getPreferenceTasteList(): ${e.toString()}');
      return [];
    }
  }

  Future<List<PreferenceLodgingModel>> _getPreferenceLodgingList(
      {required EnumPreferenceLodgingType lodgingType}) async {
    String endPoint = switch (lodgingType) {
      EnumPreferenceLodgingType.environments => '/lodging-environments',
      EnumPreferenceLodgingType.options => '/lodging-options',
      EnumPreferenceLodgingType.types => '/lodging-types',
    };

    try {
      final response = await ApiRequest().getList<PreferenceLodgingModel>(
        url: endPoint,
        fromJson: PreferenceLodgingModel.fromJson,
      );

      return response.data;
    } catch (e) {
      debugPrint('_getPreferenceLodgingList: ${e.toString()}');
      return [];
    }
  }

  Future<List<PreferenceTravelModel>> _getPreferenceTravelList(
      {required EnumPreferenceTravelType travelType}) async {
    String endPoint = switch (travelType) {
      EnumPreferenceTravelType.distance => '/travel-distances',
      EnumPreferenceTravelType.environments => '/travel-environments',
      EnumPreferenceTravelType.mates => '/travel-mates',
    };

    try {
      final response = await ApiRequest().getList<PreferenceTravelModel>(
        url: endPoint,
        fromJson: PreferenceTravelModel.fromJson,
      );

      return response.data;
    } catch (e) {
      debugPrint('_getPreferenceTravelList: ${e.toString()}');
      return [];
    }
  }

  Future<List<PreferenceTasteModel>> getPreferenceTasteSpicyList() =>
      _getPreferenceTasteList(tasteType: EnumPreferenceTasteType.spicy);
  Future<List<PreferenceTasteModel>> getPreferenceTasteSweetList() =>
      _getPreferenceTasteList(tasteType: EnumPreferenceTasteType.sweet);
  Future<List<PreferenceTasteModel>> getPreferenceTasteSaltyList() =>
      _getPreferenceTasteList(tasteType: EnumPreferenceTasteType.salty);

  Future<List<PreferenceLodgingModel>> getPreferenceLodgingEnvironmentList() =>
      _getPreferenceLodgingList(lodgingType: EnumPreferenceLodgingType.environments);
  Future<List<PreferenceLodgingModel>> getPreferenceLodgingOptionList() =>
      _getPreferenceLodgingList(lodgingType: EnumPreferenceLodgingType.options);
  Future<List<PreferenceLodgingModel>> getPreferenceLodgingTypeList() =>
      _getPreferenceLodgingList(lodgingType: EnumPreferenceLodgingType.types);

  Future<List<PreferenceTravelModel>> getPreferenceTravelDistanceList() =>
      _getPreferenceTravelList(travelType: EnumPreferenceTravelType.distance);
  Future<List<PreferenceTravelModel>> getPreferenceTravelEnvironmentList() =>
      _getPreferenceTravelList(travelType: EnumPreferenceTravelType.environments);
  Future<List<PreferenceTravelModel>> getPreferenceTravelMateList() =>
      _getPreferenceTravelList(travelType: EnumPreferenceTravelType.mates);

  Future<List<UserPreferenceListItemModel>> getUserPreferenceListByUserId({required int id}) async {
    try {
      final response = await ApiRequest().getList(
        url: '/user/$id/preferences',
        fromJson: UserPreferenceListItemModel.fromJson,
        withToken: true,
      );
      return response.data;
    } catch (e) {
      debugPrint('getUserPreferenceListByUserId: ${e.toString()}');
      return [];
    }
  }

  Future<UserFoodPreferenceResultModel?> getUserFoodPreferenceByUserId({required int id}) async {
    try {
      final response = await ApiRequest().get(
        url: '/user/$id/food-preference',
        fromJson: UserFoodPreferenceResultModel.fromJson,
        withToken: true,
      );
      return response.data;
    } catch (e) {
      debugPrint('getUserFoodPreferenceByUserId: ${e.toString()}');
      return null;
    }
  }

  Future<UserLodgingPreferenceResultModel?> getUserLodgingPreferenceByUserId(
      {required int id}) async {
    try {
      final response = await ApiRequest().get(
        url: '/user/$id/lodging-preference',
        fromJson: UserLodgingPreferenceResultModel.fromJson,
        withToken: true,
      );
      return response.data;
    } catch (e) {
      debugPrint('getUserLodgingPreferenceByUserId: ${e.toString()}');
      return null;
    }
  }

  Future<UserTravelPreferenceResultModel?> getUserTravelPreferenceByUserId(
      {required int id}) async {
    try {
      final response = await ApiRequest().get(
        url: '/user/$id/travel-preference',
        fromJson: UserTravelPreferenceResultModel.fromJson,
        withToken: true,
      );
      return response.data;
    } catch (e) {
      debugPrint('getUserTravelPreferenceByUserId: ${e.toString()}');
      return null;
    }
  }

  Future<dynamic> postFoodPreference(Map<String, dynamic> data) async {
    try {
      final response = await ApiRequest().post(
        url: '/food-preference',
        withToken: true,
        data: data,
      );
      // return response.data;
      return response;
    } catch (e) {
      debugPrint('postFoodPreference: ${e.toString()}');
      return null;
    }
  }

  Future<dynamic> postLodgingPreference(Map<String, dynamic> data) async {
    try {
      final response = await ApiRequest().post(
        url: '/lodging-preference',
        withToken: true,
        data: data,
      );
      // return response.data;
      return response;
    } catch (e) {
      debugPrint('postLodgingPreference: ${e.toString()}');
      return null;
    }
  }

  Future<dynamic> postTravelPreference(Map<String, dynamic> data) async {
    try {
      final response = await ApiRequest().post(
        url: '/travel-preference',
        withToken: true,
        data: data,
      );
      // return response.data;
      return response;
    } catch (e) {
      debugPrint('travelLodgingPreference: ${e.toString()}');
      return null;
    }
  }
}
