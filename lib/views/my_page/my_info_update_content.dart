import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/public_widget/empty_user_profile.dart';
import 'package:sense_flutter_application/views/my_page/my_page_provider.dart';

class MyInfoUpdateContent extends StatefulWidget {
  const MyInfoUpdateContent({super.key});

  @override
  State<MyInfoUpdateContent> createState() => _MyInfoUpdateContentState();
}

class _MyInfoUpdateContentState extends State<MyInfoUpdateContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileImageField(),
        BasicInfoField(),
        GenderField(),
      ],
    );
  }
}

class ProfileImageField extends StatefulWidget {
  const ProfileImageField({super.key});

  @override
  State<ProfileImageField> createState() => _ProfileImageFieldState();
}

class _ProfileImageFieldState extends State<ProfileImageField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 24.0.h),
      width: 80.0.w,
      height: 80.0.h,
      child: UserProfileImage(size: 80.0));
  }
}

class BasicInfoField extends StatefulWidget {
  const BasicInfoField({super.key});

  @override
  State<BasicInfoField> createState() => _BasicInfoFieldState();
}

class _BasicInfoFieldState extends State<BasicInfoField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text('기본정보', style: TextStyle(fontSize: 16.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700))),
          SizedBox(height: 8.0.h),
          BasicInfoName(),
          SizedBox(height: 12.0.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 10.0.h),
            width: double.infinity,
            decoration: BoxDecoration(
              color: StaticColor.grey100F6,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text('010-6630-0387', style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey400BB, fontWeight: FontWeight.w500)),
          ),
          SizedBox(height: 12.0.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 10.0.h),
            width: double.infinity,
            decoration: BoxDecoration(
              color: StaticColor.grey100F6,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text('1996.12.30', style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey400BB, fontWeight: FontWeight.w500)),
          ),
          SizedBox(height: 12.0.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 10.0.h),
            width: double.infinity,
            decoration: BoxDecoration(
              color: StaticColor.grey100F6,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text('sense@sense.com', style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey400BB, fontWeight: FontWeight.w500)),
          ),
        ]
      ),
    );
  }
}

class BasicInfoName extends StatefulWidget {
  const BasicInfoName({super.key});

  @override
  State<BasicInfoName> createState() => _BasicInfoNameState();
}

class _BasicInfoNameState extends State<BasicInfoName> {

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 10.0.h),
      width: double.infinity,
      // height: 50,
      decoration: BoxDecoration(
        color: StaticColor.grey100F6,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: TextFormField(
          controller: nameController,
          autofocus: false,
          textInputAction: TextInputAction.next,
          maxLines: 1,
          maxLength: 14,
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(color: Colors.black, fontSize: 14.sp),
          cursorHeight: 15.h,
          decoration: InputDecoration(
              counterText: '',
              filled: true,
              fillColor: StaticColor.loginInputBoxColor,
              // fillColor: Colors.black,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 1.0.h),
              alignLabelWithHint: false,
              labelStyle: TextStyle(fontSize: 14.sp, color: StaticColor.mainSoft, fontWeight: FontWeight.w500),
              hintText: '변경할 이름을 입력해 주세요',
              hintStyle: TextStyle(fontSize: 14.sp, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                borderSide: BorderSide.none,
              )
          ),
          onChanged: (v) {
            // context.read<CreateEventProvider>().titleChange(v);
          }
      ),
      // child: Text(title, style: TextStyle(fontSize: 14.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w500)),
    );
  }
}

class GenderField extends StatefulWidget {
  const GenderField({super.key});

  @override
  State<GenderField> createState() => _GenderFieldState();
}

class _GenderFieldState extends State<GenderField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 24.0.h),
      child: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text('성별', style: TextStyle(fontSize: 16.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700))),
            SizedBox(height: 8.0.h),
            Consumer<MyPageProvider>(
              builder: (context, data, child) {

                List<bool> genderState = data.updateGenderState;

                return Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            context.read<MyPageProvider>().genderStateChange([true, false]);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 10.0.h),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: genderState.elementAt(0) == true ? StaticColor.mainSoft : StaticColor.grey100F6,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Center(child: Text('남', style: TextStyle(fontSize: 14.0.sp, color: genderState.elementAt(0) == true ? Colors.white : StaticColor.grey400BB, fontWeight: FontWeight.w500))),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.0.w),
                      Flexible(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            context.read<MyPageProvider>().genderStateChange([false, true]);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 10.0.h),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: genderState.elementAt(1) == true ? StaticColor.mainSoft : StaticColor.grey100F6,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Center(child: Text('여', style: TextStyle(fontSize: 14.0.sp, color: genderState.elementAt(1) == true ? Colors.white : StaticColor.grey400BB, fontWeight: FontWeight.w500))),
                          ),
                        ),
                      ),
                    ]
                );
              }
            )
          ]
      ),
    );
  }
}

class MyInfoUpdateButton extends StatefulWidget {
  const MyInfoUpdateButton({super.key});

  @override
  State<MyInfoUpdateButton> createState() => _MyInfoUpdateButtonState();
}

class _MyInfoUpdateButtonState extends State<MyInfoUpdateButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 76,
      child: ElevatedButton(
          onPressed: () {

          },
          style: ElevatedButton.styleFrom(
              // backgroundColor: buttonState == true
              //     ? StaticColor.categorySelectedColor
              //     : StaticColor.unSelectedColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
                height: 56,
                child: Center(
                    child: Text('저장',
                        style: TextStyle(
                            fontSize: 16.0.sp, color: Colors.white, fontWeight: FontWeight.w700)))),
          ])),
    );
  }
}
