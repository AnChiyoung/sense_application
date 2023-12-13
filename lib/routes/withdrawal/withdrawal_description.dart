import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WithdrawalDescription extends StatefulWidget {
  const WithdrawalDescription({super.key});

  @override
  State<WithdrawalDescription> createState() => _WithdrawalDescriptionState();
}

class _WithdrawalDescriptionState extends State<WithdrawalDescription> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 20.0.w,
        vertical: 24.h,
      ),
      child: SizedBox(
        child: Text(
          '탈퇴를 위해\n본인인증을 해주세요',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            height: 26.h / 20.sp,
          ),
        ),
      ),
    );
  }
}
