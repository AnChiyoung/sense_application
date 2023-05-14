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
  static int? authCode;

  Future<bool> signinRequest(String authCode) async {

    Map<String, dynamic> signinJson = SigninRequestModel(
      email: SigninModel.email.toString(),
      password: SigninModel.password.toString(),
      name: SigninModel.name.toString(),
      birthday: SigninModel.birthday.toString(),
      gender: SigninModel.gender.toString(),
      phone: SigninModel.phone.toString(),
      authCode: int.parse(authCode),
    ).toJson();

    print(signinJson);

    final response = await http.post(
      Uri.parse('https://dev.server.sense.runners.im/api/v1/user/phone/send'),
      body: json.encode(signinJson),
      headers: {'Content-Type': 'application/json; charset=UTF-8'
      // headers: {
      //   'Authorization': 'Bearer ${KakaoUserInfoModel.userAccessToken!.accessToken}'
    });

    if(response.statusCode == 200 || response.statusCode == 201) {
      print('가입 성공했음');
      return true;
    } else {
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
  int? authCode;

  SigninRequestModel({
    this.email,
    this.password,
    this.name,
    this.birthday,
    this.gender,
    this.phone,
    this.authCode,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'name': name,
    'birthday': birthday,
    'gender': gender,
    'phone': phone,
    'code': authCode,
  };
}