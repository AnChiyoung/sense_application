import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/user/user_model.dart';
import 'package:sense_flutter_application/public_widget/app_marketing_alarm_dialog.dart';
import 'package:sense_flutter_application/views/my_page/my_page_provider.dart';

class SettingAlarmMarketing extends StatefulWidget {
  const SettingAlarmMarketing({super.key});

  @override
  State<SettingAlarmMarketing> createState() => _SettingAlarmMarketingState();
}

class _SettingAlarmMarketingState extends State<SettingAlarmMarketing> {

  @override
  Widget build(BuildContext context) {
    return Consumer<MyPageProvider>(
      builder: (context, data, child) {

        bool marketingState = data.marketingAlarm;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('마케팅 정보 푸시 알림', style: TextStyle(fontSize: 16.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                  FlutterSwitch(
                    width: 48,
                    height: 24,
                    borderRadius: 12.0,
                    padding: 3,
                    toggleSize: 18,
                    activeColor: StaticColor.drawerToggleActiveColor,
                    inactiveColor: StaticColor.drawerToggleInactiveColor,
                    value: marketingState,
                    onToggle: (bool value) {
                      if(value == true) {
                        context.read<MyPageProvider>().marketingAlarmChange(true);
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AppMarketingAlarmDialog(isAgree: true);
                            }
                        );
                      } else {
                        context.read<MyPageProvider>().marketingAlarmChange(false);
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AppMarketingAlarmDialog(isAgree: false);
                            }
                        );
                      }
                      UserRequest().userAlarmInfoUpdate(context, 1);
                    },
                  ),
                ],
              ),
              SizedBox(height: 8.0.h),
              Text('앱을 통해 마케팅 정보를 받는 것에 동의합니다.', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey400BB, fontWeight: FontWeight.w400)),
            ],
          ),
        );
      }
    );
  }
}
