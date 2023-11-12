import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/api_path.dart';
import 'package:sense_flutter_application/constants/logger.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/views/event_info/recommend_request/recommend_request_provider.dart';

class RecommendRequest {
  Future<bool> eventRecommendRequest(BuildContext context, int eventId) async {

    Map<String, dynamic> createModel = {};
    createModel.clear();

    createModel['memo'] = context.read<RecommendRequestProvider>().recommendMemo;

    bool present = context.read<RecommendRequestProvider>().recommendCategory.elementAt(0);
    bool hotel = context.read<RecommendRequestProvider>().recommendCategory.elementAt(1);
    bool lunch = context.read<RecommendRequestProvider>().recommendCategory.elementAt(2);
    bool dinner = context.read<RecommendRequestProvider>().recommendCategory.elementAt(3);
    bool activity = context.read<RecommendRequestProvider>().recommendCategory.elementAt(4);
    bool pub = context.read<RecommendRequestProvider>().recommendCategory.elementAt(5);
    createModel['is_present'] = present;
    createModel['is_hotel'] = hotel;
    createModel['is_lunch'] = lunch;
    createModel['is_dinner'] = dinner;
    createModel['is_activity'] = activity;
    createModel['is_pub'] = pub;

    int i = 0;
    if(present == true) {
      createModel['present_budget'] = context.read<RecommendRequestProvider>().costs.elementAt(
        i
      );
      i++;
    } else {
      createModel['present_budget'] = 0;
    }

    if(hotel == true) {
      createModel['hotel_budget'] = context.read<RecommendRequestProvider>().costs.elementAt(
          i
      );
      i++;
    } else {
      createModel['hotel_budget'] = 0;
    }

    if(lunch == true) {
      createModel['lunch_budget'] = context.read<RecommendRequestProvider>().costs.elementAt(
          i
      );
      i++;
    } else {
      createModel['lunch_budget'] = 0;
    }

    if(dinner == true) {
      createModel['dinner_budget'] = context.read<RecommendRequestProvider>().costs.elementAt(
          i
      );
      i++;
    } else {
      createModel['dinner_budget'] = 0;
    }

    if(activity == true) {
      createModel['activity_budget'] = context.read<RecommendRequestProvider>().costs.elementAt(
          i
      );
      i++;
    } else {
      createModel['activity_budget'] = 0;
    }

    if(pub == true) {
      createModel['pub_budget'] = context.read<RecommendRequestProvider>().costs.elementAt(
          i
      );
      i++;
    } else {
      createModel['pub_budget'] = 0;
    }

    SenseLogger().debug('recommend request create model : $createModel');

    final response = await http.post(
        Uri.parse('${ApiUrl.releaseUrl}/event/${eventId.toString()}/recommend-request'),
        body: jsonEncode(createModel),
        headers: {
          'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
          'Content-Type': 'application/json; charset=UTF-8'
        }
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      SenseLogger().debug('이벤트 추천 요청 success');
      return true;
    } else {
      SenseLogger().debug('이벤트 추천 요청 fail');
      return false;
    }
  }
}