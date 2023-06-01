import 'dart:convert';

import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:http/http.dart' as http;

class SigninCheckModel {
  Future<AccessTokenResponseModel> tokenLoginRequest(OAuthToken token) async {
    Map<String, dynamic> tokenRequestBody = AccessTokenModel(accessToken: token.accessToken).toJson();

    final response = await http.post(
      Uri.parse('https://dev.server.sense.runners.im/api/v1/kakao/login'),
      body: jsonEncode(tokenRequestBody),
      headers: {'Content-Type': 'Snadfdfdfdfdfdfdfapplication/json; charset=UTF-8'},
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      final jsonResult = json.decode(response.body)['data'];
      AccessTokenResponseModel joinTokenModel = AccessTokenResponseModel.fromJson(jsonResult);
      return joinTokenModel;
    } else {
      throw Exception;
    }
  }
}

class AccessTokenModel {
  String accessToken;

  AccessTokenModel({
    required this.accessToken
  });

  Map<String, dynamic> toJson() => {
    'access_token': accessToken
  };
}

class AccessTokenResponseModel {
  int? id;
  bool? isSignUp;
  TokenModel? joinToken;
  // String? joinToken;

  AccessTokenResponseModel({
    this.id,
    this.isSignUp,
    this.joinToken,
  });

  AccessTokenResponseModel.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    isSignUp = json['is_signup'] ?? false;
    joinToken = TokenModel.fromJson(json['token']);
    // joinToken = json['token']['access_token'] ?? '';
  }
}

class TokenModel {
  String? refreshToken;
  String? accessToken;

  TokenModel({
    this.refreshToken,
    this.accessToken,
  });

  TokenModel.fromJson(dynamic json) {
    refreshToken = json['refresh_token'] ?? '';
    accessToken = json['access_token'] ?? '';
  }
}