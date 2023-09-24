import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/public_widget/logout_dialog.dart';
import 'package:sense_flutter_application/screens/login/login_screen.dart';
import 'package:sense_flutter_application/screens/my_page/my_info_update_screen.dart';
import 'package:sense_flutter_application/screens/my_page/policy/policy_screen.dart';
import 'package:sense_flutter_application/screens/my_page/setting_alarm_screen.dart';
import 'package:sense_flutter_application/screens/my_page/withdrawal_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingContent extends StatefulWidget {
  const SettingContent({super.key});

  @override
  State<SettingContent> createState() => _SettingContentState();
}

class _SettingContentState extends State<SettingContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: StaticColor.grey200EE,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.0.h),
            child: Column(
              children: [
                SettingEditProfile(),
                SettingMoreInfo(),
                SettingAlarm(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0.h),
            child: Column(
              children: [
                SettingContactReload(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0.h),
            child: Column(
              children: [
                SettingPolicy(),
                SettingAppVersion(),
                // SettingAppVersionTest(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0.h),
            child: Column(
              children: [
                SettingLogout(),
                SettingWithdrawal(),
              ],
            )),
        ],
      ) ,
    );
  }
}

class SettingEditProfile extends StatefulWidget {
  const SettingEditProfile({super.key});

  @override
  State<SettingEditProfile> createState() => _SettingEditProfileState();
}

class _SettingEditProfileState extends State<SettingEditProfile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => MyInfoUpdate(page: 0)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 14.0.h),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('프로필 편집', style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
            Image.asset('assets/my_page/caret_right.png', width: 24, height: 24),
          ],
        ),
      ),
    );
  }
}

class SettingMoreInfo extends StatefulWidget {
  const SettingMoreInfo({super.key});

  @override
  State<SettingMoreInfo> createState() => _SettingMoreInfoState();
}

class _SettingMoreInfoState extends State<SettingMoreInfo> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => MyInfoUpdate(page: 1)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 14.0.h),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('추가정보', style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
            Image.asset('assets/my_page/caret_right.png', width: 24, height: 24),
          ],
        ),
      ),
    );
  }
}


class SettingAlarm extends StatefulWidget {
  const SettingAlarm({super.key});

  @override
  State<SettingAlarm> createState() => _SettingAlarmState();
}

class _SettingAlarmState extends State<SettingAlarm> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => SettingAlarmScreen()));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 14.0.h),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('알림', style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
            Image.asset('assets/my_page/caret_right.png', width: 24, height: 24),
          ],
        ),
      ),
    );
  }
}

class SettingContactReload extends StatefulWidget {
  const SettingContactReload({super.key});

  @override
  State<SettingContactReload> createState() => _SettingContactReloadState();
}

class _SettingContactReloadState extends State<SettingContactReload> with TickerProviderStateMixin{

  late AnimationController animationController;
  bool forwardDirection = false;
  double rotationAngle = 0.0;
  double oldAngle = 0.0;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animationController.value = 0.0;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      //초기화
      rotationAngle = 0.0;
      oldAngle = 0.0;
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  String updateDate = '8월 8일 오후6:20';
  String month = '';
  String day = '';
  String periodic = '오전';
  String hour = '';
  String minute = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // setState(() {
        //   DateTime updateCheck = DateTime.now();
        //   month = updateCheck.month.toString();
        //   day = updateCheck.day.toString();
        //   hour = updateCheck.hour.toString();
        //   int.parse(hour) < 12 && int.parse(hour) >= 0 ? periodic = '오전' : {periodic = '오후', hour = (int.parse(hour) - 12).toString()};
        //   minute = updateCheck.minute.toString();
        //   updateDate = '$month월 $day일 $periodic$hour:$minute';
        // });

        DateTime updateCheck;
        if (isStopAnimation()) {
          startRotateAnimation(true);
          Future.delayed(const Duration(seconds: 3)).then((value) => {
            stopRotateAnimation(),
            updateCheck = DateTime.now(),
            month = updateCheck.month.toString(),
            day = updateCheck.day.toString(),
            hour = updateCheck.hour.toString(),
            int.parse(hour) < 12 && int.parse(hour) >= 0 ? periodic = '오전' : {periodic = '오후', hour = (int.parse(hour) - 12).toString()},
            if(updateCheck.minute.toInt() >= 0 && updateCheck.minute.toInt() < 10) {
              minute = '0${updateCheck.minute.toString()}'
            } else {
              minute = updateCheck.minute.toString()
            },
            updateDate = '$month월 $day일 $periodic$hour:$minute',
          });
        } else {
          /// 다 불러왔을 때 정지
          stopRotateAnimation();
        }

      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 14.0.h),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('연락처 새로고침', style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
            Row(
              children: [
                Text(updateDate, style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                SizedBox(width: 20.0.w),
                AnimatedBuilder(
                  animation: animationController,
                  builder: (BuildContext context, Widget? child) {
                    final value = animationController.value;
                    double step = 0.0;
                    if (oldAngle > value) {
                      step = (1.0 - oldAngle) + value;
                    } else {
                      step = value - oldAngle;
                    }
                    oldAngle = value;
                    if (forwardDirection) {
                      rotationAngle += step;
                    } else {
                      rotationAngle -= step;
                    }
                    final angle = rotationAngle * (pi * 2);
                    return Transform.rotate(
                      angle: angle * 1, // 속도
                      child: Image.asset('assets/my_page/reload.png', width: 20, height: 20),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  startRotateAnimation(bool direction) async {
    forwardDirection = direction;
    oldAngle = animationController.value;
    animationController.repeat();
  }

  isStopAnimation() {
    return !animationController.isAnimating;
  }

  stopRotateAnimation() {
    animationController.stop();
    setState(() {});
  }
}

class SettingPolicy extends StatelessWidget {
  const SettingPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => PolicyScreen()));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 14.0.h),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('약관 및 개인정보의 처리동의', style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
            Image.asset('assets/my_page/caret_right.png', width: 24, height: 24),
          ],
        ),
      ),
    );
  }
}

class SettingAppVersion extends StatelessWidget {
  const SettingAppVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 14.0.h),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('버전 1.1.13(최신)', style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}

class SettingAppVersionTest extends StatelessWidget {
  const SettingAppVersionTest({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=com.runners.sense.sense_flutter_application'));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 14.0.h),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('TEST : 버전 1.1.0', style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 4.0.h),
              decoration: BoxDecoration(
                color: StaticColor.grey100F6,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Text('업데이트', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.mainSoft, fontWeight: FontWeight.w400)),
            )
          ],
        ),
      ),
    );
  }
}

class SettingLogout extends StatefulWidget {
  const SettingLogout({super.key});

  @override
  State<SettingLogout> createState() => _SettingLogoutState();
}

class _SettingLogoutState extends State<SettingLogout> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /// logout
        showDialog(
          context: context,
          //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
          barrierDismissible: false,
          builder: (BuildContext context) {
            return LogoutDialog(action: logoutAction);
          }
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 14.0.h),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('로그아웃', style: TextStyle(fontSize: 14.0.sp, color: StaticColor.textErrorColor, fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }

  void logoutAction() {
    LoginRequest.storage.delete(key: 'id');
    LoginRequest.storage.delete(key: 'username');
    LoginRequest.storage.delete(key: 'profileImage');
    PresentUserInfo.id = -1;
    PresentUserInfo.username = '';
    PresentUserInfo.profileImage = '';
    // Navigator.popUntil(context, (route) => route.isFirst);
    // Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
  }
}

class SettingWithdrawal extends StatefulWidget {
  const SettingWithdrawal({super.key});

  @override
  State<SettingWithdrawal> createState() => _SettingWithdrawalState();
}

class _SettingWithdrawalState extends State<SettingWithdrawal> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => WithdrawalScreen()));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 14.0.h),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('회원탈퇴', style: TextStyle(fontSize: 14.0.sp, color: StaticColor.textErrorColor, fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}
