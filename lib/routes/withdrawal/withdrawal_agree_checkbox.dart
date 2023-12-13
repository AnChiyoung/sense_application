import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/my_page/my_page_provider.dart';

class WithdrawalAgreeCheckbox extends StatefulWidget {
  const WithdrawalAgreeCheckbox({super.key});

  @override
  State<WithdrawalAgreeCheckbox> createState() => _WithdrawalAgreeCheckboxState();
}

class _WithdrawalAgreeCheckboxState extends State<WithdrawalAgreeCheckbox> {

  String checkImageAssetsString = 'assets/signin/policy_check_empty.png';


  @override
  Widget build(BuildContext context) {
    return Consumer<MyPageProvider>(
      builder: (context, data, child) {

        bool agreeState = data.agree;

        return Padding(
          padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, bottom: 162.0.h),
          child: GestureDetector(
            onTap: () {
              context.read<MyPageProvider>().withdrawalAgreeChange(!agreeState);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 13.0.h),
              decoration: BoxDecoration(
                color: agreeState == true ? StaticColor.mainSoft : StaticColor.grey100F6,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(checkImageAssetsString, width: 20.0.w, height: 20.0.h, color: agreeState == true ? Colors.white : null),
                    SizedBox(width: 12.0.w),
                    Text('유의사항을 모두 확인했고, 동의합니다.', style: TextStyle(fontSize: 14.0.sp, color: agreeState == true ? Colors.white : StaticColor.grey70055, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
