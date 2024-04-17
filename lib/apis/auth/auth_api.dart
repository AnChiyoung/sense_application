import 'dart:convert';
import 'package:sense_flutter_application/service/api_service.dart';
import 'package:sense_flutter_application/models/user.dart';

class AuthApi {
  Future<Map<String, dynamic>> checkEmail(String email) async {
    final response = await ApiService.post(
      'user/email/check',
      jsonEncode(<String, String>{
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      return {'status': true};
    } else {
      var parse = json.decode(utf8.decode(response.bodyBytes));
      var nonFieldError = parse['errors']['non_field_errors'];
      return {
        'status': false,
        'message': nonFieldError?.isNotEmpty ? nonFieldError[0] : parse['message']
      };
    }
  }

  Future<Map<String, dynamic>> sendCode(String phone) async {
    final response = await ApiService.post(
      'user/phone/send',
      jsonEncode(<String, String>{
        'phone': phone.replaceAll(RegExp(r'[^0-9]'), ''),
      }),
    );

    var parse = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      return parse;
    } else {
      var nonFieldError = parse['errors']['non_field_errors'];
      return {
        'code': response.statusCode,
        'status': false,
        'message': nonFieldError?.isNotEmpty ? nonFieldError[0] : parse['message']
      };
    }
  }

  Future<Map<String, dynamic>> verifyCode(String phone, String code) async {
    final response = await ApiService.post(
      'user/phone/auth',
      jsonEncode(<String, dynamic>{
        'phone': phone.replaceAll(RegExp(r'[^0-9]'), ''),
        'code': int.parse(code),
      }),
    );

    var parse = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      return parse;
    } else {
      var nonFieldError = parse['errors']['non_field_errors'];
      return {
        'code': response.statusCode,
        'status': false,
        'message': nonFieldError?.isNotEmpty ? nonFieldError[0] : parse['message']
      };
    }
  }

  Future<Map<String, dynamic>> register(User payload) async {
    final response = await ApiService.post(
      'user/signup',
      jsonEncode(<String, dynamic>{
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
      return {
        'code': response.statusCode,
        'status': false,
        'message': nonFieldError?.isNotEmpty ? nonFieldError[0] : parse['message']
      };
    }
  }

  Future loginUser(String email, String password) async {
    final response = await ApiService.post(
      'user/login',
      jsonEncode(<String, dynamic>{
        'email': email,
        'password': password,
      }),
    );

    var parse = json.decode(utf8.decode(response.bodyBytes));

    return parse;
  }

  Future loginWithKakao(String accessToken) async {
    final response = await ApiService.post(
      'kakao/login',
      jsonEncode(<String, dynamic>{
        'access_token': accessToken,
      }),
    );

    var parse = json.decode(utf8.decode(response.bodyBytes));

    return parse;
  }

  Future me() async {
    final response = await ApiService.get('user/me');

    var parse = json.decode(utf8.decode(response.bodyBytes));

    return parse;
  }
}
