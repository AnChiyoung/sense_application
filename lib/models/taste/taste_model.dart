import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/api_path.dart';
import 'package:sense_flutter_application/constants/logger.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/views/personal_taste/taste_provider.dart';

class TasteRequest {
  /// logger
  var logger = Logger(
    printer: PrettyPrinter(
      lineLength: 50,
      colors: false,
      printTime: true,
    ),
  );

  /// food taste create
  Future<bool> createFoodTastePreference(BuildContext context) async {

    List<int> foodList = [];
    List<bool> temper = context.read<TasteProvider>().foodSelector;
    for(int i = 0; i < temper.length; i++) {
      if(temper[i] == true) {
        foodList.add(i+1);
      }
    }

    List<int> spicyList = [];
    List<bool> spicyTemper = context.read<TasteProvider>().spicySelector;
    for(int i = 0; i < spicyTemper.length; i++) {
      if(spicyTemper[i] == true) {
        spicyList.add(i+1);
      }
    }

    List<int> sweetList = [];
    List<bool> sweetTemper = context.read<TasteProvider>().candySelector;
    for(int i = 0; i < sweetTemper.length; i++) {
      if(sweetTemper[i] == true) {
        sweetList.add(i+6);
      }
    }

    List<int> saltyList = [];
    List<bool> saltyTemper = context.read<TasteProvider>().saltySelector;
    for(int i = 0; i < saltyTemper.length; i++) {
      if(saltyTemper[i] == true) {
        saltyList.add(i+11);
      }
    }

    // 취향 생성할 때, 입력값 로그 섹션
    SenseLogger().debug(foodList.toString());
    SenseLogger().debug(spicyList.toString());
    SenseLogger().debug(sweetList.toString());
    SenseLogger().debug(saltyList.toString());

    final foodPrefer =
    {
      'food_price': context.read<TasteProvider>().foodPrice == -1 ? 10000 : context.read<TasteProvider>().foodPrice,
      'food_like_memo': context.read<TasteProvider>().foodStep06,
      'food_dislike_memo': context.read<TasteProvider>().foodStep07,
      'foods': foodList,
      'spicy_tastes': spicyList,
      'sweet_tastes': sweetList,
      'salty_tastes': saltyList,
    };

    final response = await http.post(
      Uri.parse('${ApiUrl.releaseUrl}/food-preference'),
      body: jsonEncode(foodPrefer),
      headers: {
        'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      logger.v('음식 취향 생성 성공');
      return true;
    } else {
      logger.v('음식 취향 생성 실패');
      return false;
    }
  }

  Future<FoodTasteModel> loadFoodPreference(int userId) async {
    final response = await http.get(
      Uri.parse('${ApiUrl.releaseUrl}/user/${userId.toString()}/food-preference'),
      headers: {
        // 'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      logger.v('음식 취향 불러오기 성공');
      FoodTasteModel model = FoodTasteModel.fromResultJson(jsonDecode(utf8.decode(response.bodyBytes))['data']);
      return model;
    } else {
      logger.v('음식 취향 불러오기 실패');
      return FoodTasteModel();
    }
  }

  Future<LodgingTasteModel> loadLodgingPreference(int userId) async {
    final response = await http.get(
      Uri.parse('${ApiUrl.releaseUrl}/user/${userId.toString()}/lodging-preference'),
      headers: {
        // 'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      logger.v('숙소 취향 불러오기 성공');
      LodgingTasteModel model = LodgingTasteModel.fromResultJson(jsonDecode(utf8.decode(response.bodyBytes))['data']);
      return model;
    } else {
      logger.v('숙소 취향 불러오기 실패');
      return LodgingTasteModel();
    }
  }

  Future<TravelTasteModel> loadTravelPreference(int userId) async {
    final response = await http.get(
      Uri.parse('${ApiUrl.releaseUrl}/user/${userId.toString()}/travel-preference'),
      headers: {
        // 'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      logger.v('여행 취향 불러오기 성공');
      TravelTasteModel model = TravelTasteModel.fromResultJson(jsonDecode(utf8.decode(response.bodyBytes))['data']);
      return model;
    } else {
      logger.v('여행 취향 불러오기 실패');
      return TravelTasteModel();
    }
  }
}

class FoodTasteModel {
  int? id;
  int? userId;
  String? type;
  int? food_price;
  String? title;
  String? content;
  String? food_like_memo;
  String? food_dislike_memo;
  List<int>? foods;
  List<int>? spicy_tastes;
  List<int>? sweet_tastes;
  List<int>? salty_tastes;

  /// load food taste
  String? foodLikeSummary;
  String? foodDislikeSummary;
  List<Food>? foodList = [];
  List<Taste>? spicy = [];
  List<Taste>? sweet = [];
  List<Taste>? salty = [];

  FoodTasteModel({
    this.id = -1,
    this.userId = -1,
    this.type = "",
    this.food_price,
    this.title,
    this.content,
    this.food_like_memo,
    this.food_dislike_memo,
    this.foodLikeSummary,
    this.foodDislikeSummary,
    this.foods,
    this.spicy_tastes,
    this.sweet_tastes,
    this.salty_tastes,
    this.spicy,
    this.sweet,
    this.salty,
  });

  FoodTasteModel.fromResultJson(dynamic json) {
    id = json['id'] ?? -1;
    userId = json['user'] ?? -1;
    type = json['type'] ?? '';
    // food_price = json['food_price'] ?? -1;
    // food_like_memo = json['like_memo'] ?? '';
    // food_dislike_memo = json['dislike_memo'] ?? '';
    // foodLikeSummary = json['like_summary'] ?? '';
    // foodDislikeSummary = json['dislike_summary'] ?? '';
    title = json['title'] ?? '';
    content = json['content'] ?? '';
    json['foods'] == [] || json['foods'] == null
        ? foodList = [] : json['foods'].forEach((v) {
          foodList!.add(Food.fromJson(v));
        }
    );
    json['spicy_tastes'] == [] || json['spicy_tastes'] == null
        ? spicy = [] : json['spicy_tastes'].forEach((v) {
      spicy!.add(Taste.fromJson(v));
    }
    );
    json['sweet_tastes'] == [] || json['sweet_tastes'] == null
        ? sweet = [] : json['sweet_tastes'].forEach((v) {
      sweet!.add(Taste.fromJson(v));
    }
    );
    json['salty_tastes'] == [] || json['salty_tastes'] == null
        ? salty = [] : json['salty_tastes'].forEach((v) {
      salty!.add(Taste.fromJson(v));
    }
    );
    // spicy = json['spicy_tastes'] != null ? List<Taste>.from(json['spicy_tastes']) : null;
    // sweet = json['sweet_tastes'] != null ? List<Taste>.from(json['sweet_tastes']) : null;
    // salty = json['salty_tastes'] != null ? List<Taste>.from(json['salty_tastes']) : null;
  }

  Map<String, dynamic> toJson() => {
    'price': food_price,
    'like_memo': food_like_memo,
    'dislike_memo': food_dislike_memo,
    'foods': foods,
    'spicy_tastes': spicy_tastes,
    'sweet_tastes': sweet_tastes,
    'salty_tastes': salty_tastes,
  };
}

class Food {
  int? id;
  String? title;

  Food({
    this.id,
    this.title,
  });

  Food.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    title = json['title'] ?? '';
  }
}

class Taste {
  int? id;
  String? title;
  String? type;

  Taste({
    this.id,
    this.title,
    this.type,
  });

  Taste.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    title = json['title'] ?? '';
    type = json['type'] ?? '';
  }
}

class LodgingTasteModel {
  int? id;
  int? userId;
  String? type;
  int? lodgingPrice;
  String? likeMemo;
  String? dislikeMemo;
  String? likeSummary;
  String? dislikeSummary;
  List<int>? types = [];
  List<int>? environments = [];
  List<int>? options = [];

  LodgingTasteModel({
    this.id = -1,
    this.userId = -1,
    this.type = "",
    this.lodgingPrice,
    this.likeMemo,
    this.dislikeMemo,
    this.likeSummary,
    this.dislikeSummary,
    this.types,
    this.environments,
    this.options,
  });

  LodgingTasteModel.fromResultJson(dynamic json) {
    id = json['id'] ?? -1;
    userId = json['user'] ?? -1;
    type = json['type'] ?? '';
    lodgingPrice = json['price'] ?? 0;
    likeMemo = json['like_memo'] ?? '';
    dislikeMemo = json['dislike_memo'] ?? '';
    likeSummary = json['like_summary'] ?? '';
    dislikeSummary = json['dislike_summary'] ?? '';
    json['types'] == [] || json['types'] == null
        ? types = [] : json['types'].forEach((v) {
      types!.add(v);
    });
    json['environments'] == [] || json['environments'] == null
        ? environments = [] : json['environments'].forEach((v) {
      environments!.add(v);
    });
    json['options'] == [] || json['options'] == null
        ? options = [] : json['options'].forEach((v) {
      options!.add(v);
    });
  }

  // Map<String, dynamic> toJson() => {
  //   'price': food_price,
  //   'like_memo': food_like_memo,
  //   'dislike_memo': food_dislike_memo,
  //   'foods': foods,
  //   'spicy_tastes': spicy_tastes,
  //   'sweet_tastes': sweet_tastes,
  //   'salty_tastes': salty_tastes,
  // };
}

class TravelTasteModel {
  int? id;
  int? userId;
  String? type;
  int? lodgingPrice;
  String? likeMemo;
  String? dislikeMemo;
  String? likeSummary;
  String? dislikeSummary;
  List<int>? distances = [];
  List<int>? environments = [];
  List<int>? mates = [];

  TravelTasteModel({
    this.id = -1,
    this.userId = -1,
    this.type = "",
    this.lodgingPrice,
    this.likeMemo,
    this.dislikeMemo,
    this.likeSummary,
    this.dislikeSummary,
    this.distances,
    this.environments,
    this.mates,
  });

  TravelTasteModel.fromResultJson(dynamic json) {
    id = json['id'] ?? -1;
    userId = json['user'] ?? -1;
    type = json['type'] ?? '';
    lodgingPrice = json['price'] ?? 0;
    likeMemo = json['like_memo'] ?? '';
    dislikeMemo = json['dislike_memo'] ?? '';
    likeSummary = json['like_summary'] ?? '';
    dislikeSummary = json['dislike_summary'] ?? '';
    json['distances'] == [] || json['distances'] == null
        ? distances = [] : json['distances'].forEach((v) {
      distances!.add(v);
    });
    json['environments'] == [] || json['environments'] == null
        ? environments = [] : json['environments'].forEach((v) {
      environments!.add(v);
    });
    json['mates'] == [] || json['mates'] == null
        ? mates = [] : json['mates'].forEach((v) {
      mates!.add(v);
    });
  }

// Map<String, dynamic> toJson() => {
//   'price': food_price,
//   'like_memo': food_like_memo,
//   'dislike_memo': food_dislike_memo,
//   'foods': foods,
//   'spicy_tastes': spicy_tastes,
//   'sweet_tastes': sweet_tastes,
//   'salty_tastes': salty_tastes,
// };
}