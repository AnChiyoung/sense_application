import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/create_event/create_event_improve_provider.dart';

class RecommendAddTextInputSection extends StatefulWidget {
  const RecommendAddTextInputSection({super.key});

  @override
  State<RecommendAddTextInputSection> createState() => _RecommendAddTextInputSectionState();
}

class _RecommendAddTextInputSectionState extends State<RecommendAddTextInputSection> {

  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, bottom: 20.0.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 7.0.h),
        decoration: BoxDecoration(
          color: StaticColor.grey100F6,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: TextFormField(
            controller: controller,
            autofocus: false,
            textInputAction: TextInputAction.next,
            maxLines: 7,
            maxLength: 300,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(color: Colors.black, fontSize: 14.sp),
            cursorHeight: 15.h,
            decoration: InputDecoration(
                counterText: '',
                filled: true,
                fillColor: StaticColor.loginInputBoxColor,
                // fillColor: Colors.black,
                isDense: true,
                // contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                contentPadding: EdgeInsets.symmetric(vertical: 3.0.h),
                alignLabelWithHint: false,
                labelStyle: TextStyle(fontSize: 14.sp, color: StaticColor.mainSoft, fontWeight: FontWeight.w500),
                hintText: '추천 내용을 입력해주세요',
                hintStyle: TextStyle(fontSize: 14.sp, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  borderSide: BorderSide.none,
                )
            ),
            onChanged: (v) {
              context.read<CreateEventImproveProvider>().recommendCommentChange(v);
            }
        ),
        // child: Text(memoString, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
