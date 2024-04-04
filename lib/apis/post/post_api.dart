import 'dart:convert';
import 'package:http/http.dart' as http;

class PostApi {
  Future<Map<String, dynamic>> getPosts({String? url, String? filter}) async {
    final response = await http.get(
      Uri.parse(url ?? 'https://server.dev.sens.im/api/v1/posts?$filter'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var parse = json.decode(utf8.decode(response.bodyBytes));
    return parse;
  }
}
