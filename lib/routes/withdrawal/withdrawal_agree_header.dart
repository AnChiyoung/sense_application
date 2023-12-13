import 'package:flutter/material.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';

class WithdrawalAgreeHeader extends StatefulWidget {
  const WithdrawalAgreeHeader({super.key});

  @override
  State<WithdrawalAgreeHeader> createState() => _WithdrawalAgreeHeaderState();
}

class _WithdrawalAgreeHeaderState extends State<WithdrawalAgreeHeader> {
  @override
  Widget build(BuildContext context) {
    return HeaderMenu(backCallback: backCallback);
  }

  void backCallback() {
    Navigator.of(context).pop();
  }
}
