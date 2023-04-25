import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/login/kakao_login_view.dart';
import 'package:sense_flutter_application/views/login/logo_home_view.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LogoImageView(),
            KakaoLoginView()
          ],
        ),
      ),
    );
  }
}
