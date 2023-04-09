import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

///
///
///
/// 서버 리스폰트 모델
class ResponseModel {
  final int code;
  final String message;
  final int? count;
  final String? next;
  final String? previous;
  final dynamic data;

  ResponseModel.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        message = json['message'],
        count = json['count'],
        next = json['next'],
        previous = json['previous'],
        data = json['data'];
}

///
///
///
/// 유져 모델
class UserModel {
  final int id;
  final String username;
  final String? email;
  final String? phone;
  final String? kakaoNickname;
  final String? birthday;
  final String? imageProfileUrl;

  UserModel({
    required this.id,
    required this.username,
    this.email,
    this.phone,
    this.kakaoNickname,
    this.birthday,
    this.imageProfileUrl,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        email = json['email'],
        phone = json['phone'],
        kakaoNickname = json['kakao_nickname'],
        birthday = json['birthday'],
        imageProfileUrl = json['image_profile_url'];
}

///
///
///
/// 피드 태그 모델
class FeedTagModel {
  final int id;
  final String title;

  FeedTagModel({
    required this.id,
    required this.title,
  });

  FeedTagModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'];
}

///
///
///
/// 피드 포스트 썸네일 모델
class FeedPostModel {
  final int id;
  final String title;
  final int? tagId;
  final int? sectionId;
  final String imageUrl;

  FeedPostModel({
    required this.id,
    required this.title,
    required this.tagId,
    required this.sectionId,
    required this.imageUrl,
  });

  FeedPostModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        tagId = json['recommand_tag'],
        sectionId = json['recommand_section'],
        imageUrl = json['image_url'];
}

enum FeedProductType { GIFT, BOOKING }

///
///
///
/// 피드 상품 썸네일 모델
class FeedProductModel {
  final int id;
  final String title;
  // final String type = 'GIFT' | 'BOOKING';
  final FeedProductType type;
  final String? description;
  final int? originPrice;
  final int? salePrice;
  final String? imageUrl;
  final String? vendor;
  final String? address;
  final String? purchaseUrl;
  final String? created;

  FeedProductModel({
    required this.id,
    required this.title,
    required this.type,
    this.description,
    this.originPrice,
    this.salePrice,
    this.imageUrl,
    this.vendor,
    this.address,
    this.purchaseUrl,
    this.created,
  });

  FeedProductModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        type = json['type'] == 'GIFT' ? FeedProductType.GIFT : FeedProductType.BOOKING,
        description = json['description'],
        originPrice = json['origin_price'],
        salePrice = json['sale_price'],
        imageUrl = json['image_url'],
        vendor = json['vendor'],
        address = json['address'],
        purchaseUrl = json['purchase_url'],
        created = json['created'];
}

///
///
///
/// 피드 포스트 상세 모델
class FeedPostDetailModel {
  final int id;
  final int userId;
  // final UserModel? userData;
  // final String? title;
  // final String? originPrice;
  // final String? salePrice;
  // final String? startDate;
  // final String? endDate;
  // final String? bannerImageUrl;
  // final String? created;
  // final List<String>? tags;

  FeedPostDetailModel({
    required this.id,
    required this.userId,
    // this.userData,
    // this.title,
    // this.originPrice,
    // this.salePrice,
    // this.startDate,
    // this.endDate,
    // this.bannerImageUrl,
    // this.created,
    // this.tags,
  });

  FeedPostDetailModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user'];
  // userData = json['user_data'] != null ? UserModel.fromJson(json['user_data']) : null,
  // title = json['title'],
  // originPrice = json['origin_price'],
  // salePrice = json['sale_price'],
  // startDate = json['start_date'],
  // endDate = json['end_date'],
  // bannerImageUrl = json['banner_image_url'],
  // created = json['created'],
  // tags = json['tags'] != null ? List<String>.from(json['tags']) : null;
}

class ApiService {
  static const String baseUrl = "https://dev.server.sense.runners.im/api/v1";
  // static const String baseUrlWithoutHttps = "dev.server.sense.runners.im";
  // static const String today = "today";

  static Future<List<FeedPostModel>> getRecommendPostsByTagId(int tagId) async {
    debugPrint('API call getRecommendPostsByTagId');
    List<FeedPostModel> postInstances = [];

    final uri = Uri.parse('$baseUrl/recommands?recommand_tag=$tagId');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final responseBody = ResponseModel.fromJson(jsonDecode(response.body));
      final posts = responseBody.data;
      for (var post in posts) {
        final instance = FeedPostModel.fromJson(post);
        postInstances.add(instance);
      }
      return postInstances;
    }
    throw Error();
  }

  static Future<List<FeedTagModel>> getRecommendTags() async {
    debugPrint('API call getRecommendTags');
    List<FeedTagModel> tagInstances = [];
    final uri = Uri.parse('$baseUrl/recommand-tags');
    final headers = {'Content-Type': 'application/json; charset=UTF-8'}; // ???
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final responseBody = ResponseModel.fromJson(jsonDecode(response.body));
      final tags = responseBody.data;
      for (var tag in tags) {
        final instance = FeedTagModel.fromJson(tag);
        tagInstances.add(instance);
      }
      return tagInstances;
    }
    throw Error();
  }

  static Future<List<FeedPostModel>> getPosts(
      {String? searchTerm, String? tagTitle, String? ordering}) async {
    debugPrint('API call getPosts');

    List<FeedPostModel> postInstances = [];

    final Map<String, String> queryParams = {};
    if (searchTerm != null) {
      queryParams['search'] = searchTerm;
    }
    if (tagTitle != null) {
      queryParams['tag_title'] = tagTitle;
    }
    if (ordering != null) {
      queryParams['ordering'] = ordering;
    }

    String queryString = Uri(queryParameters: queryParams).query;
    final uri = Uri.parse('$baseUrl/posts?$queryString');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final responseBody = ResponseModel.fromJson(jsonDecode(response.body));
      final posts = responseBody.data;
      for (var post in posts) {
        final instance = FeedPostModel.fromJson(post);
        postInstances.add(instance);
      }
      return postInstances;
    }
    throw Error();
  }

  static Future<FeedPostDetailModel> getPostById(int postId) async {
    debugPrint('API call getPosts');

    FeedPostDetailModel post;

    // final uri = Uri.parse('$baseUrl/post/$postId');
    final uri = Uri.parse('$baseUrl/post/1');
    // debugPrint('uri: $uri');
    final response = await http.get(uri);
    // debugPrint('response: $response');
    // debugPrint('jsonDecode(response.body): ${jsonDecode(response.body)}');
    // debugPrint('jsonDecode(response.body)["data"]: ${jsonDecode(response.body)['data']}');

    if (response.statusCode == 200) {
      final responseBody = ResponseModel.fromJson(jsonDecode(response.body));
      // debugPrint('responseBody: $responseBody');
      // debugPrint('responseBody.data: ${responseBody.data}');
      post = FeedPostDetailModel.fromJson(responseBody.data);
      // debugPrint('post: $post');
      return post;
    }
    throw Error();
  }
}

// {
//   code: 200,
//   message: ok,
//   data: {
//     id: 1,
//     user: 1,
//     user_data: {
//       id: 1,
//       username: admin,
//       image_profile_url: null
//     },
//     title: Care social still stock blood true.,
//     origin_price: 85642.52,
//     sale_price: 83411.91,
//     start_date: 2023-04-02T17:54:26,
//     end_date: 2024-02-05T06:03:05,
//     banner_image_url: https://picsum.photos/600/600?random=813,
//     created: 2023-04-09T18:37:44.450573, 
//     tags: []
// }
