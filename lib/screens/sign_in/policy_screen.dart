import 'package:flutter/material.dart';
import 'package:sense_flutter_application/models/sign_in/kakao_user_info_model.dart';
import 'package:sense_flutter_application/views/sign_in/policy_view.dart';

class PolicyScreen extends StatefulWidget {
  final KakaoUserModel? kakaoUserModel;
  const PolicyScreen({super.key, this.kakaoUserModel});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  @override
  Widget build(BuildContext context) {
    /// safe area height
    final safeAreaTopPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const PolicyHeader(),
              const PolicyDescription(),
              PolicyCheckField(topPadding: safeAreaTopPadding),
              PolicyButton(presentInfo: widget.kakaoUserModel),
            ],
          ),
        ),
      ),
    );
  }
}
