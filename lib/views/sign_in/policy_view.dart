import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/sign_in/kakao_user_info_model.dart';
import 'package:sense_flutter_application/models/sign_in/policy_model.dart';
import 'package:sense_flutter_application/models/sign_in/token_model.dart';
import 'package:sense_flutter_application/screens/sign_in/email_screen.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_header_view.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_provider.dart';

class PolicyHeader extends StatefulWidget {
  const PolicyHeader({Key? key}) : super(key: key);

  @override
  State<PolicyHeader> createState() => _PolicyHeaderState();
}

class _PolicyHeaderState extends State<PolicyHeader> {
  @override
  Widget build(BuildContext context) {
    return SigninHeader(backButton: true, title: '', closeButton: false, backButtonCallback: backButtonCallback);
  }

  void backButtonCallback() {
    context.read<SigninProvider>().allCheckStateChange(false);
  }
}

class PolicyDescription extends StatelessWidget {
  const PolicyDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 41, bottom: 25),
      child: SigninDescription(presentPage: 1, totalPage: 3, description: '서비스 약관에\n동의해 주세요')
    );
  }
}

class PolicyCheckField extends StatefulWidget {
  double? topPadding;
  PolicyCheckField({Key? key, this.topPadding}) : super(key: key);

  @override
  State<PolicyCheckField> createState() => _PolicyCheckFieldState();
}

class _PolicyCheckFieldState extends State<PolicyCheckField> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 51),
      child: Column(
        children: [
          allPolicySelectRow('전체동의'),
          const SizedBox(height: 16),
          Container(height: 1, color: StaticColor.dividerColor),
          const SizedBox(height: 16),
          policyRow('[필수] 만 14세 이상입니다', 0),
          const SizedBox(height: 24),
          policyRow('[필수] 센스 이용약관', 1),
          const SizedBox(height: 24),
          policyRow('[필수] 개인정보처리 동의', 2),
          const SizedBox(height: 24),
          policyRow('[필수] 개인정보 처리방침', 3),
          const SizedBox(height: 24),
          policyRow('[선택] 마케팅 정보 수신 동의', 4),
        ],
      ),
    );
  }

  Widget allPolicySelectRow(String text) {

    String checkState = 'policy_check_empty.png';
    bool allCheckState = context.watch<SigninProvider>().allCheckState;
    allCheckState == true ? checkState = 'policy_check_done.png' : checkState = 'policy_check_empty.png';

    return GestureDetector(
      onTap: () {
        context.read<SigninProvider>().allCheckStateChange(!allCheckState);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset('assets/signin/$checkState', width: 20, height: 20),
          const SizedBox(width: 12),
          Text(text,
              style: TextStyle(fontSize: 16, color: StaticColor.signinPolicyColor, fontWeight: FontWeight.w700),
              softWrap: false,
              overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget policyRow(String text, int index) {
    List<bool> state = [];
    String checkState = 'policy_check_empty.png';
    state = context.watch<SigninProvider>().checkState;
    state[index] == true ? checkState = 'policy_check_done.png' : checkState = 'policy_check_empty.png';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              state[index] = !state[index];
              context.read<SigninProvider>().policyCheckStateChange(state);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/signin/$checkState', width: 20, height: 20),
                const SizedBox(width: 12),
                Text(text,
                  style: TextStyle(fontSize: 16, color: StaticColor.signinPolicyColor, fontWeight: FontWeight.w700),
                  softWrap: false,
                  overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ),
        index == 0 ? const SizedBox.shrink() : GestureDetector(
          onTap: () {
            String title = '';
            String description = '';
            if(index == 1) {
              title = '[필수] 센스 이용약관';
              description = PolicyDescriptionModel.needPolicy01;
            } else if(index == 2) {
              title = '[필수] 개인정보처리 동의';
              description = PolicyDescriptionModel.needPolicy02;
            } else if(index == 3) {
              title = '[필수] 개인정보 처리방침';
              description = PolicyDescriptionModel.needPolicy03;
            } else if(index == 4) {
              title = '[선택] 마케팅 정보 수신 동의';
              description = PolicyDescriptionModel.selectPolicy01;
            }
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
              ),
              builder: (BuildContext context) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height - widget.topPadding!,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('약관 상세', style: TextStyle(fontSize: 18, color: StaticColor.signinDescriptionColor, fontWeight: FontWeight.w700)),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(25.0),
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Image.asset('assets/signin/button_close.png', width: 24, height: 24),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const ClampingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(title, style: TextStyle(fontSize: 14, color: StaticColor.signinPolicyColor, fontWeight: FontWeight.w700)),
                                const SizedBox(height: 8),
                                Text(description, style: TextStyle(fontSize: 14, color: StaticColor.signinPolicyColor, fontWeight: FontWeight.w400)),
                              ]
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                );
              }
            );
          },
          child: Align(
              alignment: Alignment.bottomCenter, child: Text('더보기', style: TextStyle(fontSize: 14, color: StaticColor.signinPolicyAddTextColor, fontWeight: FontWeight.w700))),
        ),
      ],
    );
  }
}

class PolicyButton extends StatefulWidget {
  KakaoUserModel? presentInfo;
  PolicyButton({Key? key, this.presentInfo}) : super(key: key);

  @override
  State<PolicyButton> createState() => _PolicyButtonState();
}

class _PolicyButtonState extends State<PolicyButton> {
  @override
  Widget build(BuildContext context) {

    final buttonState = context.watch<SigninProvider>().signinButtonState;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              color: StaticColor.categoryUnselectedColor,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: ElevatedButton(//////
              onPressed: () async {
                if(buttonState == false) {}
                else if(buttonState == true) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => EmailScreen(kakaoUserModel: widget.presentInfo)));
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: buttonState == true ? StaticColor.categorySelectedColor : StaticColor.signinPolicyAddTextColor, elevation: 0.0),
              child: Text('다음', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400)),
            ),
          ),
        ),
        const SizedBox(height: 40),
        TextButton(
          onPressed: () {
            context.read<SigninProvider>().policyCheckStateChange([true, true, true, true, false]);
            // Navigator.push(context, MaterialPageRoute(builder: (_) => EmailScreen()));
          },
          child: Text('필수 항목만 동의', style: TextStyle(fontSize: 16, color: StaticColor.signinPolicyAddTextColor, fontWeight: FontWeight.w500, decoration: TextDecoration.underline)),
        )
      ],
    );
  }
}
