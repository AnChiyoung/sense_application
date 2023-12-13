import 'dart:convert';

import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:http/http.dart' as http;
import 'package:sense_flutter_application/api/api_path.dart';

class SigninCheckModel {
  Future<AccessTokenResponseModel> tokenLoginRequest(OAuthToken token) async {
    Map<String, dynamic> tokenRequestBody =
        AccessTokenModel(accessToken: token.accessToken).toJson();

    final response = await http.post(
      Uri.parse('${ApiUrl.releaseUrl}/kakao/login'),
      body: jsonEncode(tokenRequestBody),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResult = jsonDecode(utf8.decode(response.bodyBytes))['data'];
      // print(jsonResult);
      print('kkkkk: $jsonResult');
      AccessTokenResponseModel joinTokenModel = AccessTokenResponseModel.fromJson(jsonResult);
      return joinTokenModel;
    } else {
      throw Exception;
    }
  }
}

class AccessTokenModel {
  String accessToken;

  AccessTokenModel({required this.accessToken});

  Map<String, dynamic> toJson() => {'access_token': accessToken};
}

class AccessTokenResponseModel {
  int? id;
  bool? isSignUp;
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

  AccessTokenResponseModel({
    this.id,
    this.isSignUp,
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

  AccessTokenResponseModel.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    isSignUp = json['is_signup'] ?? false;
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
