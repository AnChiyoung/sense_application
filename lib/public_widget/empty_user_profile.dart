import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sense_flutter_application/constants/public_color.dart';

class UserProfileImage extends StatelessWidget {
  String? profileImageUrl = '';
  XFile? selectImage;
  UserProfileImage({Key? key, this.profileImageUrl, this.selectImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if(profileImageUrl == null || profileImageUrl == '') {
      if(selectImage == null) {
        return Image.asset('assets/feed/empty_user_profile.png', width: 32, height: 32);
      } else {
        return ClipRRect(
          borderRadius: BorderRadius.circular(300),
          child: Image.file(File(selectImage!.path), fit: BoxFit.fitHeight),
        );
      }
    } else {
      if(selectImage == null) {
        return CachedNetworkImage(
          imageUrl: profileImageUrl.toString(),
          fit: BoxFit.fitHeight,
          imageBuilder: (context, imageProvider) => Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
        );
      } else {
        return ClipRRect(
          borderRadius: BorderRadius.circular(300),
          child: Image.file(File(selectImage!.path), fit: BoxFit.fitHeight),
        );
      }
    }
  }
}
