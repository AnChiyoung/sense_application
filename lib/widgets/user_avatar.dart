import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';

class UserAvatar extends StatelessWidget {
  final String? profileImageUrl;
  final double? size;
  const UserAvatar({super.key, this.profileImageUrl = '', this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? 80.h,
      height: size ?? 80.h,
      decoration: BoxDecoration(shape: BoxShape.circle, color: StaticColor.grey100F6),
      child: profileImageUrl == '' ? emptyProfile() : userProfile(),
    );
  }

  Widget userProfile() {
    return CachedNetworkImage(
      imageUrl: profileImageUrl.toString(),
      fit: BoxFit.fitHeight,
      imageBuilder: (context, imageProvider) => Container(
        width: size ?? 80.h,
        height: size ?? 80.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget emptyProfile() {
    return Center(
      child: Image.asset(
        'assets/icons/user.png',
        width: size == null ? 40.h : size! / 2,
        height: size == null ? 40.h : size! / 2,
      ),
    );
  }
}
