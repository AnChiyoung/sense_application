import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/preference/preference_provider.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';

class FoodStep06 extends StatefulWidget {
  const FoodStep06({super.key});

  @override
  State<FoodStep06> createState() => _FoodStep06State();
}

class _FoodStep06State extends State<FoodStep06> {
  final TextEditingController _step06Controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    /// when back step, save bundle data
    _step06Controller.text = context.read<PreferenceProvider>().foodLikeMemo;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _step06Controller.selection = TextSelection(
        baseOffset: 0,
        extentOffset: _step06Controller.text.length,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 24.0.h),
      child: Column(
        children: [
          const ContentDescription(
            presentPage: 6,
            totalPage: 7,
            description: '선호하는 음식에 대해\n자유롭게 적어주세요',
          ),
          SizedBox(height: 24.0.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 7.0.h),
            decoration: BoxDecoration(
              color: StaticColor.grey100F6,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: TextFormField(
              controller: _step06Controller,
              autofocus: true,
              textInputAction: TextInputAction.next,
              maxLines: 7,
              maxLength: 300,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
              ),
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
                labelStyle: TextStyle(
                    fontSize: 14.sp, color: StaticColor.mainSoft, fontWeight: FontWeight.w500),
                hintText: 'ex) 불맛을 잘 느낄 수 있는 자극적인 요리가 좋아요!',
                hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: StaticColor.loginHintTextColor,
                    fontWeight: FontWeight.w400),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (v) {
                context.read<PreferenceProvider>().changeLikeMemo(v, notify: true);
              },
              //
              onTapOutside: (v) {
                FocusScope.of(context).unfocus();
              },
            ),
          ),
        ],
      ),
    );
  }
}
