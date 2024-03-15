import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sense_flutter_application/models/user.dart';

class AuthApi {
  Future<Map<String, dynamic>> checkEmail(String email) async {
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
      return { 'status': true };
    } else {
      var parse = json.decode(utf8.decode(response.bodyBytes));
      var nonFieldError = parse['errors']['non_field_errors'];
      print(nonFieldError);
      return {'status': false, 'message': nonFieldError?.isNotEmpty ? nonFieldError[0] : parse['message'] };
    }
  }

  Future<Map<String, dynamic>> sendCode(String phone) async {
    final response = await http.post(
      Uri.parse('https://server.dev.sens.im/api/v1/user/phone/send'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phone': phone.replaceAll(RegExp(r'[^0-9]'), ''),
      }),
    );


      var parse = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      return parse;
    } else {
      var nonFieldError = parse['errors']['non_field_errors'];
      print(nonFieldError);
      return { 'code': response.statusCode, 'status': false, 'message': nonFieldError?.isNotEmpty ? nonFieldError[0] : parse['message'] };
    }
  }

  Future<Map<String, dynamic>> verifyCode(String phone, String code) async {
    final response = await http.post(
      Uri.parse('https://server.dev.sens.im/api/v1/user/phone/auth'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'phone': phone.replaceAll(RegExp(r'[^0-9]'), ''),
        'code': int.parse(code),
      }),
    );

    var parse = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      return parse;
    } else {
      var nonFieldError = parse['errors']['non_field_errors'];
      return { 'code': response.statusCode, 'status': false, 'message': nonFieldError?.isNotEmpty ? nonFieldError[0] : parse['message'] };
    }
  }

  Future<Map<String, dynamic>> register(User payload) async {
    final response = await http.post(
      Uri.parse('https://server.dev.sens.im/api/v1/user/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': payload.email,
        'password': payload.password,
        'birthday': payload.birthday,
        'gender': payload.gender,
        'phone': payload.phone,
      }),
    );

    var parse = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      return parse;
    } else {
      var nonFieldError = parse['errors']['non_field_errors'];
      return { 'code': response.statusCode, 'status': false, 'message': nonFieldError?.isNotEmpty ? nonFieldError[0] : parse['message'] };
    }
  }

  Future loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('https://server.dev.sens.im/api/v1/user/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email,
        'password': password,
      }),
    );

    var parse = json.decode(utf8.decode(response.bodyBytes));

    return parse;
  }
}