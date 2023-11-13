import 'package:sense_flutter_application/models/preference/preference_model.dart';
import 'package:sense_flutter_application/utils/api.dart';

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
      return [];
    }
  }

  Future<List<PreferenceTravelModel>> _getPreferenceTravelList(
      {required EnumPreferenceTravelType travelType}) async {
    String endPoint = switch (travelType) {
      EnumPreferenceTravelType.distance => '/travel-distance',
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
      return [];
    }
  }

  Future<List<PreferenceTasteModel>> getPreferenceTasteSpicyList() =>
      _getPreferenceTasteList(tasteType: EnumPreferenceTasteType.spicy);
  Future<List<PreferenceTasteModel>> getPreferenceTasteSweetList() =>
      _getPreferenceTasteList(tasteType: EnumPreferenceTasteType.sweet);
  Future<List<PreferenceTasteModel>> getPreferenceTasteSaltyList() =>
      _getPreferenceTasteList(tasteType: EnumPreferenceTasteType.salty);

  Future<List<PreferenceLodgingModel>> getPreferenceLodgingEnvironmentsList() =>
      _getPreferenceLodgingList(lodgingType: EnumPreferenceLodgingType.environments);
  Future<List<PreferenceLodgingModel>> getPreferenceLodgingOptionList() =>
      _getPreferenceLodgingList(lodgingType: EnumPreferenceLodgingType.options);
  Future<List<PreferenceLodgingModel>> getPreferenceLodgingTypeList() =>
      _getPreferenceLodgingList(lodgingType: EnumPreferenceLodgingType.types);

  Future<List<PreferenceTravelModel>> getPreferenceTravelOptionList() =>
      _getPreferenceTravelList(travelType: EnumPreferenceTravelType.distance);
  Future<List<PreferenceTravelModel>> getPreferenceTravelEnvironmentsList() =>
      _getPreferenceTravelList(travelType: EnumPreferenceTravelType.environments);
  Future<List<PreferenceTravelModel>> getPreferenceTravelTypeList() =>
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
      return [];
    }
  }

  Future<UserFoodPreferenceModel?> getUserFoodPreferenceByUserId({required int id}) async {
    try {
      final response = await ApiRequest().get(
        url: '/user/$id/food-preference',
        fromJson: UserFoodPreferenceModel.fromJson,
        withToken: true,
      );
      return response.data;
    } catch (e) {
      return null;
    }
  }

  Future<UserLodgingPreferenceModel?> getUserLodgingPreferenceByUserId({required int id}) async {
    try {
      final response = await ApiRequest().get(
        url: '/user/$id/lodging-preference',
        fromJson: UserLodgingPreferenceModel.fromJson,
        withToken: true,
      );
      return response.data;
    } catch (e) {
      return null;
    }
  }

  Future<UserTravelPreferenceModel?> getUserTravelPreferenceByUserId({required int id}) async {
    try {
      final response = await ApiRequest().get(
        url: '/user/$id/travel-preference',
        fromJson: UserTravelPreferenceModel.fromJson,
        withToken: true,
      );
      return response.data;
    } catch (e) {
      return null;
    }
  }
}
