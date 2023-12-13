import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/user/user_model.dart';
import 'package:sense_flutter_application/routes/edit_profile/edit_profile_provider.dart';
import 'package:sense_flutter_application/routes/edit_profile/views/edit_profile_content/widgets/birthday_field.dart';
import 'package:sense_flutter_application/routes/edit_profile/views/edit_profile_content/widgets/gender_field.dart';
import 'package:sense_flutter_application/routes/edit_profile/views/edit_profile_content/widgets/mbti_field.dart';
import 'package:sense_flutter_application/routes/edit_profile/views/edit_profile_content/widgets/own_car_field.dart';
import 'package:sense_flutter_application/routes/edit_profile/views/edit_profile_content/widgets/phone_field.dart';
import 'package:sense_flutter_application/routes/edit_profile/views/edit_profile_content/widgets/profile_image_field.dart';
import 'package:sense_flutter_application/routes/edit_profile/views/edit_profile_content/widgets/relationship_field.dart';
import 'package:sense_flutter_application/routes/edit_profile/views/edit_profile_content/widgets/username_field.dart';

class EditProfileContent extends StatefulWidget {
  const EditProfileContent({super.key});

  @override
  State<EditProfileContent> createState() => _EditProfileContentState();
}

class _EditProfileContentState extends State<EditProfileContent> with TickerProviderStateMixin {
  late Future loadFuture;

  Future<UserModel> _fetchData() async {
    return await UserRequest().userInfoRequest();
  }

  @override
  void initState() {
    super.initState();
    // 나중에 삭제 예정. additional_info랑 분기처리
    context.read<EditProfileProvider>().resetState();
    loadFuture = _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.done) {
            return BasicInfoFieldPresenter(userModel: snapshot.data ?? UserModel());
          }

          // if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Lottie.asset(
              'assets/lottie/loading.json',
              width: 200,
              height: 200,
            ),
          );
        }

        if (snapshot.hasError) {
          return const SizedBox.shrink();
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class BasicInfoFieldPresenter extends StatefulWidget {
  final UserModel userModel;
  const BasicInfoFieldPresenter({super.key, required this.userModel});

  @override
  State<BasicInfoFieldPresenter> createState() => _BasicInfoFieldPresenterState();
}

class _BasicInfoFieldPresenterState extends State<BasicInfoFieldPresenter> {
  @override
  void initState() {
    super.initState();
    context.read<EditProfileProvider>().initScreen(widget.userModel, notify: false);
  }

  @override
  Widget build(BuildContext context) {
    double viewInsetsBottom = MediaQuery.of(context).viewInsets.bottom;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                bottom: 16.h,
              ),
              child: Column(
                children: [
                  //
                  SizedBox(height: 24.h),
                  const ProfileImageField(),
                  labelText(
                    '기본정보',
                    padding: EdgeInsets.only(
                      top: 16.h,
                      bottom: 8.h,
                    ),
                  ),

                  const UsernameField(),
                  SizedBox(height: 8.h),
                  const PhoneField(),

                  labelText('성별'),
                  const GenderField(),

                  labelText('생년월일'),
                  const BirthdayField(),

                  labelText('현재 상태'),
                  const RelationshipField(),

                  labelText('MBTI'),
                  const MbtiField(),

                  labelText('자차 여부'),
                  const OwnCarField(),
                ],
              ),
            ),
          ),
        ),
        const MyInfoUpdateButton(),
        SizedBox(height: viewInsetsBottom),
      ],
    );
  }

  Widget labelText(String label, {EdgeInsetsGeometry? padding}) {
    padding = padding ??
        EdgeInsets.only(
          top: 24.h,
          bottom: 8.h,
        );

    return Padding(
      padding: padding,
      child: Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          height: 24.h,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16.sp,
              color: StaticColor.grey70055,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
        ),
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
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<EditProfileProvider>(
      builder: (context, data, child) {
        bool disabled = data.saveButtonDisabled();

        return SizedBox(
          width: double.infinity,
          height: 76.h,
          child: ElevatedButton(
            onPressed: () async {
              if (disabled || isLoading) return;
              setState(() {
                isLoading = true;
              });

              await Future.delayed(const Duration(milliseconds: 300));
              bool isSuccess = await data.updateUserMe();
              if (isSuccess) {
                UserModel user = await UserRequest().userInfoRequest();
                data.resetState();
                data.initScreen(user);
              }

              setState(() {
                isLoading = false;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: disabled == true ? StaticColor.grey400BB : StaticColor.mainSoft,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 56,
                  child: Center(
                    child: isLoading
                        ? CircularProgressIndicator(color: StaticColor.grey300E0)
                        : Text(
                            '저장',
                            style: TextStyle(
                              fontSize: 16.sp,
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
      },
    );
  }
}

class Field {
  String name;
  bool isChanged;
  bool isSavable;

  Field({
    required this.name,
    this.isChanged = false,
    this.isSavable = false,
  });
}

List<Field> list = [
  Field(name: 'username'),
  Field(name: 'phone'),
  Field(name: 'birth'),
];

Map<String, String> prevValue = {
  'username': 'a',
  'phone': '010-0000-0000',
  'birth': '1900-00-00',
};

String usernameValue = '';
String phoneValue = '010-0000-0000';
bool isPhoneAuth = true;
String birthValue = '1900-00-00';

List<Field> validateList = [...list];

Field? findTarget(String name) {
  return validateList.firstWhere((item) => name == item.name, orElse: () => Field(name: ''));
}

void changeState(String name, {bool? isChanged, bool? isSavable}) {
  final index = validateList.indexWhere((item) => item.name == name);
  if (index != -1) {
    final field = validateList[index];
    validateList[index] = Field(
      name: name,
      isChanged: isChanged ?? field.isChanged,
      isSavable: isSavable ?? field.isSavable,
    );
  }
}

bool validate() {
  if (usernameValue != prevValue['username']) {
    changeState('username', isChanged: true);
  }

  if (usernameValue.isEmpty) {
    changeState('username', isSavable: false);
  }

  if (phoneValue.isNotEmpty && phoneValue != prevValue['phone']) {
    changeState('phone', isChanged: true);
  }

  if (isPhoneAuth) {
    changeState('phone', isSavable: true);
  }

  if (birthValue != prevValue['birth']) {
    changeState('birth', isChanged: true);
  }

  if (birthValue.isNotEmpty) {
    changeState('birth', isSavable: true);
  }

  print(validateList);
  return validateList.where((field) => field.isChanged).every((field) => field.isSavable);
}

void main() {
  print(validate());
}
