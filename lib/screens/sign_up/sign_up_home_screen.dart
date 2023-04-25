import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/sign_up/sign_up_header_view.dart';
import 'package:sense_flutter_application/views/sign_up/sign_up_view.dart';

class LoginPageScreen extends StatefulWidget {
  @override
  _LoginPageSrceen createState() => _LoginPageSrceen();
}

class _LoginPageSrceen extends State<LoginPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset : false,
        body: SafeArea(
          child: Column(
            children: [
              SignupHeader(),
              LoginBody(),
            ]
          )
        )
    );
  }
}
