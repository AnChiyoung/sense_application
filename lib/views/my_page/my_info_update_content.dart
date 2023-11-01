import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/user/user_model.dart';
import 'package:sense_flutter_application/public_widget/empty_user_profile.dart';
import 'package:sense_flutter_application/views/my_page/my_info_update_moreinfo.dart';
import 'package:sense_flutter_application/views/my_page/my_page_provider.dart';

class MyInfoUpdateContent extends StatefulWidget {
  int page;
  double? topPadding;
  MyInfoUpdateContent({super.key, required this.page, this.topPadding});

  @override
  State<MyInfoUpdateContent> createState() => _MyInfoUpdateContentState();
}

class _MyInfoUpdateContentState extends State<MyInfoUpdateContent> with TickerProviderStateMixin {

  late TabController controller;

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this, initialIndex: widget.page);
    super.initState();
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
                          text: '기본정보'
                      ),
                    ),
                    SizedBox(
                      height: 37.0.h,
                      child: const Tab(
                          text: '추가정보'
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
              BasicInfoField(),
              MyMoreInfo(topPadding: widget.topPadding),
            ],
          ),
        ),
      ],
    );
  }
}

class ProfileImageField extends StatefulWidget {
  String? profileImageString;
  ProfileImageField({super.key, this.profileImageString});

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
    return Consumer<MyPageProvider>(
      builder: (context, data, child) {
        return Padding(
          padding: EdgeInsets.only(top: 24.0.h, bottom: 24.0.h),
          child: SizedBox(
            width: 80.0,
            height: 80.0,
            child: GestureDetector(
              onTap: () async {
                image = await _picker.pickImage(source: ImageSource.gallery);
                context.read<MyPageProvider>().xfileStateChange(image);
                context.read<MyPageProvider>().doesActiveBasicButton();
              },
              child: UserProfileImage(profileImageUrl: profileImageString, selectImage: data.selectImage),
            ),
          ),
        );
      }
    );
  }
}

class BasicInfoField extends StatefulWidget {
  const BasicInfoField({super.key});

  @override
  State<BasicInfoField> createState() => _BasicInfoFieldState();
}

class _BasicInfoFieldState extends State<BasicInfoField> {

  String username = '';
  String birthday = '';

  late Future loadFuture;

  Future<UserModel> _fetchData() async {
    return await UserRequest().userInfoRequest();
  }

  @override
  void initState() {
    loadFuture = _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadFuture,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
          } else if(snapshot.connectionState == ConnectionState.done) {

            UserModel userModel = snapshot.data ?? UserModel();
            username = userModel.username!;
            birthday = userModel.birthday!;
            context.read<MyPageProvider>().nameInit(username);
            context.read<MyPageProvider>().birthdayInit(birthday);

            return Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: Column(
                        children: [
                          ProfileImageField(profileImageString: userModel.profileImageString),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text('이름', style: TextStyle(fontSize: 16.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700))),
                          SizedBox(height: 8.0.h),
                          BasicInfoName(initializeName: userModel.username!),
                          SizedBox(height: 24.0.h),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text('연락처', style: TextStyle(fontSize: 16.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700))),
                          SizedBox(height: 8.0.h),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 10.0.h),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: StaticColor.grey100F6,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(userModel.phone ?? '', style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey400BB, fontWeight: FontWeight.w500)),
                          ),
                          SizedBox(height: 24.0.h),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text('생년월일', style: TextStyle(fontSize: 16.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700))),
                          SizedBox(height: 8.0.h),
                          BasicInfoBirthday(initializeBirthday: userModel.birthday),
                          SizedBox(height: 24.0.h),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text('소개', style: TextStyle(fontSize: 16.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700))),
                          SizedBox(height: 8.0.h),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 8.0.h),
                            decoration: BoxDecoration(
                              color: StaticColor.grey100F6,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Center(
                              child: Text('소개 글이 없습니다.', style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                            ),
                          )
                        ]
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: MyInfoUpdateButton(),
                ),
              ],
            );

          } else {
            return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
          }
        } else if(snapshot.hasError) {
          return const SizedBox.shrink();
        } else {
          return const SizedBox.shrink();
        }
      }
    );
  }
}

class BasicInfoName extends StatefulWidget {
  String initializeName;
  BasicInfoName({super.key, required this.initializeName});

  @override
  State<BasicInfoName> createState() => _BasicInfoNameState();
}

class _BasicInfoNameState extends State<BasicInfoName> {

  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.initializeName;
    super.initState();
  }

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
          cursorHeight: 17.0.h,
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
        onEditingComplete: () {
          context.read<MyPageProvider>().nameStateChange(nameController.text, true);
        },
        onChanged: (v) {
          context.read<MyPageProvider>().nameStateChange(v, false);
          context.read<MyPageProvider>().doesActiveBasicButton();
          if(v.isEmpty || context.read<MyPageProvider>().loadName == context.read<MyPageProvider>().name) {
            context.read<MyPageProvider>().basicButtonChange(false);
          } else {
          }
        },
      ),
      // child: Text(title, style: TextStyle(fontSize: 14.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w500)),
    );
  }
}

class BasicInfoBirthday extends StatefulWidget {
  String? initializeBirthday;
  BasicInfoBirthday({super.key, this.initializeBirthday});

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
    yearController = TextEditingController();
    monthController = TextEditingController();
    dayController = TextEditingController();
    yearFocus = FocusNode();
    monthFocus = FocusNode();
    dayFocus = FocusNode();
    String initBirthday = widget.initializeBirthday ?? '';
    print(initBirthday);
    if(initBirthday.isEmpty) {
    } else {
      List<String> result = widget.initializeBirthday!.split('-');
      print(result.elementAt(1));
      yearValue = int.parse(result.elementAt(0));
      monthValue = int.parse(result.elementAt(1));
      dayValue = int.parse(result.elementAt(2));
      yearController.text = yearValue.toString();
      monthController.text = monthValue.toString();
      dayController.text = dayValue.toString();
      context.read<MyPageProvider>().birthdayInit(widget.initializeBirthday!);
    }
    super.initState();
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
    return Row(
      children: [
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
                  labelStyle: TextStyle(fontSize: 14.sp, color: StaticColor.mainSoft, fontWeight: FontWeight.w500),
                  hintText: '연도',
                  hintStyle: TextStyle(fontSize: 14.sp, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    borderSide: BorderSide.none,
                  )
              ),
              onEditingComplete: () {
                context.read<MyPageProvider>().birthdayStateChange(
                    '${yearController.text.toString()}-${context.read<MyPageProvider>().month}-${context.read<MyPageProvider>().day}'
                );
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
                  labelStyle: TextStyle(fontSize: 14.sp, color: StaticColor.mainSoft, fontWeight: FontWeight.w500),
                  hintText: '월',
                  hintStyle: TextStyle(fontSize: 14.sp, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    borderSide: BorderSide.none,
                  )
              ),
              onEditingComplete: () {
                context.read<MyPageProvider>().birthdayStateChange(
                    '${context.read<MyPageProvider>().year}-${monthController.text.toString()}-${context.read<MyPageProvider>().day}'
                );
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
                  labelStyle: TextStyle(fontSize: 14.sp, color: StaticColor.mainSoft, fontWeight: FontWeight.w500),
                  hintText: '일',
                  hintStyle: TextStyle(fontSize: 14.sp, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    borderSide: BorderSide.none,
                  )
              ),
              onEditingComplete: () {
                context.read<MyPageProvider>().birthdayStateChange(
                    '${context.read<MyPageProvider>().year}-${context.read<MyPageProvider>().month}-${dayController.text.toString()}'
                );
              },
            ),
            // child: Text(title, style: TextStyle(fontSize: 14.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w500)),
          ),
        )
      ]
    );
  }

  Widget dateSelect(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
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
                  if(selectDate == '') {
                    initdate = DateTime.now();
                    yearController.text = DateTime.utc(DateTime.now().year).toString();
                    monthController.text = DateTime.utc(DateTime.now().month).toString();
                    dayController.text = DateTime.utc(DateTime.now().day).toString();
                  } else {
                    yearController.text = selectDate.substring(0, 4);
                    monthController.text = selectDate.substring(4, 2);
                    dayController.text = selectDate.substring(6, 2);
                    initdate = DateTime.utc(int.parse(selectDate.substring(0, 4)), int.parse(selectDate.substring(5, 7)), int.parse(selectDate.substring(8)));
                  }
                  Navigator.of(context).pop();
                },
                child: Text('확인'),
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
                      print(date.toString());
                      // selectDate = date.toString().substring(0, 10);
                    },
                    mode: CupertinoDatePickerMode.date,

                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}


// class BasicInfoPhone extends StatefulWidget {
//   const BasicInfoPhone({super.key});
//
//   @override
//   State<BasicInfoPhone> createState() => _BasicInfoPhoneState();
// }
//
// class _BasicInfoPhoneState extends State<BasicInfoPhone> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 10.0.h),
//       width: double.infinity,
//       // height: 50,
//       decoration: BoxDecoration(
//         color: StaticColor.grey100F6,
//         borderRadius: BorderRadius.circular(4.0),
//       ),
//       child: TextFormField(
//           controller: nameController,
//           autofocus: false,
//           textInputAction: TextInputAction.next,
//           maxLines: 1,
//           maxLength: 14,
//           textAlignVertical: TextAlignVertical.center,
//           style: TextStyle(color: Colors.black, fontSize: 14.sp),
//           cursorHeight: 15.h,
//           decoration: InputDecoration(
//               counterText: '',
//               filled: true,
//               fillColor: StaticColor.loginInputBoxColor,
//               // fillColor: Colors.black,
//               isDense: true,
//               contentPadding: EdgeInsets.symmetric(vertical: 1.0.h),
//               alignLabelWithHint: false,
//               labelStyle: TextStyle(fontSize: 14.sp, color: StaticColor.mainSoft, fontWeight: FontWeight.w500),
//               hintText: '변경할 이름을 입력해 주세요',
//               hintStyle: TextStyle(fontSize: 14.sp, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
//               border: const OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(4.0)),
//                 borderSide: BorderSide.none,
//               )
//           ),
//           onChanged: (v) {
//             context.read<MyPageProvider>().nameStateChange(v);
//           }
//       ),
//       // child: Text(title, style: TextStyle(fontSize: 14.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w500)),
//     );
//   }
// }

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
                            context.read<MyPageProvider>().genderStateChange(0);
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
                            context.read<MyPageProvider>().genderStateChange(1);
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
    return Consumer<MyPageProvider>(
      builder: (context, data, child) {

        bool state = data.basicButton;

        return SizedBox(
          width: double.infinity,
          height: 76.0.h,
          child: ElevatedButton(
              onPressed: () async {
                print('change?? : ${context.read<MyPageProvider>().name}');
                if(state == true) {
                  bool updateResult = await UserRequest().userBasicInfoUpdate(context);
                  if(updateResult == true) {

                    context.read<MyPageProvider>().myPageNameChange();
                    context.read<MyPageProvider>().updateInfoInit();
                    Navigator.of(context).pop();
                  } else {
                  }
                } else {}
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: state == true ? StaticColor.mainSoft : StaticColor.grey400BB,
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
    );
  }
}
