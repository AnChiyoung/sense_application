import 'dart:convert';

import 'package:http/http.dart' as http;

// class User {
//   final int id;
//   final String name;
//   final String email;

//   User({required this.id, required this.name, required this.email});

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       name: json['name'],
//       email: json['email'],
//     );
//   }
// }

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

class FeedProductModel {
  final int id;
  final String title;
  final int? tagId;
  final int? sectionId;
  final String imageUrl;

  FeedProductModel({
    required this.id,
    required this.title,
    required this.tagId,
    required this.sectionId,
    required this.imageUrl,
  });

  FeedProductModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        tagId = json['recommand_tag'],
        sectionId = json['recommand_section'],
        imageUrl = json['image_url'];
}

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

class ApiService {
  static const String baseUrl = "https://dev.server.sense.runners.im/api/v1";
  static const String baseUrlWithoutHttps = "dev.server.sense.runners.im";
  static const String today = "today";

  static Future<List<FeedProductModel>> getRecommendProductsByTagId(
      int tagId) async {
    List<FeedProductModel> productInstances = [];

    // final url = Uri.https(baseUrlWithoutHttps, 'recommands', {'recommand_tag': tagId});
    final url = Uri.parse('$baseUrl/recommands?recommand_tag=$tagId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseBody = ResponseModel.fromJson(jsonDecode(response.body));
      final products = responseBody.data;
      for (var product in products) {
        final instance = FeedProductModel.fromJson(product);
        productInstances.add(instance);
      }
      return productInstances;
    }
    throw Error();
  }

  static Future<List<FeedTagModel>> getRecommendTags() async {
    List<FeedTagModel> tagInstances = [];
    final url = Uri.parse('$baseUrl/recommand-tags');
    final headers = {'Content-Type': 'application/json; charset=UTF-8'};
    final response = await http.get(url, headers: headers);

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
}