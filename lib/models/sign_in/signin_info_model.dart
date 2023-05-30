import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sense_flutter_application/models/sign_in/kakao_user_info_model.dart';

class SigninModel {
  static String? email;
  static String? password;
  static String? repeatPassword;
  static String? name;
  static String? birthday;
  static String? gender;
  static String? phone;

  Future<bool> signinRequest() async {

    Map<String, dynamic> signinJson = SigninRequestModel(
      email: SigninModel.email.toString(),
      password: SigninModel.password.toString(),
      name: SigninModel.name.toString(),
      birthday: SigninModel.birthday.toString(),
      gender: SigninModel.gender.toString(),
      phone: SigninModel.phone.toString(),
    ).toJson();

    print('access token ?? : ${KakaoUserInfoModel.userAccessToken!.accessToken}');

    final response = await http.patch(
      Uri.parse('https://dev.server.sense.runners.im/api/v1/user/signup'),
      body: signinJson,
      // headers: {'Content-Type': 'application/json; charset=UTF-8'
      headers: {
        'Authorization': 'Bearer ${KakaoUserInfoModel.userAccessToken!.idToken}'
        // 'Authorization': 'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJudWxsIjoiMzk2Y2VmZGY4MjkzNDkzMmI0OTE2MTk1OGUyNjQzMGQiLCJleHAiOjE2ODcxNjA5NzEsImlhdCI6MTY4NDU2ODk3MSwiYWNjb3VudF9pZCI6MjB9.VQlkE6WggLWR62xqmgzk4Y7DOHjO2dvgK6XDRZ2Nu05ZLiN-WuwokOdFw443-nWXF8mSjlfEkJ3YRgYWnAhnuMD0NFtc6H_p1eZg8wqBRhcT3P7Wz_itv7oS06WWfitbFqesir6s2daKVwmgA0xkc_U9t1RQKiHE1abdPbntpd4'
    });

    if(response.statusCode == 200 || response.statusCode == 201) {
      print('가입 성공했음');
      return true;
    } else {
      print(response.body);
      print('가입 실패했음');
      return false;
    }
  }
}

class SigninRequestModel {
  String? email;
  String? password;
  String? name;
  String? birthday;
  String? gender;
  String? phone;

  SigninRequestModel({
    this.email,
    this.password,
    this.name,
    this.birthday,
    this.gender,
    this.phone,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'name': name,
    'birthday': birthday,
    'gender': gender,
    'phone': phone,
  };
}