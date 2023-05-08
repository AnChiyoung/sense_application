import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';

class EmptyUserProfile extends StatelessWidget {
  const EmptyUserProfile({Key? key}) : super(key: key);

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
      child: Image.asset('assets/feed/empty_user_inner.png', width: 20, height: 20),
    );
  }
}
