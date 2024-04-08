import 'dart:convert';
import 'package:sense_flutter_application/service/api_service.dart';

class PostApi {
  Future<Map<String, dynamic>> getPosts({String? url, String? filter}) async {
    final response = await ApiService.get('posts?${filter ?? ''}', fullUrl: url);
    var parse = json.decode(utf8.decode(response.bodyBytes));
    return parse;
  }

  Future<Map<String, dynamic>> getPost(String id) async {
    final response = await ApiService.get('post/$id');
    var parse = json.decode(utf8.decode(response.bodyBytes));
    return parse;
  }

  Future<Map<String, dynamic>> getPostComments(String id) async {
    final response = await ApiService.get('post/$id/comments');
    var parse = json.decode(utf8.decode(response.bodyBytes));
    return parse;
  }
}
