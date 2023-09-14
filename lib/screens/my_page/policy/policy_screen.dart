import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/my_page/policy/policy_content.dart';
import 'package:sense_flutter_application/views/my_page/policy/policy_header.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({super.key});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
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
              PolicyHeader(),
              Container(
                width: double.infinity,
                height: 1.0.h,
                color: StaticColor.grey300E0,
              ),
              // PolicyContent(),
              // WithdrawalDescription(),
              // WithdrawalLoginView(),
              // SettingContent(),
            ],
          ),
        ),
      ),
    );
  }
}
