import 'package:flutter/material.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';

class PolicyHeader extends StatefulWidget {
  const PolicyHeader({super.key});

  @override
  State<PolicyHeader> createState() => _PolicyHeaderState();
}

class _PolicyHeaderState extends State<PolicyHeader> {
  @override
  Widget build(BuildContext context) {
    return HeaderMenu(backCallback: backCallback, title: '약관 및 개인정보 이용 동의');
  }

  void backCallback() {
    Navigator.of(context).pop();
  }
}
