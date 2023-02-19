import 'package:flutter/material.dart';

import 'package:sense_flutter_application/views/sign_up/sign_up_vi\ew.dart';
import 'package:sense_flutter_application/views/sign_up/sign_up_header_view.dart';

class LoginPageSrceen extends StatefulWidget {
  @override
  _LoginPageSrceen createState() => _LoginPageSrceen();
}

class _LoginPageSrceen extends State<LoginPageSrceen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const SignUpHeaderVeiw(step: '1 / 8'),
        resizeToAvoidBottomInset : false,
        body: LoginBodyView()
    );
  }
}
