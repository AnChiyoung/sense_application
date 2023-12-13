import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/routes/edit_profile/edit_profile_provider.dart';
import 'package:sense_flutter_application/utils/utility.dart';

class PhoneField extends StatefulWidget {
  const PhoneField({super.key});

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  late TextEditingController phoneNumberController;
  late FocusNode phoneNumberFocus;

  @override
  void initState() {
    super.initState();
    phoneNumberController = TextEditingController();
    phoneNumberFocus = FocusNode();
    phoneNumberController.text = context.read<EditProfileProvider>().phone;
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    phoneNumberFocus.dispose();
    super.dispose();
  }

  // TextFormField!!
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40.h,
          child: Row(
            children: [
              Flexible(
                child: TextFormField(
                  enabled:
                      context.select<EditProfileProvider, bool>((value) => !value.isValidAuthCode),
                  controller: phoneNumberController,
                  focusNode: phoneNumberFocus,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                    height: 20.h / 14.sp,
                  ),
                  inputFormatters: [KoreanPhoneNumberTextInputFormatter()],
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    isDense: true,
                    counterText: '',
                    filled: true,
                    fillColor: StaticColor.grey100F6,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                    hintText: '연락처를 입력해주세요.',
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: StaticColor.loginHintTextColor,
                      fontWeight: FontWeight.w400,
                      height: 20.h / 14.sp,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          4.r,
                        ),
                      ),
                    ),
                  ),
                  cursorHeight: 20.h,
                  onFieldSubmitted: (value) {
                    phoneNumberFocus.unfocus();
                  },
                  onChanged: (value) {
                    context.read<EditProfileProvider>().onChangePhone(value, true);
                  },
                  onTapOutside: (event) => phoneNumberFocus.unfocus(),
                ),
              ),
              SizedBox(width: 12.w),
              SizedBox(
                height: 40.h,
                width: 77.w,
                child: ElevatedButton(
                  onPressed: context.select<EditProfileProvider, bool>(
                    (value) => value.phoneFieldEnabled,
                  )
                      ? () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(milliseconds: 2000),
                              backgroundColor: Colors.transparent,
                              elevation: 0.0,
                              padding: EdgeInsets.symmetric(horizontal: 30.w),
                              content: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4.0),
                                  border: Border.all(color: StaticColor.snackbarColor, width: 1),
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/signin/snackbar_ok_icon.png',
                                      width: 24.w,
                                      height: 24.h,
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: Text(
                                        context.read<EditProfileProvider>().isSended
                                            ? '인증번호가 재발송되었습니다.'
                                            : '인증번호가 발송되었습니다.',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: StaticColor.snackbarColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );

                          context
                              .read<EditProfileProvider>()
                              .sendAuthCode(phoneNumberController.text);
                          context.read<EditProfileProvider>().startTimer();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    backgroundColor: StaticColor.markerDefaultColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      context.select<EditProfileProvider, bool>(
                        (value) => value.isSended,
                      )
                          ? '재인증'
                          : '인증',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        height: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        if (context.select<EditProfileProvider, bool>(
          (value) => value.isSended,
        ))
          const PhoneAuthCheck(),
      ],
    );
  }
}

class PhoneAuthCheck extends StatefulWidget {
  const PhoneAuthCheck({super.key});

  @override
  State<PhoneAuthCheck> createState() => _PhoneAuthCheckState();
}

class _PhoneAuthCheckState extends State<PhoneAuthCheck> {
  // text field variable
  late TextEditingController authController;
  late FocusNode authFocus;

// Provider에 대한 참조를 저장하기 위한 변수
  EditProfileProvider? _provider;

  @override
  void initState() {
    super.initState();
    authController = TextEditingController();
    authFocus = FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Provider의 인스턴스를 얻어서 멤버 변수에 저장
    _provider = Provider.of<EditProfileProvider>(context, listen: false);
  }

  @override
  void dispose() {
    authController.dispose();
    authFocus.dispose();
    _provider?.resetTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const errorBorderStyle = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
      ),
    );

    // phoneAuthErrorMessage가 빈 문자열인지 여부를 확인하는 함수를 작성합니다.
    bool isPhoneAuthError(BuildContext context) {
      return context.select<EditProfileProvider, String>((value) => value.phoneAuthErrorMessage) !=
          '';
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 40.h,
                child: TextFormField(
                  enabled:
                      context.select<EditProfileProvider, bool>((value) => !value.isValidAuthCode),
                  controller: authController,
                  focusNode: authFocus,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                    height: 20.h / 14.sp,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                  ],
                  decoration: InputDecoration(
                    isDense: true,
                    counterText: '',
                    filled: true,
                    fillColor: StaticColor.grey100F6,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                    hintText: '인증번호 4자리를 입력해주세요.',
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: StaticColor.loginHintTextColor,
                      fontWeight: FontWeight.w400,
                      height: 20.h / 14.sp,
                    ),
                    focusedBorder: isPhoneAuthError(context) ? errorBorderStyle : null,
                    enabledBorder: isPhoneAuthError(context) ? errorBorderStyle : null,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          4.r,
                        ),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: StaticColor.errorColor,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          4.r,
                        ),
                      ),
                    ),
                  ),
                  onFieldSubmitted: (value) {
                    authFocus.unfocus();
                  },
                  onChanged: (value) {
                    context.read<EditProfileProvider>().onChangeAuthCode(value, true);
                  },
                  onTapOutside: (event) => authFocus.unfocus(),
                ),
              ),
              SizedBox(height: 4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer<EditProfileProvider>(
                    builder: (context, data, child) {
                      if (data.phoneAuthErrorMessage.isNotEmpty) {
                        return Text(
                          data.phoneAuthErrorMessage,
                          style: TextStyle(
                            color: StaticColor.errorColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            height: 20 / 12,
                          ),
                        );
                      }

                      if (data.phoneAuthSuccessMessage.isNotEmpty) {
                        return Text(
                          data.phoneAuthSuccessMessage,
                          style: TextStyle(
                            color: StaticColor.successColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            height: 20 / 12,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  Text(
                    context.select<EditProfileProvider, String>((value) => value.remainingText),
                    style: TextStyle(
                      color: StaticColor.grey70055,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      height: 20 / 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        SizedBox(
          width: 77.w,
          height: 40.h,
          child: ElevatedButton(
            onPressed:
                context.select<EditProfileProvider, bool>((value) => value.authCodeFieldEnabled)
                    ? () {
                        context.read<EditProfileProvider>().checkAuthCode(
                              context.read<EditProfileProvider>().phone,
                              int.parse(authController.text),
                            );
                      }
                    : null,
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
              backgroundColor: StaticColor.markerDefaultColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            child: SizedBox(
              child: Center(
                child: Text(
                  '확인',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
