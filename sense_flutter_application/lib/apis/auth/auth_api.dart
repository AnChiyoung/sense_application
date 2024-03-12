import 'dart:convert';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class AuthApi {
  Future<Map<String, dynamic>> checkEmail(String email) async {
    print('CHECK EMAIL FUNCTION $email');
    final response = await http.post(
      Uri.parse('https://server.dev.sens.im/api/v1/user/email/check'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      print("STATUS CODE 200");
      return { 'status': true };
    } else {
      print("STATUS CODE 400 - Email is already taken");
      return {'status': false, 'message': '중복 이메일 이에요'};
    }
  }

}