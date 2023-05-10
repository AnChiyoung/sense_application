import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sense_flutter_application/models/sign_in/kakao_user_info_model.dart';

class PhoneAuthModel {
  Future<bool> phoneAuthRequest(String phoneNumber) async {

    Map<String, dynamic> sendNumberModel = SendNumberModel(phoneNumber: phoneNumber.toString()).toJson();

    final response = await http.post(
      Uri.parse('https://dev.server.sense.runners.im/api/v1/user/phone/send'),
      body: sendNumberModel,
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
      if (kDebugMode) {
        print('error : $response');
      }
    }
  }

  Future<bool> authNumberCheck(String phoneNumber, int authNumber) async {

    Map<String, dynamic> authNumberModel = AuthNumberCheckModel(phoneNumber: phoneNumber.toString(), code: authNumber).toJson();

    print(authNumberModel);

    final response = await http.post(
      Uri.parse('https://dev.server.sense.runners.im/api/v1/user/phone/auth'),
      body: json.encode(authNumberModel),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      print('성공이요');
      return true;
    } else {
      print('실패예요');
      return false;
      if (kDebugMode) {
        print('error : $response');
      }
    }
  }
}

class AuthNumberCheckModel {
  String phoneNumber;
  int code;

  AuthNumberCheckModel({
    required this.phoneNumber,
    required this.code,
  });

  Map<String, dynamic> toJson() => {
    'phone': phoneNumber,
    'code': code,
  };
}

class SendNumberModel {
  String phoneNumber;

  SendNumberModel({
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() => {
    'phone': phoneNumber,
  };
}

class AuthModel {
  int? id;
  String? toNumber;
  bool? isSent;
  DateTime? expired;

  AuthModel({
    this.id,
    this.toNumber,
    this.isSent,
    this.expired,
  });

  AuthModel.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    toNumber = json['to_number'] ?? '';
    isSent = json['is_sent'] ?? false;
    expired = json['expired'] ?? DateTime.now();
  }
}