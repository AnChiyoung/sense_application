import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/login/login_view.dart';
import 'package:flutter/foundation.dart' as foundation;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isAndroid = false;

  @override
  Widget build(BuildContext context) {


    /// foundation platform
    isAndroid = foundation.defaultTargetPlatform == foundation.TargetPlatform.android;

    /// safe area height
    final safeAreaTopPadding = MediaQuery.of(context).padding.top;
    final safeAreaBottomPadding = MediaQuery.of(context).padding.bottom;

    /// when touch for area of another keyboard area, hide to keyboard, into app
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: StaticColor.loginBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height - safeAreaTopPadding - safeAreaBottomPadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(child: LogoView()),
                  LoginFormView(),
                  isAndroid == true ? KakaoLoginButton() : Container(height: 163.0.h, color: Colors.white),
                  SizedBox(height: 8.0.h),
                  SigninView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
