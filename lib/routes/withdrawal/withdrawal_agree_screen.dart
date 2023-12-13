import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/routes/withdrawal/withddrawal_agree_description.dart';
import 'package:sense_flutter_application/routes/withdrawal/withdrawal_agree_button.dart';
import 'package:sense_flutter_application/routes/withdrawal/withdrawal_agree_checkbox.dart';
import 'package:sense_flutter_application/routes/withdrawal/withdrawal_agree_header.dart';

class WithdrawalAgreeScreen extends StatefulWidget {
  const WithdrawalAgreeScreen({super.key});

  @override
  State<WithdrawalAgreeScreen> createState() => _WithdrawalAgreeScreenState();
}

class _WithdrawalAgreeScreenState extends State<WithdrawalAgreeScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const WithdrawalAgreeHeader(),
                Container(
                  width: double.infinity,
                  height: 1.0.h,
                  color: StaticColor.grey300E0,
                ),
                const WithdrawalAgreeDescription(),
                const WithdrawalAgreeCheckbox(),
                const WithdrawalAgreeButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
