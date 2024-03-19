import 'dart:convert';
import 'package:sense_flutter_application/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  Future<List<User>> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('https://server.dev.sens.im/user/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return compute(parseUser, response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  static List<User> parseUser(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }
}