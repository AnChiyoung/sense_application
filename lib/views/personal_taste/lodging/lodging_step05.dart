import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/personal_taste/taste_provider.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';

class LodgingStep05 extends StatefulWidget {
  const LodgingStep05({super.key});

  @override
  State<LodgingStep05> createState() => _LodgingStep05State();
}

class _LodgingStep05State extends State<LodgingStep05> {
  TextEditingController lodgingStep05Controller = TextEditingController();

  @override
  void initState() {
    /// when back step, save bundle data
    lodgingStep05Controller.text = context.read<TasteProvider>().lodgingStep05;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 24.0.h),
      child: Column(
        children: [
          ContentDescription(presentPage: 5, totalPage: 6, description: '선호하는 숙소에 대해\n자유롭게 적어주세요',),
          SizedBox(height: 24.0.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 7.0.h),
            decoration: BoxDecoration(
              color: StaticColor.grey100F6,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: TextFormField(
                controller: lodgingStep05Controller,
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
                    hintText: 'ex) 이국적인 느낌을 제대로 느낄 수 있는 곳이 있었으면 좋겠어요.',
                    hintStyle: TextStyle(fontSize: 14.sp, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderSide: BorderSide.none,
                    )
                ),
                onChanged: (v) {
                  context.read<TasteProvider>().lodgingStep05Change(v);
                }
            ),
            // child: Text(memoString, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}