import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';

class ContentDescription extends StatelessWidget {
  final int? presentPage;
  final int? totalPage;
  final String? description;

  const ContentDescription({
    super.key,
    this.presentPage,
    this.totalPage,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              presentPage == null ? '' : presentPage.toString(),
              style: TextStyle(
                fontSize: 14.0.sp,
                color: StaticColor.mainSoft,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              totalPage == null ? '' : ' / ${totalPage.toString()}',
              style: TextStyle(
                fontSize: 14.0.sp,
                color: StaticColor.signinTotalPageColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0.h),
        Text(
          description == null ? '' : description.toString(),
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 20.0.sp,
            color: StaticColor.grey80033,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
