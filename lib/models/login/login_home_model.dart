import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk_auth/src/model/oauth_token.dart';

const storage = FlutterSecureStorage();

Future<void> kakaoLoginSequence({required OAuthToken param}) async {

  String jsonData = '';
  var response = await http.post(Uri.parse('https://dev.server.sense.runners.im/api/v1/kakao/login'), body: {"access_token": param.accessToken});

  print('kakao response : $response');

  if (response.statusCode == 200) {
    jsonData = response.body;
    var token = jsonDecode(jsonData)['data']['token']['access_token'];
    print('send token!! : $token');
    await storage.write(
        key: 'login', value: token); // login key에 SecureStorage에 담는다
  } else {
    throw Exception('fail to kakao login');
  }
}

Future<void> kakaoLogout() async {
  await storage.delete(key: 'login');
}