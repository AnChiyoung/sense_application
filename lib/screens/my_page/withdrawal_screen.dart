import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/my_page/withdrawal_description.dart';
import 'package:sense_flutter_application/views/my_page/withdrawal_header.dart';
import 'package:sense_flutter_application/views/my_page/withdrawal_login_view.dart';

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
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          bottom: false,
          child: Column(
            children: [
              WithdrawalHeader(),
              Container(
                width: double.infinity,
                height: 1.0.h,
                color: StaticColor.grey300E0,
              ),
              WithdrawalDescription(),
              WithdrawalLoginView(),
              // SettingContent(),
            ],
          ),
        ),
      ),
    );
  }
}