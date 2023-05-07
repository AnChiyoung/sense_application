import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sense_flutter_application/models/sign_in/kakao_user_info_model.dart';

class PhoneAuthModel {
  Future<void> phoneAuthRequest(String phoneNumber) async {

    Map<String, dynamic> sendNumberModel = SendNumberModel(phoneNumber: phoneNumber.toString()).toJson();

    final response = await http.post(
      Uri.parse('https://dev.server.sense.runners.im/api/v1/user/phone/send'),
      body: sendNumberModel,
      headers: {
        'Authorization': 'Bearer ${KakaoUserInfoModel.userAccessToken!.accessToken}'
      });

    print(sendNumberModel);
    print('token?? : ${KakaoUserInfoModel.userAccessToken!.accessToken}');
  }
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