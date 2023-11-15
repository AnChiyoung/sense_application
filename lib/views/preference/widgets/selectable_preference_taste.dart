import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';

class SelectablePreferenceTaste extends StatelessWidget {
  final String title;
  final String subtitle;
  final int level;
  final String imageUrl;
  final String assetPath;
  final bool isSelected;
  final void Function()? onTap;

  const SelectablePreferenceTaste({
    super.key,
    required this.title,
    required this.subtitle,
    required this.level,
    required this.imageUrl,
    required this.assetPath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> image = [];
    for (int i = 0; i < 5; i++) {
      image.add(
        Image.asset(
          assetPath,
          width: 24.0.h,
          height: 24.0.h,
          color: isSelected && level > i ? null : StaticColor.grey400BB,
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15.0.h),
                child: Image.asset(
                  isSelected
                      ? 'assets/signin/policy_check_done.png'
                      : 'assets/signin/policy_check_empty.png',
                  width: 24.0.w,
                  height: 24.0.h,
                ),
              ),
              SizedBox(width: 8.0.w),
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        height: 88.0.h,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16.0.h),
                      height: 88.0.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.black.withOpacity(0.5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// up line
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 2.0.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Text(
                                      '$level단계',
                                      style: TextStyle(
                                        fontSize: 12.0.sp,
                                        color: StaticColor.grey70055,
                                        fontWeight: FontWeight.w400,
                                        height: 18 / 12,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.0.w),
                                  Text(
                                    title,
                                    style: TextStyle(
                                      fontSize: 14.0.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      height: 20 / 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          SizedBox(height: 6.0.h),

                          /// down line
                          Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: 14.0.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              height: 20 / 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned.fill(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 12.0.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: image,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0.h),
        ],
      ),
    );
  }
}
