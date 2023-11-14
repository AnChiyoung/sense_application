import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';

class PreferenceResultHeader extends StatelessWidget {
  final String title;

  const PreferenceResultHeader({
    super.key,
    this.title = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0.h,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: StaticColor.grey200EE,
            width: 1.0,
          ),
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.0.sp,
                  fontWeight: FontWeight.w500,
                  height: 24 / 16,
                  color: StaticColor.black90015,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12.0.w,
                vertical: 10.0.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _backButton(context: context),
                  _shareButton(context: context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _shareButton({required BuildContext context}) {
    void onTap() {}

    return SizedBox(
      width: 40.0.h,
      height: 40.0.h,
      child: IconButton(
        splashRadius: 20.0.r,
        padding: EdgeInsets.zero,
        onPressed: onTap,
        icon: Image.asset(
          'assets/icons/share.png',
          width: 24.0.h,
          height: 24.0.h,
        ),
      ),
    );
  }

  Widget _backButton({required BuildContext context}) {
    void onTap() {
      Navigator.pop(context);
    }

    return SizedBox(
      width: 40.0.h,
      height: 40.0.h,
      child: IconButton(
        splashRadius: 20.0.r,
        padding: EdgeInsets.zero,
        onPressed: onTap,
        icon: Image.asset(
          'assets/store/back_arrow_thin.png',
          width: 24.0.h,
          height: 24.0.h,
        ),
      ),
    );
  }
}
