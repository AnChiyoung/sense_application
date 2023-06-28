import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sense_flutter_application/models/sign_in/signin_info_model.dart';

class TestRequest {
  Future<bool> signinRequestTest() async {

    Map<String, dynamic> signinJson = SigninRequestModel(
      email: 'testcase_master@gmail.com',
      password: 'qwer1234',
      name: '테스터',
      birthday: '1988-01-11',
      gender: '남성',
      phone: '01012341234',
    ).toJson();

    final response = await http.patch(
        Uri.parse('https://dev.server.sense.runners.im/api/v1/user/signup'),
        body: jsonEncode(signinJson),
        headers: {
          // 'Authorization': 'Bearer ${KakaoUserInfoModel.userAccessToken!.accessToken}'
          'Authorization': 'Bearer RE7gBGhHQspX0yODpMo_aARKUkoElY6qHfvuFz7HCiolUAAAAYg4H1Q0',
        });

    // print('token????? : ${KakaoUserInfoModel.userAccessToken!.accessToken}');

    if(response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      print('가입 성공했음');
      return true;
    } else {
      print(response.body);
      print('가입 실패했음');
      return false;
    }
  }
}