import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/preference/preference_model.dart';

class PreferenceElementCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  const PreferenceElementCard({super.key, required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 75.0.w,
          height: 75.0.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
          ),
          clipBehavior: Clip.hardEdge,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 8.0.h),
        SizedBox(
          width: 75.0.w,
          child: Center(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.0.sp,
                fontWeight: FontWeight.w500,
                height: 20 / 14,
                color: StaticColor.grey80033,
              ),
            ),
          ),
        ),
        // Text(
        //   title,
        //   style: TextStyle(
        //     fontSize: 14.0.sp,
        //     fontWeight: FontWeight.w500,
        //     height: 20 / 14,
        //     color: StaticColor.grey80033,
        //   ),
        // ),
      ],
    );
  }
}

class PreferenceElementSection extends StatelessWidget {
  final String title;
  final List<PreferenceElement> list;
  const PreferenceElementSection({
    super.key,
    required this.title,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.0.sp,
            fontWeight: FontWeight.w700,
            height: 24 / 16,
            color: StaticColor.grey80033,
          ),
        ),
        SizedBox(height: 8.0.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...list.map(
                (typeItem) => Row(
                  children: [
                    PreferenceElementCard(
                      imageUrl: typeItem.imageUrl,
                      title: typeItem.title,
                    ),
                    SizedBox(width: 12.0.w),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.0.h),
      ],
    );
  }
}
