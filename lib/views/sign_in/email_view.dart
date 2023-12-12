import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/sign_in/email_check_model.dart';
import 'package:sense_flutter_application/models/sign_in/kakao_user_info_model.dart';
import 'package:sense_flutter_application/models/sign_in/signin_info_model.dart';
import 'package:sense_flutter_application/screens/sign_in/basic_info_screen.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_header_view.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_provider.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_validate.dart';

class EmailHeader extends StatefulWidget {
  const EmailHeader({super.key});

  @override
  State<EmailHeader> createState() => _EmailHeaderState();
}

class _EmailHeaderState extends State<EmailHeader> {
  @override
  Widget build(BuildContext context) {
    return SigninHeader(
        backButton: true, title: '', closeButton: false, backButtonCallback: backButtonCallback);
  }

  void backButtonCallback() {
    context.read<SigninProvider>().emailPasswordButtonStateChange(false);
  }
}

class EmailDescription extends StatelessWidget {
  const EmailDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 41.0.h, bottom: 25.0.h),
        child: const ContentDescription(presentPage: 2, totalPage: 3, description: '로그인 정보를\n입력해 주세요'));
  }
}

class EmailPasswordInputField extends StatefulWidget {
  KakaoUserModel? presetInfo;
  EmailPasswordInputField({super.key, this.presetInfo});

  @override
  State<EmailPasswordInputField> createState() => _EmailPasswordInputFieldState();
}

class _EmailPasswordInputFieldState extends State<EmailPasswordInputField> {
  late TextEditingController emailInputController;
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordReinputController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode passwordRepeatFocusNode = FocusNode();

  bool emailState = false;
  bool passwordState = false;
  bool passwordRepeatState = false;

  KakaoUserModel? kakaoUserModel;

  @override
  void initState() {
    super.initState();
    kakaoUserModel = widget.presetInfo;
    String email = kakaoUserModel?.email ?? '';
    emailInputController = TextEditingController(text: email);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextFormField(
                controller: emailInputController,
                autofocus: true,
                focusNode: emailFocusNode,
                readOnly: kakaoUserModel?.email == null ? false : true,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.always,
                maxLines: 1,
                textAlignVertical: TextAlignVertical.center,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: StaticColor.errorColor, width: 1)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: StaticColor.errorColor, width: 1)),
                  filled: true,
                  fillColor: StaticColor.loginInputBoxColor,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 20.0.h),
                  alignLabelWithHint: false,
                  labelText: '이메일 주소',
                  labelStyle: TextStyle(
                      fontSize: 12.0.sp, color: StaticColor.mainSoft, fontWeight: FontWeight.w500),
                  hintText: '이메일 주소를 입력해 주세요',
                  hintStyle: TextStyle(
                      fontSize: 16.0.sp,
                      color: StaticColor.loginHintTextColor,
                      fontWeight: FontWeight.w400),
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value!.isNotEmpty) {
                    if (SigninValidate().emailValidate(value) == false) {
                      emailState = false;
                      return '이메일 형식을 확인해 주세요';
                    } else {
                      emailState = true;
                      return null;
                      // emailCheck(value.toString()).then((value) {
                      //   if(value == true) {
                      //     emailState = false;
                      //     return '이미 가입된 이메일입니다';
                      //   } else {
                      //     emailState = true;
                      //     return null;
                      //   }
                      // });
                    }
                  } else {
                    emailState = false;
                    return null;
                  }
                },
                onFieldSubmitted: (f) {
                  FocusScope.of(context).requestFocus(passwordFocusNode);
                },
                onChanged: (_) {
                  /// data input

                  SigninModel.email = emailInputController.text;

                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    emailState && passwordState && passwordRepeatState == true
                        ? context.read<SigninProvider>().emailPasswordButtonStateChange(true)
                        : context.read<SigninProvider>().emailPasswordButtonStateChange(false);
                  });
                }),
            const SizedBox(height: 8),
            TextFormField(
                controller: passwordController,
                focusNode: passwordFocusNode,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.always,
                obscureText: true,
                maxLines: 1,
                maxLength: 16,
                textAlignVertical: TextAlignVertical.center,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: StaticColor.errorColor, width: 1)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: StaticColor.errorColor, width: 1)),
                  filled: true,
                  fillColor: StaticColor.loginInputBoxColor,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  alignLabelWithHint: false,
                  counterText: '',
                  labelText: '비밀번호',
                  labelStyle: TextStyle(
                      fontSize: 12.0.sp, color: StaticColor.mainSoft, fontWeight: FontWeight.w500),
                  hintText: '비밀번호를 입력해 주세요',
                  hintStyle: TextStyle(
                      fontSize: 16.0.sp,
                      color: StaticColor.loginHintTextColor,
                      fontWeight: FontWeight.w400),
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value!.isNotEmpty) {
                    if (SigninValidate().passwordValidate(value) == false) {
                      passwordState = false;
                      return '영문 소문자, 숫자 포함 6~16글자로 입력해 주세요';
                    } else {
                      SigninModel.password = value;
                      passwordState = true;
                      return null;
                    }
                  } else {
                    passwordState = false;
                    return null;
                  }
                },
                onFieldSubmitted: (f) {
                  FocusScope.of(context).requestFocus(passwordRepeatFocusNode);
                },
                onChanged: (_) {
                  /// data input
                  SigninModel.password = passwordController.text;

                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    emailState && passwordState && passwordRepeatState == true
                        ? context.read<SigninProvider>().emailPasswordButtonStateChange(true)
                        : context.read<SigninProvider>().emailPasswordButtonStateChange(false);
                  });
                }),
            const SizedBox(height: 8),
            TextFormField(
              controller: passwordReinputController,
              focusNode: passwordRepeatFocusNode,
              // textInputAction: TextInputAction.done,
              autovalidateMode: AutovalidateMode.always,
              obscureText: true,
              maxLines: 1,
              maxLength: 16,
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: StaticColor.errorColor, width: 1)),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: StaticColor.errorColor, width: 1)),
                filled: true,
                fillColor: StaticColor.loginInputBoxColor,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                alignLabelWithHint: false,
                counterText: '',
                labelText: '비밀번호 확인',
                labelStyle: TextStyle(
                    fontSize: 12.0.sp, color: StaticColor.mainSoft, fontWeight: FontWeight.w500),
                hintText: '비밀번호를 확인해 주세요',
                hintStyle: TextStyle(
                    fontSize: 16.0.sp,
                    color: StaticColor.loginHintTextColor,
                    fontWeight: FontWeight.w400),
                border: InputBorder.none,
              ),
              validator: (value) {
                if (value!.isNotEmpty) {
                  if (SigninModel.password != value) {
                    passwordRepeatState = false;
                    return '비밀번호가 일치하지 않아요';
                  } else {
                    passwordRepeatState = true;
                    return null;
                  }
                } else {
                  passwordRepeatState = false;
                  return null;
                }
              },
              onChanged: (_) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  emailState && passwordState && passwordRepeatState == true
                      ? context.read<SigninProvider>().emailPasswordButtonStateChange(true)
                      : context.read<SigninProvider>().emailPasswordButtonStateChange(false);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> emailCheck(String email) async {
    return await EmailCheckRequest().emailCheckRequest(email);
  }
}

class EmailButton extends StatefulWidget {
  const EmailButton({super.key});

  @override
  State<EmailButton> createState() => _EmailButtonState();
}

class _EmailButtonState extends State<EmailButton> {
  Future backButtonAction(BuildContext context) async {
    // context.read<AddEventProvider>().dateSelectNextButtonReset();
  }

  @override
  Widget build(BuildContext context) {
    final buttonState = context.watch<SigninProvider>().emailPasswordButtonState;

    return WillPopScope(
      onWillPop: () async {
        await backButtonAction(context);
        return true;
      },
      child: SizedBox(
        width: double.infinity,
        height: 76,
        child: ElevatedButton(
            onPressed: () async {
              buttonState == true
                  ? Navigator.push(
                      context, MaterialPageRoute(builder: (_) => const BasicInfoScreen()))
                  : {};
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: buttonState == true
                    ? StaticColor.categorySelectedColor
                    : StaticColor.unSelectedColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
            child: const Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                  height: 56,
                  child: Center(
                      child: Text('다음',
                          style: TextStyle(
                              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700)))),
            ])),
      ),
    );
  }
}
