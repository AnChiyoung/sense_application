import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/login/login_view.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    /// when touch for area of another keyboard area, hide to keyboard, into app
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: StaticColor.loginBackgroundColor,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Expanded(child: LogoView()),
              LoginFormView(),
              KakaoLoginButton(),
              SizedBox(height: 8),
              SigninView(),
            ],
          ),
        ),
      ),
    );
  }
}
