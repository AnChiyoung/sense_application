import 'package:http/http.dart' as http;
import 'package:sense_flutter_application/service/auth_service.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() {
    return _instance;
  }

  static const String baseUrl = 'https://server.dev.sens.im/api/v1/';
  // static const String authToken = 'YOUR_AUTH_TOKEN';
  static final Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  ApiService._internal();

  static Future<http.Response> post(String path, dynamic body) async {
    String authToken = await AuthService.getAccessToken() ?? '';
    if (authToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $authToken';
    }

    final url = Uri.parse('$baseUrl$path');

    final response = await http.post(url, headers: headers, body: body.isEmpty ? null : body);
    return response;
  }

  static Future<http.Response> get(String? path, {String? fullUrl}) async {
    String authToken = await AuthService.getAccessToken() ?? '';
    if (authToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $authToken';
    }
    final url = Uri.parse(fullUrl ?? '$baseUrl$path');
    final response = await http.get(url, headers: headers);
    return response;
  }

  static Future<http.Response> delete(String? path) async {
    String authToken = await AuthService.getAccessToken() ?? '';
    if (authToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $authToken';
    }
    final url = Uri.parse('$baseUrl$path');
    final response = await http.delete(url, headers: headers);
    return response;
  }
}
