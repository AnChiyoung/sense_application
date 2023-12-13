import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/routes/edit_profile/edit_profile_provider.dart';

class UsernameField extends StatefulWidget {
  const UsernameField({super.key});

  @override
  State<UsernameField> createState() => _UsernameFieldState();
}

class _UsernameFieldState extends State<UsernameField> {
  late TextEditingController nameController;
  late FocusNode nameFocus;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    nameFocus = FocusNode();
    nameController.text = context.read<EditProfileProvider>().username;
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
        height: 20.h / 14.sp,
      ),
      decoration: InputDecoration(
        counterText: '',
        filled: true,
        isDense: true,
        fillColor: StaticColor.loginInputBoxColor,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.0.w,
          vertical: 10.0.h,
        ),
        hintText: '이름을 입력해 주세요',
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: StaticColor.loginHintTextColor,
          height: 20.h / 14.sp,
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
        context.read<EditProfileProvider>().onChangeUsername(value, true);
      },
      onTapOutside: (event) => nameFocus.unfocus(),
    );
  }
}
