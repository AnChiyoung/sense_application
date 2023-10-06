import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/api_path.dart';
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
      FoodTasteModel model = FoodTasteModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes))['data']);
      return model;
    } else {
      logger.v('음식 취향 불러오기 실패');
      return FoodTasteModel();
    }
  }

  Future<bool> loadLodgingPreference(int userId) async {
    return false;
  }

  Future<bool> loadTravelPreference(int userId) async {
    return false;
  }

  // Future<List<BannerModel>> bannerRequest() async {
  //   final response = await http.get(
  //     Uri.parse('${ApiUrl.releaseUrl}/favors?type=FOOD'),
  //     headers: {
  //       'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
  //       'Content-Type': 'application/json; charset=UTF-8'
  //     },
  //   );
  //
  //   if(response.statusCode == 200 || response.statusCode == 201) {
  //     logger.v('음식 취향 불러오기 성공');
  //     List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes))['data'];
  //     List<BannerModel> bannerModels = body.map((e) => BannerModel.fromJson(e)).toList();
  //     return bannerModels;
  //   } else {
  //     logger.v('음식 취향 불러오기 실패');
  //     return [];
  //   }
  // }
}

class FoodTasteModel {
  int? id;
  int? userId;
  String? type;
  int? food_price;
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
    this.id,
    this.userId,
    this.type,
    this.food_price,
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

  FoodTasteModel.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    userId = json['user'] ?? -1;
    type = json['type'] ?? '';
    food_price = json['food_price'] ?? -1;
    food_like_memo = json['food_like_memo'] ?? '';
    food_dislike_memo = json['food_dislike_memo'] ?? '';
    foodLikeSummary = json['food_like_summary'] ?? '';

    foodDislikeSummary = json['food_dislike_summary'] ?? '';
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
    'food_price': food_price,
    'food_like_memo': food_like_memo,
    'food_dislike_memo': food_dislike_memo,
    'foods': foods,
    'spicy_tastes': spicy_tastes,
    'sweet_tastes': sweet_tastes,
    'salty_tastes': salty_tastes,
  };
}

// class BannerModel {
//   int? id;
//   String? title;
//   String? type;
//   String? created;
//
//   BannerModel({
//     this.id,
//     this.title,
//     this.type,
//     this.created,
//   });
//
//   BannerModel.fromJson(dynamic json) {
//     id = json['id'] ?? -1;
//     title = json['title'] ?? '';
//     type = json['type'] ?? '';
//     created = json['created'] ?? '';
//   }
// }

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