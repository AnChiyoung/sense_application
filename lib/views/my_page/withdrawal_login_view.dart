import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/screens/my_page/withdrawal_agree_screen.dart';

class WithdrawalLoginView extends StatefulWidget {
  const WithdrawalLoginView({super.key});

  @override
  State<WithdrawalLoginView> createState() => _WithdrawalLoginViewState();
}

class _WithdrawalLoginViewState extends State<WithdrawalLoginView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WithdrawalEmailLoginView(),
        WithdrawalKakaoLoginView(),
      ],
    );
  }
}

class WithdrawalEmailLoginView extends StatefulWidget {
  const WithdrawalEmailLoginView({super.key});

  @override
  State<WithdrawalEmailLoginView> createState() => _WithdrawalEmailLoginViewState();
}

class _WithdrawalEmailLoginViewState extends State<WithdrawalEmailLoginView> {

  TextEditingController withdrawalEmailController = TextEditingController();
  TextEditingController withdrawalPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final safeAreaTopPadding = MediaQuery.of(context).padding.top;
    final safeAreaBottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 16.0.h, bottom: 80.0.h),
        child: Column(
          children: [
            /// email input field
            Container(
              height: 48.0.h,
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              decoration: BoxDecoration(
                color: StaticColor.loginInputBoxColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: TextField(
                controller: withdrawalEmailController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: '이메일 주소',
                  hintStyle: TextStyle(fontSize: 14.0.sp, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                  border: InputBorder.none,
                ),
                onTap: () {},
              ),
            ),
            SizedBox(height: 8.0.h),
            /// password input field
            Container(
              height: 48.0.h,
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              decoration: BoxDecoration(
                color: StaticColor.loginInputBoxColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: TextField(
                controller: withdrawalPasswordController,
                obscureText: true,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: '비밀번호',
                  hintStyle: TextStyle(fontSize: 14.0.sp, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                  border: InputBorder.none,
                ),
                onTap: () {},
              ),
            ),
            SizedBox(height: 16.0.h),
            Material(
              color: StaticColor.mainSoft,
              borderRadius: BorderRadius.circular(4.0),
              child: InkWell(
                onTap: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => WithdrawalAgreeScreen()));
                },
                borderRadius: BorderRadius.circular(4.0),
                child: SizedBox(
                  height: 50.0.h,
                  child: Center(child: Text('로그인', style: TextStyle(fontSize: 14.0.sp, color: Colors.white, letterSpacing: -0.22, fontWeight: FontWeight.w600))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WithdrawalKakaoLoginView extends StatefulWidget {
  const WithdrawalKakaoLoginView({super.key});

  @override
  State<WithdrawalKakaoLoginView> createState() => _WithdrawalKakaoLoginViewState();
}

class _WithdrawalKakaoLoginViewState extends State<WithdrawalKakaoLoginView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
      child: Material(
        color: StaticColor.loginKakaoColor,
        borderRadius: BorderRadius.circular(4.0),
        child: InkWell(
          onTap: () async {
            Navigator.push(context, MaterialPageRoute(builder: (_) => WithdrawalAgreeScreen()));
          },
          borderRadius: BorderRadius.circular(4.0), // inkwell effect's borderradius
          child: SizedBox(
            height: 50.0.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/login/kakao_simple_icon.png', width: 24.0.w, height: 24.0.h),
                SizedBox(width: 4.0.w),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.0.h),
                  child: Text('카카오로 로그인',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14.0.sp,
                          // textBaseline: TextBaseline.alphabetic,
                          color: StaticColor.loginTextColor02,
                          fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
