import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:http/http.dart' as http;

class PresentUserInfo {
  static int id = 0;
  static String username = '';
  static String profileImage = '';
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
  String? profileImage;

  UserInfoModel({
    this.id,
    this.userName,
    this.profileImage,
  });

  UserInfoModel.fromJson(dynamic json) {
    id = json['id'] ?? '';
    userName = json['username'] ?? ('user-' + id.toString());
    profileImage = json['profile_image_url'] ?? '';
  }
}

class LoginRequest {

  static FlutterSecureStorage storage = FlutterSecureStorage();

  Future<int?> emailLoginReqeust(String email, String password) async {

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
      return userInfoModel.id;
    } else {
      return -1;
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