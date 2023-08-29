import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:sense_flutter_application/constants/api_path.dart';
import 'package:sense_flutter_application/models/feed/feed_detail_model.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';

class FeedRequest {
  Future<List<FeedPreviewModel>> feedPreviewRequestByLabelId(int labelId) async {
    print('select label id: ${labelId.toString()}');
    String query;
    labelId == -1 ? query = '' : query = '?label_id=${labelId.toString()}';
    final response = await http.get(
      Uri.parse('${ApiUrl.releaseUrl}/posts$query'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes))['data'];
      List<FeedPreviewModel> modelList = body.map((e) => FeedPreviewModel.fromJson(e)).toList();
      print(modelList);
      return modelList;
    } else {
      return [];
    }
  }

  Future<FeedDetailModel> postDetailLiked(int postId) async {
    final response = await http.post(
      Uri.parse('${ApiUrl.releaseUrl}/post/${postId.toString()}/like'),
      headers: {
        'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
        'Content-Type': 'application/json; charset=UTF-8'},
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      print('post detail like button call success');
      final jsonResult = jsonDecode(utf8.decode(response.bodyBytes))['data'];
      /// logger setting
      var logger = Logger(
        printer: PrettyPrinter(
          lineLength: 120,
          colors: true,
          printTime: true,
        ),
      );
      logger.d(jsonResult);
      FeedDetailModel feedDetailModel = FeedDetailModel.fromJson(jsonResult);
      return feedDetailModel;
    } else {
      print('post detail like button call fail');
      throw Exception;
    }
  }

  Future<FeedDetailModel> postDetailUnliked(int postId) async {
    final response = await http.post(
      Uri.parse('${ApiUrl.releaseUrl}/post/${postId.toString()}/unlike'),
      headers: {
        'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
        'Content-Type': 'application/json; charset=UTF-8'},
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      print('post detail like button call success');
      final jsonResult = jsonDecode(utf8.decode(response.bodyBytes))['data'];
      /// logger setting
      var logger = Logger(
        printer: PrettyPrinter(
          lineLength: 120,
          colors: true,
          printTime: true,
        ),
      );
      logger.d(jsonResult);
      FeedDetailModel feedDetailModel = FeedDetailModel.fromJson(jsonResult);
      return feedDetailModel;
    } else {
      print('post detail like button call fail');
      throw Exception;
    }
  }
}

class FeedPreviewModel {
  int? id;
  String? thumbnailUrl;
  String? title;
  String? subTitle;
  String? startDate;
  String? endDate;
  bool? isLiked;

  FeedPreviewModel({
    this.id,
    this.thumbnailUrl,
    this.title,
    this.subTitle,
    this.startDate,
    this.endDate,
    this.isLiked,
  });

  FeedPreviewModel.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    thumbnailUrl = json['thumbnail_media_url'] ?? '';
    title = json['title'] ?? '';
    subTitle = json['sub_title'] ?? '';
    startDate = json['start_date'] ?? '';
    endDate = json['end_date'] ?? '';
    isLiked = json['is_liked'] ?? false;
  }
}

class LikedRequest {
  Future<bool> likedRequest(int postId) async {
    final response = await http.post(
      Uri.parse('${ApiUrl.releaseUrl}/kakao/login/15/like'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> unlikedRequest(int postId) async {
    final response = await http.post(
      Uri.parse('${ApiUrl.releaseUrl}/kakao/login/15/unlike'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}

class LikedModel {
  bool? isLiked;

  LikedModel({
    this.isLiked,
  });


}

///
///
/// 서버 리스폰스 모델
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
/// 피드 포스트 썸네일 모델
class FeedPostModel {
  final int id;
  final String title;
  final String imageUrl;

  FeedPostModel({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  FeedPostModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        imageUrl = json['image_url'];
}

///
///
/// 피드 상품 썸네일 모델
class FeedProductModel {
  final int id;
  final String title;
  // final String type = 'GIFT' | 'BOOKING';
  final FeedProductType? type;
  final String? description;
  final int? originPrice;
  final int? salePrice;
  final String? imageUrl;
  final String? vendor;
  final String? address;
  final String? purchaseUrl;
  final String? created;
  final String? storeName;
  bool? isLiked = false;

  FeedProductModel({
    required this.id,
    required this.title,
    this.type,
    this.description,
    this.originPrice,
    this.salePrice,
    this.imageUrl,
    this.vendor,
    this.address,
    this.purchaseUrl,
    this.created,
    this.storeName,
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
        created = json['created'],
        storeName = json['store_name'];

  void toggleLike() {
    isLiked = !isLiked!;
  }
}

enum FeedProductType { GIFT, BOOKING }

///
///
/// 피드 포스트 상세 모델
class FeedPostDetailModel {
  final int id;
  final int? userId;
  final UserModel? userData;
  final String? title;
  final String? originPrice;
  final String? salePrice;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? bannerImageUrl;
  final DateTime? created;
  final List<String>? tags;
  final bool? isLiked;

  FeedPostDetailModel({
    required this.id,
    this.userId,
    this.userData,
    this.title,
    this.originPrice,
    this.salePrice,
    this.startDate,
    this.endDate,
    this.bannerImageUrl,
    this.created,
    this.tags,
    this.isLiked,
  });

  FeedPostDetailModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user'],
        userData = json['user_data'] != null ? UserModel.fromJson(json['user_data']) : null,
        title = json['title'],
        originPrice = json['origin_price'],
        salePrice = json['sale_price'],
        startDate = json['start_date'] != null ? DateTime.parse(json['start_date']) : null,
        endDate = json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
        bannerImageUrl = json['banner_image_url'],
        created = json['created'] != null ? DateTime.parse(json['created']) : null,
        tags = json['tags'] != null ? List<String>.from(json['tags']) : null,
        isLiked = json['is_liked'];
}

///
///
/// 피드 상품 상세 컨텐트 프로덕트 모델
class FeedPostDetailStoreContentData {
  final String title;
  final String storeName;
  final String price;
  final String imageUrl;
  bool isLiked;

  FeedPostDetailStoreContentData({
    required this.title,
    required this.storeName,
    required this.price,
    required this.imageUrl,
    this.isLiked = false,
  });

  // FeedPostDetailStoreContentData.fromJson(Map<String, dynamic> json)
  //     : title = json['title'],
  //       storeName = json['store_name'],
  //       price = json['price'],
  //       imageUrl = json['image_url'];

  void toggleLike() {
    isLiked = !isLiked;
  }
}

///
///
/// 피드 상품 상세에서 관련 게시글 썸네일 모델
class FeedRelatedPostThumbnailModel {
  final String title;
  final String storeName;
  final String imageUrl;

  FeedRelatedPostThumbnailModel({
    required this.title,
    required this.storeName,
    required this.imageUrl,
  });

  // FeedRelatedPostThumbnailModel.fromJson(Map<String, dynamic> json)
  //     : title = json['title'],
  //       storeName = json['store_name'],
  //       imageUrl = json['image_url'];
}

class ApiService {
  static const String baseUrl = "https://www.dev.server.sens.im/api/v1";
  // static const String baseUrlWithoutHttps = "dev.server.sense.runners.im";
  // static const String today = "today";

  static Future<List<FeedPostModel>> getRecommendPostsByTagId(int tagId) async {
    debugPrint('API call getRecommendPostsByTagId');
    List<FeedPostModel> postInstances = [];

    // final uri = Uri.parse('$baseUrl/recommands?recommand_tag=$tagId');
    final uri = Uri.parse('${ApiUrl.releaseUrl}/posts?label_id=$tagId');
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
    // final uri = Uri.parse('$baseUrl/recommand-tags');
    final uri = Uri.parse('${ApiUrl.releaseUrl}/labels');
    final headers = {'Content-Type': 'application/json; charset=UTF-8'}; // ???
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      print('success');
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

// FeedPostDetailModel
  static Future<List<FeedPostDetailModel>> getPosts(
      {String? searchTerm, String? tagTitle, String? ordering}) async {
    debugPrint('API call getPosts');

    List<FeedPostDetailModel> postInstances = [];

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
    final uri = Uri.parse('${ApiUrl.devUrl}posts?$queryString');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final responseBody = ResponseModel.fromJson(jsonDecode(response.body));
      final posts = responseBody.data;
      for (var post in posts) {
        final instance = FeedPostDetailModel.fromJson(post);
        postInstances.add(instance);
      }
      return postInstances;
    }
    throw Error();
  }

  static Future<FeedPostDetailModel> getPostById(int postId) async {
    debugPrint('API call getPostById');

    FeedPostDetailModel post;

    // 임시
    int tempId = 1;
    if (postId > 0 && postId < 11) {
      tempId = postId;
    }
    final uri = Uri.parse('${ApiUrl.releaseUrl}/post/$tempId');
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
