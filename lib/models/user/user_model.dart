import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/api_path.dart';
import 'package:sense_flutter_application/constants/constants.dart';
import 'package:sense_flutter_application/constants/logger.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/views/my_page/my_page_provider.dart';

class UserRequest {
  Future<UserModel> userInfoRequest() async {
    String? token = await LoginRequest.storage.read(key: 'loginToken');
    final response = await http.get(Uri.parse('${ApiUrl.releaseUrl}/user/me'), headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json; charset=UTF-8'
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      SenseLogger().debug('success to load user info');
      UserModel userModel = UserModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes))['data']);
      return userModel;
    } else {
      SenseLogger().error('fail to load user info');
      return UserModel();
    }
  }

  Future<bool> userBasicInfoUpdate(BuildContext context) async {
    Map<String, dynamic> updateModel = {};
    updateModel.clear();

    String imageString = context.read<MyPageProvider>().updateImageString;
    if (imageString.isEmpty) {
    } else {
      updateModel['profile_image'] = imageString;
    }
    String name = context.read<MyPageProvider>().name;
    SenseLogger().debug('update name!!: $name');
    updateModel['username'] = name;

    String birthday = context.read<MyPageProvider>().birthday;
    updateModel['birthday'] = birthday;

    final response = await http
        .patch(Uri.parse('${ApiUrl.releaseUrl}/user/me'), body: jsonEncode(updateModel), headers: {
      'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
      'Content-Type': 'application/json; charset=UTF-8'
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      SenseLogger().debug('success to update user info');
      return true;
    } else {
      SenseLogger().error('fail to update user info');
      return false;
    }
  }

  Future<bool> userMoreInfoUpdate(BuildContext context) async {
    Map<String, dynamic> updateModel = {};
    updateModel.clear();

    int gender = context.read<MyPageProvider>().genderState;
    int relation = context.read<MyPageProvider>().relationState;
    int mbti = context.read<MyPageProvider>().saveMbti;
    int ownCar = context.read<MyPageProvider>().ownCar;
    String? genderString;
    String? relationString;
    String? mbtiString;
    bool? ownCarBoolean;
    if (gender == -1) {
    } else if (gender == 0) {
      updateModel['gender'] = 'MALE';
    } else if (gender == 1) {
      updateModel['gender'] = 'FEMALE';
    }

    if (relation == -1) {
    } else if (relation == 0) {
      updateModel['relationship_status'] = '솔로';
    } else if (relation == 1) {
      updateModel['relationship_status'] = '연애중';
    } else if (relation == 2) {
      updateModel['relationship_status'] = '기혼';
    }

    if (mbti == -1) {
    } else {
      updateModel['mbti'] = Constants.mbtiTypes.elementAt(mbti);
    }

    if (ownCar == -1) {
    } else if (ownCar == 0) {
      updateModel['is_own_car'] = true;
    } else if (ownCar == 1) {
      updateModel['is_own_car'] = false;
    }

    final response = await http
        .patch(Uri.parse('${ApiUrl.releaseUrl}/user/me'), body: jsonEncode(updateModel), headers: {
      'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
      'Content-Type': 'application/json; charset=UTF-8'
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      SenseLogger().debug('success to update user info');
      return true;
    } else {
      SenseLogger().error('fail to update user info');
      return false;
    }
  }

  Future<bool> userAlarmInfoUpdate(BuildContext context, int alarmType) async {
    Map<String, dynamic> updateModel = {};
    updateModel.clear();

    bool push = context.read<MyPageProvider>().pushAlarm;
    bool marketing = context.read<MyPageProvider>().marketingAlarm;

    if (alarmType == 0) {
      updateModel['is_push_alarm'] = push;
    } else if (alarmType == 1) {
      updateModel['is_marketing_alarm'] = marketing;
    }

    final response = await http
        .patch(Uri.parse('${ApiUrl.releaseUrl}/user/me'), body: jsonEncode(updateModel), headers: {
      'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
      'Content-Type': 'application/json; charset=UTF-8'
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      SenseLogger().debug('success to update user info - alarm');
      return true;
    } else {
      SenseLogger().error('fail to update user info - alarm');
      return false;
    }
  }

  Future<bool> userAdditionalInfoUpdate() async {
    final response = await http.post(
      Uri.parse('${ApiUrl.releaseUrl}/user/profile'),
      headers: {
        'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      SenseLogger().debug('success to update user additional info');
      return true;
    } else {
      SenseLogger().error('fail to update user user additional info');
      return false;
    }
  }
}

class UserModel {
  int? id;
  String? profileImageString;
  String? email;
  String? phone;
  String? username;
  String? birthday;
  bool? isSignup;
  String? gender;
  String? relationshipStatus;
  String? mbti;
  bool? isOwnCar;
  bool? isPushAlarm;
  bool? isMarketingAlarm;
  List<int>? stores;
  bool? isAddProfile;

  UserModel({
    this.id,
    this.profileImageString,
    this.email,
    this.phone,
    this.username,
    this.birthday,
    this.isSignup,
    this.gender,
    this.relationshipStatus,
    this.mbti,
    this.isOwnCar,
    this.isPushAlarm,
    this.isMarketingAlarm,
    this.stores,
    this.isAddProfile,
  });

  UserModel.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    profileImageString = json['profile_image_url'] ?? '';
    email = json['email'] ?? '';
    phone = json['phone'] ?? '';
    username = json['username'] ?? '';
    birthday = json['birthday'] ?? '';
    isSignup = json['is_signup'] ?? false;
    gender = json['gender'] ?? '';
    relationshipStatus = json['relationship_status'] ?? '';
    mbti = json['mbti'] ?? '';
    isOwnCar = json['is_own_car'] ?? false;
    isPushAlarm = json['is_push_alarm'] ?? false;
    isMarketingAlarm = json['is_marketing_alarm'] ?? false;
    stores = json['stores'] == null ? null : List<int>.from(json['stores']);
    isAddProfile = json['is_add_profile'] ?? false;
  }
}
