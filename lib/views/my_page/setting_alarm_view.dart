import 'package:flutter/material.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';

class SettingAlarmHeader extends StatefulWidget {
  const SettingAlarmHeader({super.key});

  @override
  State<SettingAlarmHeader> createState() => _SettingAlarmHeaderState();
}

class _SettingAlarmHeaderState extends State<SettingAlarmHeader> {
  @override
  Widget build(BuildContext context) {
    return HeaderMenu(backCallback: backCallback, title: '알림');
  }

  void backCallback() {
    Navigator.of(context).pop();
  }
}
