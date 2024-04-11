import 'dart:convert';
import 'package:sense_flutter_application/service/api_service.dart';

class CommentApi {
  Future<Map<String, dynamic>> like(String commentId) async {
    final response = await ApiService.get('comment/$commentId/like');
    var parse = json.decode(utf8.decode(response.bodyBytes));
    return parse;
  }
}
