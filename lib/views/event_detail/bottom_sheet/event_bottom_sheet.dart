import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';

class EventBottomSheet extends StatelessWidget {
  final String title;
  final Widget child;
  const EventBottomSheet({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600.0.h,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.0.h, bottom: 16.0.h),
            child: Container(
              width: 75.0.w,
              height: 4.0.w,
              decoration: BoxDecoration(color: StaticColor.bottomSheetHeaderMain, borderRadius: BorderRadius.all(Radius.circular(2.0.r))),
            ),
          ),
          Text(title, style: TextStyle(fontSize: 16.sp, color: StaticColor.black90015, fontWeight: FontWeight.w500)),
          SizedBox(height: 24.0.h),
          child
        ],
      ),
    );
  }
}