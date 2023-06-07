import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';

class UserProfileImage extends StatelessWidget {
  String? profileImageUrl = '';
  UserProfileImage({Key? key, this.profileImageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: StaticColor.grey200EE,
        shape: BoxShape.circle,
      ),
      child: profileImageUrl == '' ? Image.asset('assets/feed/empty_user_inner.png', width: 20, height: 20)
          : Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: CachedNetworkImage(imageUrl: profileImageUrl.toString())),
    );
  }
}
