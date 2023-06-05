import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:http/http.dart' as http;
import 'package:sense_flutter_application/models/sign_in/token_model.dart';

class PresentUserInfo {
  static int id = 0;
  static String username = '';
  static String profileImage = '';
  static String loginToken = '';
}

class UserInfoRequest {
  Future<UserInfoModel> userInfoRequest(int requestId) async {

    final response = await http.get(
      Uri.parse('https://dev.server.sense.runners.im/api/v1/user/' + requestId.toString()),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      final jsonResult = json.decode(response.body)['data'];
      UserInfoModel userInfoModel = UserInfoModel.fromJson(jsonResult);
      return userInfoModel;
    } else {
      throw Exception;
    }
  }
}

class UserInfoModel {
  int? id;
  String? userName;
  TokenModel? joinToken;

  String? email;
  String? phone;
  String? username;
  String? kakaoNickname;
  String? birthday;
  String? typeBirthday;
  String? typeGender;
  String? typeAgeRange;
  String? profileImageUrl;

  UserInfoModel({
    this.id,
    this.userName,
    this.joinToken,

    this.username,
    this.email,
    this.phone,
    this.kakaoNickname,
    this.birthday,
    this.typeBirthday,
    this.typeGender,
    this.typeAgeRange,
    this.profileImageUrl,
  });

  UserInfoModel.fromJson(dynamic json) {
    id = json['id'] ?? '';
    userName = json['username'] ?? ('user-' + id.toString());
    joinToken = TokenModel.fromJson(json['token']);

    username = json['username'] ?? '';
    email = json['email'] ?? '';
    phone = json['phone'] ?? '';
    kakaoNickname = json['kakao_nickname'] ?? '';
    birthday = json['birthday'] ?? '';
    typeBirthday = json['birthday_type'] ?? '';
    typeGender = json['gender_type'] ?? '';
    typeAgeRange = json['age_range_type'] ?? '';
    profileImageUrl = json['profile_image_url'] ?? '';
  }
}

class LoginRequest {

  static FlutterSecureStorage storage = FlutterSecureStorage();

  Future<UserInfoModel?> emailLoginReqeust(String email, String password) async {

    // dynamic emptyModel = {'id': -1, 'username': '', 'profile_image_url': ''};

    Map<String, dynamic> loginBody = LoginRequestModel(id: email, password: password).toJson();

    final response = await http.post(
      Uri.parse('https://dev.server.sense.runners.im/api/v1/user/login'),
      body: jsonEncode(loginBody),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      final jsonResult = json.decode(response.body)['data'];
      UserInfoModel userInfoModel = UserInfoModel.fromJson(jsonResult);
      return userInfoModel;
    } else {
      return null;
    }
  }
}

class LoginRequestModel {
  String? id;
  String? password;

  LoginRequestModel({
    this.id,
    this.password,
  });

  Map<String, dynamic> toJson() => {
    'email': id,
    'password': password,
  };
}