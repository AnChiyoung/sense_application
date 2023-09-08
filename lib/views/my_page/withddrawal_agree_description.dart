import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';

class WithdrawalAgreeDescription extends StatefulWidget {
  const WithdrawalAgreeDescription({super.key});

  @override
  State<WithdrawalAgreeDescription> createState() => _WithdrawalAgreeDescriptionState();
}

class _WithdrawalAgreeDescriptionState extends State<WithdrawalAgreeDescription> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: Column(
        children: [
          ContentDescription(description: '아래 내용을\n확인해 주세요'),
          SizedBox(height: 16.0.h),
          WithdrawalGuideDescription(),
          SizedBox(height: 48.0.h),
        ],
      ),
    );
  }
}

class WithdrawalGuideDescription extends StatelessWidget {
  const WithdrawalGuideDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      overflow: TextOverflow.ellipsis,
      maxLines: 18,
      strutStyle: StrutStyle(fontSize: 14.0.sp),
      text: TextSpan(
        text: '1. 등록한 연락처 및 개인 정보는 모두 삭제되고, 복구할 수 없습니다.\n2. 탈퇴 후 30일 간은 같은 계정으로 재가입이 불가능합니다.\n3. 작성한 리뷰, 댓글, 별점 정보는 삭제되지 않습니다.\n4. 생성한 이벤트, 친구 정보가 모두 삭제되어 복구할 수 없습니다.',
        style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400),
      )
    );
  }
}
