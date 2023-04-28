import 'package:flutter/material.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';

class SigninHeader extends StatefulWidget {
  bool? backButton = false;
  String? title = '';
  bool? closeButton = false;

  SigninHeader({Key? key, this.backButton, this.title, this.closeButton}) : super(key: key);

  @override
  State<SigninHeader> createState() => _SigninHeaderState();
}

class _SigninHeaderState extends State<SigninHeader> {
  @override
  Widget build(BuildContext context) {
    return HeaderMenu(backCallback: widget.backButton == true ? backCallback : null, title: widget.title, closeCallback: widget.closeButton == true ? closeCallback : null);
  }

  void backCallback() {
    Navigator.of(context).pop();
  }

  void closeCallback() {
  }
}
