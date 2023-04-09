import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResponseModel {
  final int code;
  final String message;
  final int count;
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
}
