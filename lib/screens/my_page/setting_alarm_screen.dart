import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/my_page/setting_alarm_push.dart';
import 'package:sense_flutter_application/views/my_page/setting_alarm_view.dart';
import 'package:sense_flutter_application/views/my_page/setting_alarm_marketing_view.dart';

class SettingAlarmScreen extends StatefulWidget {
  const SettingAlarmScreen({super.key});

  @override
  State<SettingAlarmScreen> createState() => _SettingAlarmScreenState();
}

class _SettingAlarmScreenState extends State<SettingAlarmScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          bottom: false,
          child: Column(
            children: [
              SettingAlarmHeader(),
              Container(
                width: double.infinity,
                height: 1.0.h,
                color: StaticColor.grey300E0,
              ),
              SettingAlarmPush(),
              SettingAlarmMarketing(),
              // WithdrawalDescription(),
              // WithdrawalLoginView(),
              // SettingContent(),
            ],
          ),
        ),
      ),
    );
  }
}
