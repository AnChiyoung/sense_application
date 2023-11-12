import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sense_flutter_application/constants/api_path.dart';

class PhoneAuthModel {
  Future<bool> phoneAuthRequest(String phoneNumber) async {
    Map<String, dynamic> sendNumberModel =
        SendNumberModel(phoneNumber: phoneNumber.toString()).toJson();

    final response = await http.post(
      Uri.parse('${ApiUrl.releaseUrl}/user/phone/send'),
      body: json.encode(sendNumberModel),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> authNumberCheck(String phoneNumber, int authNumber) async {
    Map<String, dynamic> authNumberModel =
        AuthNumberCheckModel(phoneNumber: phoneNumber.toString(), code: authNumber).toJson();

    final response = await http.post(Uri.parse('${ApiUrl.releaseUrl}/user/phone/auth'),
        body: json.encode(authNumberModel),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        encoding: const Utf8Codec(
          allowMalformed: true,
        ));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    }

    try {
      String errorMessage =
          json.decode(utf8.decode(response.bodyBytes))['errors']['non_field_errors'][0];

      switch (errorMessage) {
        case '잘못된 인증 코드입니다.':
          return '인증번호가 다릅니다.';
        case '인증 시간이 만료되었습니다.':
          return '유효시간이 만료되었어요.';
        default:
      }
    } catch (e) {
      return false;
    }

    return false;
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
