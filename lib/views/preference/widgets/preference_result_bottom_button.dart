import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';

class PreferenceResultBottomButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const PreferenceResultBottomButton({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    double safeBottomPadding = MediaQuery.of(context).padding.bottom;

    return SizedBox(
      width: double.infinity,
      height: 56.0.h + safeBottomPadding,
      child: Material(
        color: StaticColor.mainSoft,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.only(bottom: safeBottomPadding),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.0.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
