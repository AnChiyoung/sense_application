import 'package:flutter/material.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';

class WithdrawalHeader extends StatefulWidget {
  const WithdrawalHeader({super.key});

  @override
  State<WithdrawalHeader> createState() => _WithdrawalHeaderState();
}

class _WithdrawalHeaderState extends State<WithdrawalHeader> {
  @override
  Widget build(BuildContext context) {
    return HeaderMenu(backCallback: backCallback);
  }

  void backCallback() {
    Navigator.of(context).pop();
  }
}
