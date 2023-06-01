import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/sign_in/kakao_user_info_model.dart';
import 'package:sense_flutter_application/models/sign_in/token_model.dart';
import 'package:sense_flutter_application/screens/sign_in/email_screen.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_header_view.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_provider.dart';

class PolicyHeader extends StatelessWidget {
  const PolicyHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SigninHeader(backButton: false, title: '', closeButton: false);
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
          policyRow('[필수] 이용약관', 0),
          const SizedBox(height: 24),
          policyRow('[필수] 본인인증을 위한 개인정보 제 3자 제공', 1),
          const SizedBox(height: 24),
          policyRow('[선택] 취향 맞춤형 서비스 제공 항목', 2),
          const SizedBox(height: 24),
          policyRow('[선택] 마케팅 정보 수신 동의사항', 3),
        ],
      ),
    );
  }

  Widget policyRow(String text, int index) {
    List<bool> state;
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
                  style: TextStyle(fontSize: 14, color: StaticColor.signinPolicyColor, fontWeight: FontWeight.w700),
                  softWrap: false,
                  overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            String title = '';
            String description = '';
            if(index == 0) {
              title = '[필수] 이용약관';
              description = 'for ready';
            } else if(index == 1) {
              title = '[필수] 본인인증을 위한 개인정보 제 3자 제공';
              description = 'for ready';
            } else if(index == 2) {
              title = '[선택] 취향 맞춤형 서비스 제공 항목';
              description = 'for ready';
            } else if(index == 3) {
              title = '[선택] 마케팅 정보 수신 동의사항';
              description = 'for ready';
            }
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
              ),
              builder: (BuildContext context) {
                return Container(
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
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Image.asset('assets/signin/button_close.png', width: 24, height: 24),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        Text(title, style: TextStyle(fontSize: 14, color: StaticColor.signinPolicyColor, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 8),
                        Text(description, style: TextStyle(fontSize: 14, color: StaticColor.signinPolicyColor, fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),
                );
              }
            );
          },
          child: Align(
              alignment: Alignment.bottomCenter, child: Text('더보기', style: TextStyle(fontSize: 12, color: StaticColor.signinPolicyAddTextColor, fontWeight: FontWeight.w700))),
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
            child: ElevatedButton(
              onPressed: () async {
                if(buttonState == false) {}
                else if(buttonState == true) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => EmailScreen(kakaoUserModel: widget.presentInfo)));
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: buttonState == true ? StaticColor.categorySelectedColor : StaticColor.signinPolicyAddTextColor, elevation: 0.0),
              child: Text('다음', style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400)),
            ),
          ),
        ),
        const SizedBox(height: 40),
        TextButton(
          onPressed: () {
            context.read<SigninProvider>().policyCheckStateChange([true, true, false, false]);
          },
          child: Text('필수 항목만 동의하고 다음으로', style: TextStyle(fontSize: 12, color: StaticColor.signinPolicyAddTextColor, fontWeight: FontWeight.w500, decoration: TextDecoration.underline)),
        )
      ],
    );




    // if(isInstalled == true) {
    //   try {
    //     // token = await UserApi.instance.loginWithKakaoTalk();
    //     await UserApi.instance.loginWithKakaoAccount();
    //     /// saved token for static variable
    //     KakaoUserInfoModel.userAccessToken = token;
    //     token == null ? print('kakao token is empty') : {
    //
    //       /// user info model setup
    //       userModel = await KakaoUserInfoModel().getUserInfo(token),
    //       Navigator.push(context, MaterialPageRoute(builder: (_) => EmailScreen(kakaoUserModel: userModel)))
    //     };
    //   } catch (error) {
    //     rethrow;
    //   }
    // } else if(isInstalled == false) {
    //   token = await UserApi.instance.loginWithKakaoAccount();
    //   token == null ? print('kakao token is empty') : {
    //     KakaoUserInfoModel.userAccessToken = token,
    //     Navigator.push(context, MaterialPageRoute(builder: (_) => EmailScreen(kakaoUserModel: userModel)))
    //   };
    // }
  }
}
