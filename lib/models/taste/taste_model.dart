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

    print(foodPrefer);

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
}

class FoodTasteModel {
  int? food_price;
  String? food_like_memo;
  String? food_dislike_memo;
  List<int>? foods;
  List<int>? spicy_tastes;
  List<int>? sweet_tastes;
  List<int>? salty_tastes;

  FoodTasteModel({
    this.food_price,
    this.food_like_memo,
    this.food_dislike_memo,
    this.foods,
    this.spicy_tastes,
    this.sweet_tastes,
    this.salty_tastes,
  });

  FoodTasteModel.fromJson(dynamic json) {
    food_price = json['food_price'] ?? -1;
    food_like_memo = json['food_like_memo'] ?? '';
    food_dislike_memo = json['food_dislike_memo'] ?? '';
    foods = json['foods'] != null ? List<int>.from(json['foods']) : null;
    spicy_tastes = json['spicy_tastes'] != null ? List<int>.from(json['spicy_tastes']) : null;
    sweet_tastes = json['sweet_tastes'] != null ? List<int>.from(json['sweet_tastes']) : null;
    salty_tastes = json['salty_tastes'] != null ? List<int>.from(json['salty_tastes']) : null;
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