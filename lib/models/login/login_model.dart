import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:sense_flutter_application/constants/api_path.dart';
import 'package:sense_flutter_application/models/sign_in/token_model.dart';

class PresentUserInfo {
  static int id = 0;
  static String username = '';
  static String profileImage = '';
  // @deprecated 예정
  static String loginToken = '';
}

class UserInfoRequest {
  /// logger setting
  var logger = Logger(
    printer: PrettyPrinter(
      lineLength: 120,
      colors: true,
      printTime: true,
    ),
  );

  /// user info request
  Future<UserInfoModel> userInfoRequest(int requestId) async {
    // logger.d('preloading api relese url : ${ApiUrl.releaseUrl}');

    final response = await http.get(
      Uri.parse('${ApiUrl.releaseUrl}/$requestId'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
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
  String? username;
  TokenModel? joinToken;

  String? email;
  String? phone;
  String? kakaoNickname;
  String? birthday;
  String? typeBirthday;
  String? typeGender;
  String? typeAgeRange;
  String? profileImageUrl;

  UserInfoModel({
    this.id,
    this.username,
    this.joinToken,
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
    username = json['username'] ?? ('user-$id');
    joinToken = TokenModel.fromJson(json['token']);
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
  /// logger setting
  var logger = Logger(
    printer: PrettyPrinter(
      lineLength: 120,
      colors: true,
      printTime: true,
    ),
  );

  /// auto login resource
  static FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<UserInfoModel?> emailLoginRequest(String email, String password) async {
    logger.d('preloading api relese url : ${ApiUrl.releaseUrl}');

    Map<String, dynamic> loginBody = LoginRequestModel(id: email, password: password).toJson();

    final response = await http.post(
      Uri.parse('${ApiUrl.releaseUrl}/user/login'),
      body: jsonEncode(loginBody),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResult = json.decode(response.body)['data'];

      print("nnnnnnnnnn: $jsonResult");
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
