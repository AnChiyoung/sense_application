import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:quiver/async.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/sign_in/kakao_user_info_model.dart';
import 'package:sense_flutter_application/models/sign_in/phone_auth_model.dart';
import 'package:sense_flutter_application/models/sign_in/signin_info_model.dart';
import 'package:sense_flutter_application/public_widget/test_request.dart';
import 'package:sense_flutter_application/screens/home/home_screen.dart';
import 'package:sense_flutter_application/screens/login/login_screen.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_header_view.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_provider.dart';

class PhoneAuthHeader extends StatefulWidget {
  const PhoneAuthHeader({Key? key}) : super(key: key);

  @override
  State<PhoneAuthHeader> createState() => _PhoneAuthHeaderState();
}

class _PhoneAuthHeaderState extends State<PhoneAuthHeader> {
  @override
  Widget build(BuildContext context) {
    return SigninHeader(backButton: true, title: '', closeButton: false, backButtonCallback: backButtonCallback);
  }

  void backButtonCallback() {
    context.read<SigninProvider>().timeValidateChange(false);
  }
}

class PhoneAuthDescription extends StatelessWidget {
  const PhoneAuthDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 41.0.h, bottom: 25.0.h),
        child: ContentDescription(description: '인증번호 4자리를\n입력해 주세요'));
  }
}

class PhoneAuthInputField extends StatefulWidget {
  String phoneNumber;
  PhoneAuthInputField({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<PhoneAuthInputField> createState() => _PhoneAuthInputFieldState();
}

class _PhoneAuthInputFieldState extends State<PhoneAuthInputField> {
  /// text field variable
  TextEditingController authNumberController = TextEditingController();
  FocusNode authNumberFocusNode = FocusNode();

  /// timer field variable
  int startSeconds = 180;
  Timer? timer;
  String minute = '';
  String second = '';
  String remainText = '';

  void startTimer() {
    startSeconds = 180;
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      minute = (startSeconds.toDouble() / 60.0).toInt().toString();
      second = (startSeconds.toDouble() % 60.0).toInt() == 0
          ? '00'
          : ((startSeconds.toDouble() % 60.0).toInt() > 0 && (startSeconds.toDouble() % 60.0).toInt() < 10)
              ? '0' + (startSeconds.toDouble() % 60.0).toInt().toString()
              : (startSeconds.toDouble() % 60.0).toInt().toString();
      remainText = '유효시간 ' + minute + ':' + second;
      // print(remainText);

      if (startSeconds == 0) {
        context.read<SigninProvider>().timeValidateChange(true);
        timer.cancel();
      } else {
        startSeconds--;
        context.read<SigninProvider>().timerStateChange(true);
      }
    });
  }

  Future? sendFuture;

  @override
  void initState() {
    sendFuture = PhoneAuthModel().phoneAuthRequest(widget.phoneNumber.toString());
    startTimer();
    authNumberController.text = '';
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sendFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Consumer<SigninProvider>(
                    builder: (context, data, child) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          TextFormField(
                              controller: authNumberController,
                              autofocus: true,
                              focusNode: authNumberFocusNode,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              autovalidateMode: AutovalidateMode.always,
                              maxLines: 1,
                              textAlignVertical: TextAlignVertical.center,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: StaticColor.errorColor, width: 1)),
                                errorBorder: OutlineInputBorder(borderSide: BorderSide(color: StaticColor.errorColor, width: 1)),
                                filled: true,
                                fillColor: StaticColor.loginInputBoxColor,
                                contentPadding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 20.0.h),
                                alignLabelWithHint: false,
                                labelText: '인증번호',
                                labelStyle: TextStyle(fontSize: 12.0.sp, color: StaticColor.mainSoft, fontWeight: FontWeight.w500),
                                hintText: '번호를 입력하세요',
                                hintStyle: TextStyle(fontSize: 16.0.sp, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (data.timeValidate == true) {
                                  return '유효한 시간이 만료되었어요';
                                } else {
                                  if (data.authValidate == true) {
                                    return '인증번호가 달라요';
                                  } else {
                                    return null;
                                  }
                                }
                              },
                              onChanged: (value) async {
                                if (value.length >= 4) {

                                  /// 폰 인증번호 일치할 때
                                  if(await PhoneAuthModel().authNumberCheck(widget.phoneNumber, int.parse(value)) == true) {
                                    context.read<SigninProvider>().authValidateChange(false);

                                    SigninModel.signinType == 0 ? await SigninModel().kakaoSigninRequest() : await SigninModel().emailSigninRequest();

                                    // bool result = await SigninModel().kakaoSigninRequest();
                                    // var logger = Logger(
                                    //   printer: PrettyPrinter(
                                    //     lineLength: 120,
                                    //     colors: true,
                                    //     printTime: true,
                                    //   ),
                                    // );
                                    // logger.e(result);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        duration: const Duration(milliseconds: 2000),
                                        backgroundColor: Colors.white,
                                        elevation: 0.0,
                                        padding: EdgeInsets.symmetric(horizontal: 30.0.w),
                                        margin: EdgeInsets.only(
                                          bottom: MediaQuery.of(context).size.height - 130,
                                        ),
                                        content: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 12.0.h),
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.circular(4.0),
                                            border: Border.all(color: StaticColor.snackbarColor, width: 1),
                                          ),
                                          child: Row(
                                            children: [
                                              Image.asset('assets/signin/snackbar_ok_icon.png', width: 24.0.w, height: 24.0.h),
                                              SizedBox(width: 8.0.w),
                                              Expanded(
                                                child: Text('인증에 성공했어요, 회원가입이 완료되었습니다',
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 14.0.sp, color: StaticColor.snackbarColor, fontWeight: FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                    context.read<SigninProvider>().policyCheckStateChange([false, false, false, false, false]);
                                    context.read<SigninProvider>().emailPasswordButtonStateChange(false);
                                    context.read<SigninProvider>().stepChangeState([true, false, false, false]);
                                    context.read<SigninProvider>().genderChangeState([false, false]);
                                    context.read<SigninProvider>().basicInfoButtonStateChange(false, '');
                                    /// 맨 처음 페이지로.
                                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
                                    // Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));

                                  /// 인증번호 일치하지 않을 때,
                                  } else {
                                    context.read<SigninProvider>().authValidateChange(true);
                                  }
                                } else {
                                  // context.read<SigninProvider>().resendButtonState(false);
                                }
                              }),

                          /// text form field validate 관련 height 변화에 대응한 유효시간 텍스트 위치 조정
                          data.authValidate == true || data.timeValidate == true ? const SizedBox.shrink() : Container(height: 20),
                        ],
                      ),
                    ),
                  ),
                  Consumer<SigninProvider>(
                    builder: (context, data, child) => Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text(remainText,
                            style: TextStyle(
                                fontSize: 12, color: data.timeValidate == true ? StaticColor.textErrorColor : StaticColor.grey60077))),
                  ),
                ],
              ),
              Consumer<SigninProvider>(
                builder: (context, data, child) => data.timeValidate == true || data.authValidate == true
                    ? Padding(
                        padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 32.0.h),
                        child: Material(
                          color: StaticColor.mainSoft,
                          borderRadius: BorderRadius.circular(8.0),
                          child: InkWell(
                            onTap: () async {
                              await PhoneAuthModel().phoneAuthRequest(widget.phoneNumber.toString());
                              authNumberController.text = '';
                              context.read<SigninProvider>().timeValidateChange(false);
                              context.read<SigninProvider>().authValidateChange(false);
                              startTimer();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    duration: const Duration(milliseconds: 2000),
                                    backgroundColor: Colors.white,
                                    elevation: 0.0,
                                    padding: EdgeInsets.symmetric(horizontal: 30.0.w),
                                    margin: EdgeInsets.only(
                                      bottom: MediaQuery.of(context).size.height - 130,
                                    ),
                                    content: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(4.0),
                                          border: Border.all(color: StaticColor.snackbarColor, width: 1),
                                        ),
                                        child: Row(children: [
                                          Image.asset('assets/signin/snackbar_ok_icon.png', width: 24.0.w, height: 24.0.h),
                                          const SizedBox(width: 8),
                                          Text('인증번호를 재발송 해드렸어요',
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                                  TextStyle(fontSize: 14.0.sp, color: StaticColor.snackbarColor, fontWeight: FontWeight.w500)),
                                        ]))),
                              );
                            },
                            borderRadius: BorderRadius.circular(8.0), // inkwell effect's borderradius
                            child: SizedBox(
                              height: 56.0.h,
                              child: Center(
                                  child:
                                      Text('인증번호 재발송하기', style: TextStyle(fontSize: 16.0.sp, color: Colors.white, fontWeight: FontWeight.w700))),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
