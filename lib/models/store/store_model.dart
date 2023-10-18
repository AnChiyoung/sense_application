import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sense_flutter_application/constants/api_path.dart';
import 'package:sense_flutter_application/constants/logger.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';

class StoreRequest {
  // 상품 모델 리스트 불러옴
  Future<List<ProductModel>> productListRequest(String searchTitle) async {

    String searchQuery = "";

    if(searchTitle.isEmpty) {
      searchQuery = "";
    } else {
      searchQuery = "?search=$searchTitle";
    }

    SenseLogger().debug('${ApiUrl.releaseUrl}/products$searchQuery');

    final response = await http.get(
      Uri.parse('${ApiUrl.releaseUrl}/products$searchQuery'),
      headers: {
        'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      SenseLogger().debug('상품 리스트 조회 성공');
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes))['data'];
      List<ProductModel> models = body.isEmpty || body == null ? [] : body.map((e) => ProductModel.fromJsonForList(e)).toList();;
      return models;
    } else {
      SenseLogger().error('상품 리스트 조회 실패');
      return [];
    }
  }

  // 상품 모델 불러옴
  Future<ProductModel> productRequest(int id) async {

    SenseLogger().debug('${ApiUrl.releaseUrl}/product/${id.toString()}');

    final response = await http.get(
      Uri.parse('${ApiUrl.releaseUrl}/product/${id.toString()}'),
      headers: {
        'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      SenseLogger().debug('상품 조회 성공');
      final jsonResult = jsonDecode(utf8.decode(response.bodyBytes))['data'];
      ProductModel model = ProductModel.fromJsonForPersonal(jsonResult);
      return model;
    } else {
      SenseLogger().error('상품 조회 실패');
      return ProductModel();
    }
  }
}

// 상품 모델
class ProductModel {
  int? id;
  String? imageUrl;
  String? brandTitle;
  String? title;
  String? originPrice;
  String? discountPrice;
  String? discountRate;
  int? reviewCount;
  bool? isLiked;

  ProductModel({
    this.id = -1,
    this.imageUrl = '',
    this.brandTitle = '',
    this.title = '',
    this.originPrice = '',
    this.discountPrice = '',
    this.discountRate = '',
    this.reviewCount = 0,
    this.isLiked = false,
  });

  ProductModel.fromJsonForList(dynamic json) {
    id = json["id"] ?? -1;
    imageUrl = json["image_url"] ?? '';
    brandTitle = json["brand_title"] ?? '';
    title = json["title"] ?? '';
    originPrice = json["origin_price"] ?? '';
    discountPrice = json["discount_price"] ?? '';
    discountRate = json["discount_rate"] ?? '';
  }

  ProductModel.fromJsonForPersonal(dynamic json) {
    id = json["id"] ?? -1;
    imageUrl = json["image_url"] ?? '';
    brandTitle = json["brand_title"] ?? '';
    title = json["title"] ?? '';
    originPrice = json["origin_price"] ?? '';
    discountPrice = json["discount_price"] ?? '';
    discountRate = json["discount_rate"] ?? '';
    reviewCount = json["review_count"] ?? 0;
    isLiked = json["is_liked"] ?? false;
  }
}