import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/my_page/my_page_provider.dart';

class WithdrawalAgreeButton extends StatefulWidget {
  const WithdrawalAgreeButton({super.key});

  @override
  State<WithdrawalAgreeButton> createState() => _WithdrawalAgreeButtonState();
}

class _WithdrawalAgreeButtonState extends State<WithdrawalAgreeButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Consumer<MyPageProvider>(
            builder: (context, data, child) {

              bool agreeState = data.agree;

              return Flexible(
                flex: 1,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0.h),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: agreeState == true ? StaticColor.mainSoft : StaticColor.grey400BB,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text('탈퇴', style: TextStyle(fontSize: 14.0.sp, color: Colors.white, fontWeight: FontWeight.w700), textAlign: TextAlign.center,),
                    ),
                  ),
                ),
              );
            }
          ),

          SizedBox(width: 12.0.w),
          Flexible(
            flex: 1,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: StaticColor.grey200EE,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text('취소', style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700), textAlign: TextAlign.center),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
