import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/api_path.dart';
import 'package:sense_flutter_application/constants/logger.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';

/// 이벤트에서 요청된 추천에 대한 추천글들
class EventFeedRecommendModel {
  int? id;
  int? eventId;
  int? eventRecommendRequest;
  RecommendUser? recommendUser;
  // ProductModel? products;
  String? contentDescription;
  int? likeCount;
  bool? isLiked;
  String? created;
  String? modified;

  EventFeedRecommendModel({
    this.id = -1,
    this.eventId = -1,
    this.eventRecommendRequest = -1,
    this.recommendUser,
    // this.products,
    this.contentDescription = '',
    this.likeCount = -1,
    this.isLiked = false,
    this.created = '',
    this.modified = '',
  });

  EventFeedRecommendModel.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    eventId = json['event'] ?? -1;
    eventRecommendRequest = json['event_recommend_request'] ?? -1;
    recommendUser = RecommendUser.fromJson(json['user']);
    // products;
    contentDescription = json['content'] ?? '';
    likeCount = json['like_count'] ?? -1;
    isLiked = json['is_liked'] ?? false;
    created = json['created'] ?? '';
    modified = json['modified'] ?? '';
  }
}

class RecommendUser {
  int? id;
  String? name;
  String? email;
  String? username;
  String? profileImageUrl;

  RecommendUser({
    this.id = -1,
    this.name = '',
    this.email = '',
    this.username = '',
    this.profileImageUrl = '',
  });

  RecommendUser.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    username = json['username'] ?? '';
    profileImageUrl = json['profile_image_url'] ?? '';
  }
}

class RecommendsRequest {
  Future<List<EventFeedRecommendModel>> eventFeedDetailRecommends(int eventId, String ordering) async {
    final response = await http.get(
      Uri.parse('${ApiUrl.releaseUrl}/event/${eventId.toString()}/recommends?ordering=$ordering'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes))['data'];
      List<EventFeedRecommendModel> list = body.map((e) => EventFeedRecommendModel.fromJson(e)).toList();
      return list;
    } else {
      throw Exception;
    }
  }

  Future<bool> eventFeedRecommendComment(int eventId, BuildContext context) async {

    Map<String, dynamic> contentModel = {};
    contentModel.clear();
    // contentModel['content'] = context.read<CreateEventImproveProvider>().recommendCommentString;

    final response = await http.post(
      Uri.parse('${ApiUrl.releaseUrl}/event/${eventId.toString()}/recommend'),
      body: jsonEncode(contentModel),
      headers: {
        'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      SenseLogger().debug('추천 생성 성공');
      return true;
    } else {
      SenseLogger().error('추천 생성 실패');
      return false;
    }
  }

  Future<bool> deleteReCommendComment(int eventId) async {

    final response = await http.delete(
      Uri.parse('${ApiUrl.releaseUrl}/event-recommend/${eventId.toString()}'),
      headers: {
        'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if(response.statusCode == 204) {
      SenseLogger().debug('추천 삭제 성공');
      return true;
    } else {
      SenseLogger().error('추천 삭제 실패');
      return false;
    }
  }
}