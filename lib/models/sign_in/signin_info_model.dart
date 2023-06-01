import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sense_flutter_application/models/sign_in/kakao_user_info_model.dart';

class SigninModel {
  /// signin type => 0 : kakao, 1 : email, 2 : apple
  static int? signinType;
  static String? email;
  static String? password;
  static String? repeatPassword;
  static String? name;
  static String? birthday;
  static String? gender;
  static String? phone;

  Future<bool> kakaoSigninRequest() async {

    Map<String, dynamic> signinJson = SigninRequestModel(
      email: SigninModel.email.toString(),
      password: SigninModel.password.toString(),
      name: SigninModel.name.toString(),
      birthday: SigninModel.birthday.toString(),
      gender: SigninModel.gender.toString(),
      phone: SigninModel.phone.toString(),
    ).toJson();

    print(signinJson);

    print('sign in token : ${KakaoUserInfoModel.userAccessToken}');

    final response = await http.patch(
        Uri.parse('https://dev.server.sense.runners.im/api/v1/user/signup'),
        body: json.encode(signinJson),
        headers: {
          'Authorization': 'Bearer ${KakaoUserInfoModel.userAccessToken!}',
          'Content-Type': 'application/json; charset=UTF-8'
        });

    if(response.statusCode == 200 || response.statusCode == 201) {
      print('가입 성공했음');
      print(response.body);
      return true;
    } else {
      print(response.body);
      print('가입 실패했음');
      return false;
    }
  }

  Future<bool> emailSigninRequest() async {

    Map<String, dynamic> signinJson = SigninRequestModel(
      email: SigninModel.email.toString(),
      password: SigninModel.password.toString(),
      name: SigninModel.name.toString(),
      birthday: SigninModel.birthday.toString(),
      gender: SigninModel.gender.toString(),
      phone: SigninModel.phone.toString(),
    ).toJson();

    print(signinJson);

    final response = await http.post(
        Uri.parse('https://dev.server.sense.runners.im/api/v1/user/signup'),
        body: json.encode(signinJson),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8'
        });

    if(response.statusCode == 200 || response.statusCode == 201) {
      print('가입 성공했음');
      print(response.body);
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