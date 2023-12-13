import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileImage extends StatelessWidget {
  final String? profileImageUrl;
  final XFile? selectImage;
  final double? size;
  const UserProfileImage({super.key, this.profileImageUrl = '', this.selectImage, this.size});

  @override
  Widget build(BuildContext context) {
    if (profileImageUrl == '') {
      if (selectImage == null) {
        return Image.asset('assets/feed/empty_user_profile.png', width: 32, height: 32);
      } else {
        return ClipRRect(
          borderRadius: BorderRadius.circular(300),
          child: Image.file(File(selectImage!.path), fit: BoxFit.fitHeight, width: 48, height: 48),
        );
      }
    } else {
      if (selectImage == null) {
        // return Container();
        return CachedNetworkImage(
          imageUrl: profileImageUrl.toString(),
          fit: BoxFit.fitHeight,
          imageBuilder: (context, imageProvider) => Container(
            width: size ?? 40.0,
            height: size ?? 40.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
        );
      } else {
        // return Container();
        return ClipRRect(
          borderRadius: BorderRadius.circular(300),
          child: Image.file(File(selectImage!.path), fit: BoxFit.fitHeight, width: 48, height: 48),
        );
      }
    }
  }
}
