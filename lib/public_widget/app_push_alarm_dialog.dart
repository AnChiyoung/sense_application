import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_settings/open_settings.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/my_page/my_page_provider.dart';

class AppPushAlarmDialog extends StatefulWidget {
  Function? action;
  AppPushAlarmDialog({super.key, this.action});

  @override
  State<AppPushAlarmDialog> createState() => _AppPushAlarmDialogState();
}

class _AppPushAlarmDialogState extends State<AppPushAlarmDialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: AlertDialog(
        backgroundColor: Colors.white,
        insetPadding: const EdgeInsets.all(10),
        contentPadding: EdgeInsets.zero,
        // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)),
        //Dialog Main Title
        title: Column(
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400),
                  children: [
                    TextSpan(text: '앱 푸시 알림 수신을 위해 휴대폰 '),
                    TextSpan(text: '설정>알림', style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
                    TextSpan(text: '에서\n센스 알림을 허용해주세요.'),
                  ]
              )
            ),
          ],
        ),
        //
        content: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 28, bottom: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: StaticColor.categoryUnselectedColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.read<MyPageProvider>().pushAlarmChange(false);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categoryUnselectedColor, elevation: 0.0),
                    child: Text('취소', style: TextStyle(fontSize: 14.0.sp, color: StaticColor.contactLoadTextColor, fontWeight: FontWeight.w400)),
                  ),
                ),
              ),
              const SizedBox(
                  width: 8
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: StaticColor.categoryUnselectedColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      OpenSettings.openWIFISetting();
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categorySelectedColor, elevation: 0.0),
                    child: Text('설정', style: TextStyle(fontSize: 14.0.sp, color: Colors.white, fontWeight: FontWeight.w400)),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: null,
      ),
    );
  }
}
