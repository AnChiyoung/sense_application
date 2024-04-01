import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:kakao_flutter_sdk_auth/kakao_flutter_sdk_auth.dart' as KakaoApi;
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as KakaoApi;
import 'package:sense_flutter_application/apis/auth/auth_api.dart';
import 'package:sense_flutter_application/screens/widgets/common/clickable_text.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_button.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_checkbox.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_toast.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';
import 'package:sense_flutter_application/utils/utils.dart';
import '../common/input_text_field.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  TextEditingController passwordController = TextEditingController();
  String email = "";
  String password = "";
  bool isAutoLogin = false;
  AuthApi authApi = AuthApi();


// Check if email and password are valid or filled
  bool isButtonEnabled() {
    return emailValidator(email) == null && password.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    int screenWidth =  MediaQuery.of(context).size.width.toInt();

    return Container(
      constraints: BoxConstraints(
        maxWidth: screenWidth > 780 ? 500 : double.infinity,
      ),
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Column(
        children: [
          InputTextField(
            label: '이메일',
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
            placeholder: '이메일을 입력해 주세요텍스트',
            errorMessage: emailValidator(email),
          ),

          const SizedBox(height: 24),

          InputTextField(
            label: '비밀번호',
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
            placeholder: '비밀번호를 입력해 주세요텍스트',
            isObscure: true,
          ),

          const SizedBox(height: 12),
          // Auto Login & ForgotPassword Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomCheckbox(
                label: '자동로그인',
                isChecked: isAutoLogin,
                onChanged: () {
                  setState(() {
                    isAutoLogin = !isAutoLogin;
                  });
                }
              ),
              ClickableText(
                text: '비밀번호 찾기',
                onTap: () {
                  GoRouter.of(context).push('/forgot-password/step1');
                }
              ),
            ],
          ),

          // Buttons
          const SizedBox(
            height: 48
          ),
          CustomButton(
            height: 48,
            backgroundColor: isButtonEnabled() ? primaryColor[50]! : const Color.fromRGBO(187, 187, 187, 1),
            labelText: '로그인',
            textColor: Colors.white,
            fontSize: 14,
            onPressed: () async {
              var response =  await authApi.loginUser(email, password);
              if (response['code'] ==200) {
                GoRouter.of(context).go('/home');
              } else {
                var nonFieldError = response['errors']['non_field_errors'];
                showSnackBar(context, nonFieldError?.isNotEmpty ? nonFieldError[0] : response['message'], icon: Icons.error, iconColor: Colors.red);
              }
            },
          ),
          const SizedBox(
            height: 16
          ),

          // Kakao Login
          CustomButton(
            height: 48,
            backgroundColor: const Color.fromRGBO(254, 229, 0, 1),
            labelText: '카카오로 시작하기',
            prefixIcon: SvgPicture.asset('lib/assets/images/icons/svg/kakaotalk.svg', width: 20, height: 20),
            textColor: Colors.black,
            fontSize: 14,
            onPressed: () async {
                bool talkInstalled = await KakaoApi.isKakaoTalkInstalled();
                String accessToken = '';

               if (talkInstalled) {
                 try {
                    KakaoApi.OAuthToken token = await KakaoApi.UserApi.instance.loginWithKakaoTalk();
                    accessToken = token.accessToken;
                    print(token.accessToken);
                  } catch (e) {
                    print('ERRROR');
                  }
               } else {
                KakaoApi.OAuthToken token = await KakaoApi.UserApi.instance.loginWithKakaoAccount();
                accessToken = token.accessToken;
                print(token.accessToken);
               }

               print('accessToken = $accessToken');

              //  AuthApi().loginWithKakao(accessToken).then((response) {
              //    if (response['code'] == 200) {
              //      GoRouter.of(context).go('/home');
              //    } else {
              //      CustomToast.errorToast(context, response['message']);
              //    }
              //  }).catchError((error) {
              //     CustomToast.errorToast(context, error['message']);
              //  });
             
            },
          ),
          const SizedBox(
            height: 16
          ),
          Center(
            child: ClickableText(text: '이메일로 회원가입', onTap: () {
              GoRouter.of(context).push('/signup/step1');
              // print('Can ho no');
            },)
          )
        ],
      ),
    );
  }
}