import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/user/user_model.dart';
import 'package:sense_flutter_application/public_widget/empty_user_profile.dart';
import 'package:sense_flutter_application/utils/utility.dart';
import 'package:sense_flutter_application/views/my_page/my_info_update_moreinfo.dart';
import 'package:sense_flutter_application/views/my_page/my_page_provider.dart';
import 'package:toast/toast.dart';

class MyInfoUpdateContent extends StatefulWidget {
  final int page;
  final double? topPadding;
  const MyInfoUpdateContent({super.key, required this.page, this.topPadding});

  @override
  State<MyInfoUpdateContent> createState() => _MyInfoUpdateContentState();
}

class _MyInfoUpdateContentState extends State<MyInfoUpdateContent> with TickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this, initialIndex: widget.page);
    // 나중에 삭제 예정. additional_info랑 분기처리
    context.read<MyPageProvider>().setPrevRoute(MyPagePrevRouteEnum.fromMyPage, false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  controller: controller,
                  labelColor: StaticColor.mainSoft,
                  labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
                  unselectedLabelColor: StaticColor.grey70055,
                  indicatorWeight: 2,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(color: StaticColor.mainSoft, width: 3.0),
                  ),
                  unselectedLabelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                  tabs: [
                    SizedBox(
                      height: 37.0.h,
                      child: const Tab(
                        text: '기본정보',
                      ),
                    ),
                    SizedBox(
                      height: 37.0.h,
                      child: const Tab(
                        text: '추가정보',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 1.0.h,
          color: StaticColor.grey300E0,
        ),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: [
              const BasicInfoField(),
              MyMoreInfo(topPadding: widget.topPadding),
            ],
          ),
        ),
      ],
    );
  }
}

class ProfileImageField extends StatefulWidget {
  final String? profileImageString;
  const ProfileImageField({super.key, this.profileImageString});

  @override
  State<ProfileImageField> createState() => _ProfileImageFieldState();
}

class _ProfileImageFieldState extends State<ProfileImageField> {
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  String profileImageString = '';

  @override
  void initState() {
    profileImageString = widget.profileImageString ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyPageProvider>(builder: (context, data, child) {
      return Padding(
        padding: EdgeInsets.only(top: 24.0.h, bottom: 24.0.h),
        child: SizedBox(
          width: 80.0,
          height: 80.0,
          child: GestureDetector(
            onTap: () async {
              image = await _picker.pickImage(source: ImageSource.gallery);
              if (image == null) return;
              if (!context.mounted) return;
              context.read<MyPageProvider>().xfileStateChange(image);
              context.read<MyPageProvider>().doesActiveBasicButton();
            },
            child: UserProfileImage(
                profileImageUrl: profileImageString, selectImage: data.selectImage),
          ),
        ),
      );
    });
  }
}

class BasicInfoField extends StatefulWidget {
  const BasicInfoField({super.key});

  @override
  State<BasicInfoField> createState() => _BasicInfoFieldState();
}

class _BasicInfoFieldState extends State<BasicInfoField> {
  late Future loadFuture;

  Future<UserModel> _fetchData() async {
    return await UserRequest().userInfoRequest();
  }

  @override
  void initState() {
    super.initState();
    context.read<MyPageProvider>().resetState();
    loadFuture = _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.done) {
              UserModel userModel = snapshot.data ?? UserModel();
              context.read<MyPageProvider>().initUserMe(userModel, false);
              return Stack(
                fit: StackFit.expand,
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                      child: Column(
                        children: [
                          ProfileImageField(profileImageString: userModel.profileImageString),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '이름',
                              style: TextStyle(
                                fontSize: 16.0.sp,
                                color: StaticColor.grey70055,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0.h),
                          const BasicInfoName(),
                          SizedBox(height: 24.0.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '연락처',
                              style: TextStyle(
                                fontSize: 16.0.sp,
                                color: StaticColor.grey70055,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0.h),
                          const BasicInfoPhoneNumber(),
                          SizedBox(height: 24.0.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '생년월일',
                              style: TextStyle(
                                fontSize: 16.0.sp,
                                color: StaticColor.grey70055,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0.h),
                          const BasicInfoBirthday(),
                          // SizedBox(height: 24.0.h),
                          // Align(
                          //   alignment: Alignment.centerLeft,
                          //   child: Text(
                          //     '소개',
                          //     style: TextStyle(
                          //       fontSize: 16.0.sp,
                          //       color: StaticColor.grey70055,
                          //       fontWeight: FontWeight.w700,
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(height: 8.0.h),
                          // Container(
                          //   width: double.infinity,
                          //   padding: EdgeInsets.symmetric(vertical: 8.0.h),
                          //   decoration: BoxDecoration(
                          //     color: StaticColor.grey100F6,
                          //     borderRadius: BorderRadius.circular(4.0),
                          //   ),
                          //   child: Center(
                          //     child: Text(
                          //       '소개 글이 없습니다.',
                          //       style: TextStyle(
                          //         fontSize: 14.0.sp,
                          //         color: StaticColor.grey70055,
                          //         fontWeight: FontWeight.w400,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(height: 48.0.h),
                        ],
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: MyInfoUpdateButton(),
                  ),
                ],
              );
            }

            // if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.asset(
                'assets/lottie/loading.json',
                width: 150,
                height: 150,
              ),
            );
          }

          if (snapshot.hasError) {
            return const SizedBox.shrink();
          }

          return const SizedBox.shrink();
        });
  }
}

class BasicInfoName extends StatefulWidget {
  const BasicInfoName({super.key});

  @override
  State<BasicInfoName> createState() => _BasicInfoNameState();
}

class _BasicInfoNameState extends State<BasicInfoName> {
  late TextEditingController nameController;
  late FocusNode nameFocus;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    nameFocus = FocusNode();
    nameController.text = context.read<MyPageProvider>().username;
  }

  @override
  void dispose() {
    nameController.dispose();
    nameFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      textInputAction: TextInputAction.done,
      focusNode: nameFocus,
      maxLines: 1,
      maxLength: 14,
      style: TextStyle(
        color: Colors.black,
        fontSize: 14.sp,
        height: 20 / 14,
      ),
      decoration: InputDecoration(
        counterText: '',
        filled: true,
        fillColor: StaticColor.loginInputBoxColor,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.0.w,
          vertical: 10.0.h,
        ),
        hintText: '변경할 이름을 입력해 주세요',
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: StaticColor.loginHintTextColor,
          fontWeight: FontWeight.w400,
          height: 20 / 14,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(
              4.0.r,
            ),
          ),
        ),
      ),
      onFieldSubmitted: (value) {
        nameFocus.unfocus();
      },
      onChanged: (value) {
        context.read<MyPageProvider>().onChangeUsername(value, false);
      },
      onTapOutside: (event) => nameFocus.unfocus(),
    );
  }
}

class BasicInfoPhoneNumber extends StatefulWidget {
  const BasicInfoPhoneNumber({super.key});

  @override
  State<BasicInfoPhoneNumber> createState() => _BasicInfoPhoneNumberState();
}

class _BasicInfoPhoneNumberState extends State<BasicInfoPhoneNumber> {
  late TextEditingController phoneNumberController;
  late FocusNode phoneNumberFocus;
  MyPageProvider? _provider; // Provider에 대한 참조를 저장하기 위한 변수

  @override
  void initState() {
    super.initState();
    phoneNumberController = TextEditingController();
    phoneNumberFocus = FocusNode();
    phoneNumberController.text = context.read<MyPageProvider>().phone;
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    phoneNumberFocus.dispose();
    super.dispose();
  }

  // TextFormField!!
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: TextFormField(
                enabled: context.select<MyPageProvider, bool>((value) => !value.isValidAuthCode),
                controller: phoneNumberController,
                focusNode: phoneNumberFocus,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  height: 20 / 14,
                ),
                inputFormatters: [KoreanPhoneNumberTextInputFormatter()],
                decoration: InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: StaticColor.grey100F6,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.0.w,
                    vertical: 10.0.h,
                  ),
                  hintText: '연락처를 입력해주세요.',
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: StaticColor.loginHintTextColor,
                    fontWeight: FontWeight.w400,
                    height: 20 / 14,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        4.0.r,
                      ),
                    ),
                  ),
                ),
                onFieldSubmitted: (value) {
                  phoneNumberFocus.unfocus();
                },
                onChanged: (value) {
                  context.read<MyPageProvider>().onChangePhone(value, true);
                },
                onTapOutside: (event) => phoneNumberFocus.unfocus(),
              ),
            ),
            SizedBox(width: 12.0.w),
            ElevatedButton(
              onPressed: context.select<MyPageProvider, bool>(
                (value) => value.phoneFieldEnabled,
              )
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(milliseconds: 2000),
                          backgroundColor: Colors.transparent,
                          elevation: 0.0,
                          padding: EdgeInsets.symmetric(horizontal: 30.0.w),
                          content: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 12.0.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(color: StaticColor.snackbarColor, width: 1),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/signin/snackbar_ok_icon.png',
                                  width: 24.0.w,
                                  height: 24.0.h,
                                ),
                                SizedBox(width: 8.0.w),
                                Expanded(
                                  child: Text(
                                    context.read<MyPageProvider>().isSended
                                        ? '인증번호가 재발송되었습니다.'
                                        : '인증번호가 발송되었습니다.',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14.0.sp,
                                      color: StaticColor.snackbarColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );

                      context.read<MyPageProvider>().sendAuthCode(phoneNumberController.text);
                      context.read<MyPageProvider>().startTimer();
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: StaticColor.markerDefaultColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0.r),
                ),
                fixedSize: Size(77.0.w, 40.0.h),
              ),
              child: SizedBox(
                child: Center(
                  child: Text(
                    context.select<MyPageProvider, bool>(
                      (value) => value.isSended,
                    )
                        ? '재인증'
                        : '인증',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      height: 20 / 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0.h),
        if (context.select<MyPageProvider, bool>(
          (value) => value.isSended,
        ))
          const PhoneAuthCheck(),
      ],
    );
  }
}

class PhoneAuthCheck extends StatefulWidget {
  const PhoneAuthCheck({super.key});

  @override
  State<PhoneAuthCheck> createState() => _PhoneAuthCheckState();
}

class _PhoneAuthCheckState extends State<PhoneAuthCheck> {
  // text field variable
  late TextEditingController authController;
  late FocusNode authFocus;

// Provider에 대한 참조를 저장하기 위한 변수
  MyPageProvider? _provider;

  @override
  void initState() {
    super.initState();
    authController = TextEditingController();
    authFocus = FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Provider의 인스턴스를 얻어서 멤버 변수에 저장
    _provider = Provider.of<MyPageProvider>(context, listen: false);
  }

  @override
  void dispose() {
    authController.dispose();
    authFocus.dispose();
    _provider?.resetTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const errorBorderStyle = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
      ),
    );

    // phoneAuthErrorMessage가 빈 문자열인지 여부를 확인하는 함수를 작성합니다.
    bool isPhoneAuthError(BuildContext context) {
      return context.select<MyPageProvider, String>((value) => value.phoneAuthErrorMessage) != '';
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                enabled: context.select<MyPageProvider, bool>((value) => !value.isValidAuthCode),
                controller: authController,
                focusNode: authFocus,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  height: 20 / 14,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
                decoration: InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: StaticColor.grey100F6,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.0.w,
                    vertical: 10.0.h,
                  ),
                  hintText: '인증번호 4자리를 입력해주세요.',
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: StaticColor.loginHintTextColor,
                    fontWeight: FontWeight.w400,
                    height: 20 / 14,
                  ),
                  focusedBorder: isPhoneAuthError(context) ? errorBorderStyle : null,
                  enabledBorder: isPhoneAuthError(context) ? errorBorderStyle : null,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        4.0.r,
                      ),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: StaticColor.errorColor,
                      width: 2.0.w,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        4.0.r,
                      ),
                    ),
                  ),
                ),
                onFieldSubmitted: (value) {
                  authFocus.unfocus();
                },
                onChanged: (value) {
                  context.read<MyPageProvider>().onChangeAuthCode(value, true);
                },
                onTapOutside: (event) => authFocus.unfocus(),
              ),
              SizedBox(height: 4.0.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer<MyPageProvider>(
                    builder: (context, data, child) {
                      if (data.phoneAuthErrorMessage.isNotEmpty) {
                        return Text(
                          data.phoneAuthErrorMessage,
                          style: TextStyle(
                            color: StaticColor.errorColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            height: 20 / 12,
                          ),
                        );
                      }

                      if (data.phoneAuthSuccessMessage.isNotEmpty) {
                        return Text(
                          data.phoneAuthSuccessMessage,
                          style: TextStyle(
                            color: StaticColor.successColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            height: 20 / 12,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  Text(
                    context.select<MyPageProvider, String>((value) => value.remainingText),
                    style: TextStyle(
                      color: StaticColor.grey70055,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      height: 20 / 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 12.0.w),
        ElevatedButton(
          onPressed: context.select<MyPageProvider, bool>((value) => value.authCodeFieldEnabled)
              ? () {
                  context.read<MyPageProvider>().checkAuthCode(
                        context.read<MyPageProvider>().phone,
                        int.parse(authController.text),
                      );
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: StaticColor.markerDefaultColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0.r),
            ),
            fixedSize: Size(77.0.w, 40.0.h),
          ),
          child: SizedBox(
            child: Center(
              child: Text(
                '확인',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  height: 20 / 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BasicInfoBirthday extends StatefulWidget {
  const BasicInfoBirthday({super.key});

  @override
  State<BasicInfoBirthday> createState() => _BasicInfoBirthdayState();
}

class _BasicInfoBirthdayState extends State<BasicInfoBirthday> {
  late TextEditingController yearController;
  late TextEditingController monthController;
  late TextEditingController dayController;

  late FocusNode yearFocus;
  late FocusNode monthFocus;
  late FocusNode dayFocus;

  String year = '-';
  String month = '-';
  String day = '-';

  String selectDate = '';
  int yearValue = 0;
  int monthValue = 0;
  int dayValue = 0;
  DateTime initdate = DateTime.now();

  @override
  void initState() {
    super.initState();
    yearController = TextEditingController();
    monthController = TextEditingController();
    dayController = TextEditingController();
    yearFocus = FocusNode();
    monthFocus = FocusNode();
    dayFocus = FocusNode();
    String initBirthday = '2020-01-01';
    List<String> result = initBirthday.split('-');
    yearValue = int.parse(result.elementAt(0));
    monthValue = int.parse(result.elementAt(1));
    dayValue = int.parse(result.elementAt(2));
    yearController.text = yearValue.toString();
    monthController.text = monthValue.toString();
    dayController.text = dayValue.toString();
    context.read<MyPageProvider>().birthdayInit(initBirthday);
  }

  @override
  void dispose() {
    yearController.dispose();
    monthController.dispose();
    dayController.dispose();
    yearFocus.dispose();
    monthFocus.dispose();
    dayFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Flexible(
        flex: 1,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 10.0.h),
          width: double.infinity,
          // height: 50,
          decoration: BoxDecoration(
            color: StaticColor.grey100F6,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: TextFormField(
            controller: yearController,
            autofocus: false,
            focusNode: yearFocus,
            textInputAction: TextInputAction.next,
            maxLines: 1,
            maxLength: 4,
            textAlignVertical: TextAlignVertical.center,
            keyboardType: TextInputType.number,
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
                labelStyle: TextStyle(
                    fontSize: 14.sp, color: StaticColor.mainSoft, fontWeight: FontWeight.w500),
                hintText: '연도',
                hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: StaticColor.loginHintTextColor,
                    fontWeight: FontWeight.w400),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  borderSide: BorderSide.none,
                )),
            onEditingComplete: () {
              context.read<MyPageProvider>().birthdayStateChange(
                  '${yearController.text.toString()}-${context.read<MyPageProvider>().month}-${context.read<MyPageProvider>().day}');
            },
            onTap: () {
              // showModalBottomSheet(context: context, backgroundColor: Colors.transparent, builder: (context) {
              //   return Wrap(children: [dateSelect(context)]);
              // });
              // showDialog(
              //   context: context,
              //   builder: (BuildContext context) {
              //     return AlertDialog(
              //       title: Text("연도를 선택해주세요"),
              //       content: Container( // Need to use container to add size constraint.
              //         width: 300,
              //         height: 300,
              //         child: YearPicker(
              //           firstDate: DateTime(DateTime.now().year - 100, 1),
              //           lastDate: DateTime(DateTime.now().year, 1),
              //           initialDate: DateTime.now(),
              //           // save the selected date to _selectedDate DateTime variable.
              //           // It's used to set the previous selected date when
              //           // re-showing the dialog.
              //           selectedDate: DateTime.now(),
              //           onChanged: (DateTime dateTime) {
              //             // close the dialog when year is selected.
              //             Navigator.pop(context);
              //
              //             // Do something with the dateTime selected.
              //             // Remember that you need to use dateTime.year to get the year
              //           },
              //         ),
              //       ),
              //     );
              //   },
              // );
            },
          ),
          // child: Text(title, style: TextStyle(fontSize: 14.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w500)),
        ),
      ),
      SizedBox(width: 12.0.w),
      Flexible(
        flex: 1,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 10.0.h),
          width: double.infinity,
          // height: 50,
          decoration: BoxDecoration(
            color: StaticColor.grey100F6,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: TextFormField(
            controller: monthController,
            autofocus: false,
            focusNode: monthFocus,
            textInputAction: TextInputAction.next,
            maxLines: 1,
            maxLength: 2,
            textAlignVertical: TextAlignVertical.center,
            keyboardType: TextInputType.number,
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
                labelStyle: TextStyle(
                    fontSize: 14.sp, color: StaticColor.mainSoft, fontWeight: FontWeight.w500),
                hintText: '월',
                hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: StaticColor.loginHintTextColor,
                    fontWeight: FontWeight.w400),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  borderSide: BorderSide.none,
                )),
            onEditingComplete: () {
              context.read<MyPageProvider>().birthdayStateChange(
                  '${context.read<MyPageProvider>().year}-${monthController.text.toString()}-${context.read<MyPageProvider>().day}');
            },
            onTap: () {
              //   showDialog(
              //     context: context,
              //     builder: (BuildContext context) {
              //       return AlertDialog(
              //         title: Text("월을 선택해주세요"),
              //         content: Container( // Need to use container to add size constraint.
              //           width: 300,
              //           height: 300,
              //           child: YearPicker(
              //             firstDate: DateTime(DateTime.now().year, 1),
              //             lastDate: DateTime(DateTime.now().year + 12, 1),
              //             initialDate: DateTime.now(),
              //             // save the selected date to _selectedDate DateTime variable.
              //             // It's used to set the previous selected date when
              //             // re-showing the dialog.
              //             selectedDate: DateTime.now(),
              //             onChanged: (DateTime dateTime) {
              //               // close the dialog when year is selected.
              //               Navigator.pop(context);
              //
              //               // Do something with the dateTime selected.
              //               // Remember that you need to use dateTime.year to get the year
              //             },
              //           ),
              //         ),
              //       );
              //     },
              //   );
            },
          ),
          // child: Text(title, style: TextStyle(fontSize: 14.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w500)),
        ),
      ),
      SizedBox(width: 12.0.w),
      Flexible(
        flex: 1,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 10.0.h),
          width: double.infinity,
          // height: 50,
          decoration: BoxDecoration(
            color: StaticColor.grey100F6,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: TextFormField(
            controller: dayController,
            autofocus: false,
            focusNode: dayFocus,
            textInputAction: TextInputAction.next,
            maxLines: 1,
            maxLength: 2,
            textAlignVertical: TextAlignVertical.center,
            keyboardType: TextInputType.number,
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
                labelStyle: TextStyle(
                    fontSize: 14.sp, color: StaticColor.mainSoft, fontWeight: FontWeight.w500),
                hintText: '일',
                hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: StaticColor.loginHintTextColor,
                    fontWeight: FontWeight.w400),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  borderSide: BorderSide.none,
                )),
            onEditingComplete: () {
              context.read<MyPageProvider>().birthdayStateChange(
                  '${context.read<MyPageProvider>().year}-${context.read<MyPageProvider>().month}-${dayController.text.toString()}');
            },
          ),
          // child: Text(title, style: TextStyle(fontSize: 14.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w500)),
        ),
      )
    ]);
  }

  Widget dateSelect(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  if (selectDate == '') {
                    initdate = DateTime.now();
                    yearController.text = DateTime.utc(DateTime.now().year).toString();
                    monthController.text = DateTime.utc(DateTime.now().month).toString();
                    dayController.text = DateTime.utc(DateTime.now().day).toString();
                  } else {
                    yearController.text = selectDate.substring(0, 4);
                    monthController.text = selectDate.substring(4, 2);
                    dayController.text = selectDate.substring(6, 2);
                    initdate = DateTime.utc(int.parse(selectDate.substring(0, 4)),
                        int.parse(selectDate.substring(5, 7)), int.parse(selectDate.substring(8)));
                  }
                  Navigator.of(context).pop();
                },
                child: const Text('확인'),
              ),
            ),
            SizedBox(
                width: double.infinity,
                height: 250,
                child: CupertinoTheme(
                  data: const CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(fontSize: 22, color: Colors.black),
                    ),
                  ),
                  child: CupertinoDatePicker(
                    minimumYear: 1900,
                    maximumYear: DateTime.now().year,
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (date) {
                      // selectDate = date.toString().substring(0, 10);
                    },
                    mode: CupertinoDatePickerMode.date,
                  ),
                )),
          ],
        ),
      ),
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
      child: Column(children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text('성별',
                style: TextStyle(
                    fontSize: 16.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700))),
        SizedBox(height: 8.0.h),
        Consumer<MyPageProvider>(builder: (context, data, child) {
          List<bool> genderState = data.updateGenderState;

          return Row(children: [
            Flexible(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  context.read<MyPageProvider>().genderStateChange(0);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 10.0.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: genderState.elementAt(0) == true
                        ? StaticColor.mainSoft
                        : StaticColor.grey100F6,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Center(
                      child: Text('남',
                          style: TextStyle(
                              fontSize: 14.0.sp,
                              color: genderState.elementAt(0) == true
                                  ? Colors.white
                                  : StaticColor.grey400BB,
                              fontWeight: FontWeight.w500))),
                ),
              ),
            ),
            SizedBox(width: 12.0.w),
            Flexible(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  context.read<MyPageProvider>().genderStateChange(1);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 10.0.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: genderState.elementAt(1) == true
                        ? StaticColor.mainSoft
                        : StaticColor.grey100F6,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Center(
                      child: Text('여',
                          style: TextStyle(
                              fontSize: 14.0.sp,
                              color: genderState.elementAt(1) == true
                                  ? Colors.white
                                  : StaticColor.grey400BB,
                              fontWeight: FontWeight.w500))),
                ),
              ),
            ),
          ]);
        })
      ]),
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
    return Consumer<MyPageProvider>(builder: (context, data, child) {
      bool state = data.basicButton;

      return SizedBox(
        width: double.infinity,
        height: 76.0.h,
        child: ElevatedButton(
          onPressed: () async {
            if (state == true) {
              bool updateResult = await UserRequest().userBasicInfoUpdate(context);
              if (updateResult == true) {
                context.read<MyPageProvider>().updateInfoInit();
                Navigator.of(context).pop();
              } else {}
            } else {}
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: state == true ? StaticColor.mainSoft : StaticColor.grey400BB,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 56,
                child: Center(
                  child: Text(
                    '저장',
                    style: TextStyle(
                      fontSize: 16.0.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
