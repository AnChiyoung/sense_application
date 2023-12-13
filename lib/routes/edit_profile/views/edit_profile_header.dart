import 'package:flutter/material.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';

class EditProfileHeader extends StatefulWidget {
  const EditProfileHeader({super.key});

  @override
  State<EditProfileHeader> createState() => _EditProfileHeaderState();
}

class _EditProfileHeaderState extends State<EditProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return HeaderMenu(
      backCallback: backCallback,
      title: '프로필 편집',
      hasBorderBottom: true,
    );
  }

  void backCallback() {
    Navigator.of(context).pop();
  }
}
