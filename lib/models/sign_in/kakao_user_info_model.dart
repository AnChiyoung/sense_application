import 'dart:convert';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:sense_flutter_application/models/sign_in/signin_info_model.dart';

class KakaoUserInfoModel {
  static KakaoUserModel? presetInfo;
  static String? userAccessToken;

  Future<KakaoUserModel> getUserInfo(OAuthToken token) async {
    final response = await http.get(
        Uri.parse('https://kapi.kakao.com/v2/user/me'),
        headers: {
          'Authorization': 'Bearer ${token.accessToken}'
    });
    final userInfo = json.decode(response.body)['kakao_account'];
    var logger = Logger(
      printer: PrettyPrinter(
        lineLength: 120,
        colors: true,
        printTime: true,
      ),
    );
    logger.d(userInfo);
    KakaoUserModel returnModel = KakaoUserModel.fromJson(userInfo);
    /// static variable temperature save
    presetInfo = returnModel;
    SigninModel.email = presetInfo!.email;

    return returnModel;
  }
}

class KakaoUserModel {
  bool? profileNicknameNeedsAgreement;
  bool? profileImageNeedsAgreement;
  Profile? profile;
  bool? hasEmail;
  bool? emailNeedsAgreement;
  bool? isEmailValid;
  bool? isEmailVerified;
  String? email;
  bool? hasAgeRange;
  bool? ageRangeNeedsAgreement;
  String? ageRange;
  bool? hasBirthday;
  bool? birthdayNeedsAgreement;
  String? birthday;
  String? birthdayType;
  bool? hasGender;
  bool? genderNeedsAgreement;
  String? gender;

  KakaoUserModel({
    this.profileNicknameNeedsAgreement,
    this.profileImageNeedsAgreement,
    this.profile,
    this.hasEmail,
    this.emailNeedsAgreement,
    this.isEmailValid,
    this.isEmailVerified,
    this.email,
    this.hasAgeRange,
    this.ageRangeNeedsAgreement,
    this.ageRange,
    this.hasBirthday,
    this.birthdayNeedsAgreement,
    this.birthday,
    this.birthdayType,
    this.hasGender,
    this.genderNeedsAgreement,
    this.gender});

  KakaoUserModel.fromJson(Map<String, dynamic> json) {
    profileNicknameNeedsAgreement = json['profile_nickname_needs_agreement'];
    profileImageNeedsAgreement = json['profile_image_needs_agreement'];
    profile = json['profile'] != null ? Profile.fromJson(json['profile']) : null;
    hasEmail = json['has_email'];
    emailNeedsAgreement = json['email_needs_agreement'];
    isEmailValid = json['is_email_valid'];
    isEmailVerified = json['is_email_verified'];
    email = json['email'];
    hasAgeRange = json['has_age_range'];
    ageRangeNeedsAgreement = json['age_range_needs_agreement'];
    ageRange = json['age_range'];
    hasBirthday = json['has_birthday'];
    birthdayNeedsAgreement = json['birthday_needs_agreement'];
    birthday = json['birthday'];
    birthdayType = json['birthday_type'];
    hasGender = json['has_gender'];
    genderNeedsAgreement = json['gender_needs_agreement'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profile_nickname_needs_agreement'] = profileNicknameNeedsAgreement;
    data['profile_image_needs_agreement'] = profileImageNeedsAgreement;
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    data['has_email'] = hasEmail;
    data['email_needs_agreement'] = emailNeedsAgreement;
    data['is_email_valid'] = isEmailValid;
    data['is_email_verified'] = isEmailVerified;
    data['email'] = email;
    data['has_age_range'] = hasAgeRange;
    data['age_range_needs_agreement'] = ageRangeNeedsAgreement;
    data['age_range'] = ageRange;
    data['has_birthday'] = hasBirthday;
    data['birthday_needs_agreement'] = birthdayNeedsAgreement;
    data['birthday'] = birthday;
    data['birthday_type'] = birthdayType;
    data['has_gender'] = hasGender;
    data['gender_needs_agreement'] = genderNeedsAgreement;
    data['gender'] = gender;
    return data;
  }
}

class Profile {
  String? nickname;
  String? thumbnailImageUrl;
  String? profileImageUrl;
  bool? isDefaultImage;

  Profile({
    this.nickname,
    this.thumbnailImageUrl,
    this.profileImageUrl,
    this.isDefaultImage});

  Profile.fromJson(Map<String, dynamic> json) {
    nickname = json['nickname'];
    thumbnailImageUrl = json['thumbnail_image_url'];
    profileImageUrl = json['profile_image_url'];
    isDefaultImage = json['is_default_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nickname'] = nickname;
    data['thumbnail_image_url'] = thumbnailImageUrl;
    data['profile_image_url'] = profileImageUrl;
    data['is_default_image'] = isDefaultImage;
    return data;
  }
}