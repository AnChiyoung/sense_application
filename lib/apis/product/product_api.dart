import 'dart:convert';
import 'package:sense_flutter_application/service/api_service.dart';

class ProductApi {
  Future<Map<String, dynamic>> likeProduct(String productId) async {
    final response = await ApiService.post('product/$productId/like', {});
    var parse = json.decode(utf8.decode(response.bodyBytes));
    return parse;
  }

  Future<Map<String, dynamic>> unlikeProduct(String productId) async {
    final response = await ApiService.post('product/$productId/unlike', {});
    var parse = json.decode(utf8.decode(response.bodyBytes));
    return parse;
  }
}
