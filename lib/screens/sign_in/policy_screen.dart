import 'package:flutter/material.dart';
import 'package:sense_flutter_application/models/sign_in/kakao_user_info_model.dart';
import 'package:sense_flutter_application/views/sign_in/policy_view.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_header_view.dart';

class PolicyScreen extends StatefulWidget {
  KakaoUserModel? kakaoUserModel;
  PolicyScreen({Key? key, this.kakaoUserModel}) : super(key: key);

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  @override
  Widget build(BuildContext context) {

    /// safe area height
    final safeAreaTopPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              PolicyHeader(),
              PolicyDescription(),
              PolicyCheckField(topPadding: safeAreaTopPadding),
              PolicyButton(presentInfo: widget.kakaoUserModel),
            ],
          ),
        ),
      ),
    );
  }
}
