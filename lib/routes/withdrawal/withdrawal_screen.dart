import 'package:flutter/material.dart';
import 'package:sense_flutter_application/routes/withdrawal/withdrawal_description.dart';
import 'package:sense_flutter_application/routes/withdrawal/withdrawal_header.dart';
import 'package:sense_flutter_application/routes/withdrawal/withdrawal_login_view.dart';

class WithdrawalScreen extends StatefulWidget {
  const WithdrawalScreen({super.key});

  @override
  State<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: const Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          bottom: false,
          child: Column(
            children: [
              WithdrawalHeader(),
              WithdrawalDescription(),
              WithdrawalLoginView(),
            ],
          ),
        ),
      ),
    );
  }
}
