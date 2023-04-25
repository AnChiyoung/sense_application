import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/models/login/login_provider.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';

class SignupHeader extends StatefulWidget with PreferredSizeWidget{
  const SignupHeader({super.key});

  @override
  _SignupHeaderView createState() => _SignupHeaderView();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SignupHeaderView extends State<SignupHeader> {
  @override
  Widget build(BuildContext context) {
    return HeaderMenu(backCallback: backCallback, title: '');
  }

  void backCallback() {
    Navigator.of(context).pop();
  }
}
