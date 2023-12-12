import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';

class WithdrawalDescription extends StatefulWidget {
  const WithdrawalDescription({super.key});

  @override
  State<WithdrawalDescription> createState() => _WithdrawalDescriptionState();
}

class _WithdrawalDescriptionState extends State<WithdrawalDescription> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: const ContentDescription(description: '탈퇴를 위해\n본인인증을 해주세요'));
  }
}
