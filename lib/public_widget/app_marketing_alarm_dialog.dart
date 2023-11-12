import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';

class AppMarketingAlarmDialog extends StatefulWidget {
  Function? action;
  bool isAgree;
  AppMarketingAlarmDialog({super.key, this.action, required this.isAgree});

  @override
  State<AppMarketingAlarmDialog> createState() => _AppMarketingAlarmDialogState();
}

class _AppMarketingAlarmDialogState extends State<AppMarketingAlarmDialog> {

  String marketingRecieveDate = '';

  @override
  void initState() {
    DateTime dateTime = DateTime.now();
    marketingRecieveDate = '${dateTime.year}년 ${dateTime.month}월 ${dateTime.day}일 ';
    super.initState();
  }

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
            Text('마케팅 정보 수신 동의', style: TextStyle(fontSize: 18.0.sp, color: StaticColor.grey80033, fontWeight: FontWeight.w700)),
            SizedBox(height: 8.0.h),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400),
                    children: [
                      TextSpan(text: marketingRecieveDate),
                      const TextSpan(text: "센스 '마케팅 정보 수신'에 "),
                      TextSpan(text: widget.isAgree == true ? '동의하셨습니다.' : '거부하셨습니다.'),
                    ]
                )
            ),
          ],
        ),
        //
        content: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 28, bottom: 18),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: StaticColor.categoryUnselectedColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categorySelectedColor, elevation: 0.0),
              child: Text('확인', style: TextStyle(fontSize: 14.0.sp, color: Colors.white, fontWeight: FontWeight.w400)),
            ),
          ),
        ),
        actions: null,
      ),
    );
  }
}
