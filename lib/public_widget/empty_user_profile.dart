import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';

class UserProfileImage extends StatelessWidget {
  String? profileImageUrl = '';
  UserProfileImage({Key? key, this.profileImageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return profileImageUrl == null || profileImageUrl == '' ? Image.asset('assets/feed/empty_user_profile.png', width: 32, height: 32)
          : CachedNetworkImage(
              imageUrl: profileImageUrl.toString(),
              fit: BoxFit.fitHeight,
              imageBuilder: (context, imageProvider) => Container(
                width: 35.0,
                height: 35.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: imageProvider, fit: BoxFit.cover))));
  }
}
