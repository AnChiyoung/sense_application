import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';

class SelectablePreferenceElement extends StatelessWidget {
  final String title;
  final String imageUrl;
  final bool isSelected;
  final void Function() onTap;
  final int selectedNumber;
  const SelectablePreferenceElement({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.isSelected,
    required this.onTap,
    this.selectedNumber = -1,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            children: [
              /// image
              SizedBox(
                width: 100.0.h,
                height: 100.0.h,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                  ),
                ),
              ),

              /// border
              Container(
                width: 100.0.h,
                height: 100.0.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: isSelected
                      ? Border.all(
                          color: StaticColor.mainSoft,
                          width: 4.0.w,
                        )
                      : null,
                ),
              ),

              /// number
              selectedNumber > -1
                  ? Container(
                      width: 32.0.w,
                      height: 32.0.h,
                      padding: EdgeInsets.only(left: 8.0.w, top: 8.0.h),
                      child: Container(
                        decoration: BoxDecoration(
                          color: StaticColor.mainSoft,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            (selectedNumber + 1).toString(),
                            style: TextStyle(
                              fontSize: 14.0.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          SizedBox(height: 8.0.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.0.sp,
              color: isSelected ? StaticColor.mainSoft : StaticColor.black90015,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
