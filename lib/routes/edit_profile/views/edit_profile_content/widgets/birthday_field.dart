import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/routes/edit_profile/edit_profile_provider.dart';

class BirthdayField extends StatefulWidget {
  const BirthdayField({super.key});

  @override
  State<BirthdayField> createState() => _BirthdayFieldState();
}

class _BirthdayFieldState extends State<BirthdayField> {
  late TextEditingController yearController;
  late TextEditingController monthController;
  late TextEditingController dayController;

  late FocusNode yearFocus;
  late FocusNode monthFocus;
  late FocusNode dayFocus;

  @override
  void initState() {
    super.initState();
    yearController = TextEditingController();
    monthController = TextEditingController();
    dayController = TextEditingController();
    yearFocus = FocusNode();
    monthFocus = FocusNode();
    dayFocus = FocusNode();

    EditProfileProvider editProfileProvider = context.read<EditProfileProvider>();
    if (editProfileProvider.year != null) {
      yearController.text = editProfileProvider.year.toString();
    }
    if (editProfileProvider.month != null) {
      monthController.text = editProfileProvider.month.toString();
    }
    if (editProfileProvider.day != null) {
      dayController.text = editProfileProvider.day.toString();
    }
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
        renderBirthdayInput(
          context: context,
          controller: yearController,
          focusNode: yearFocus,
          hintText: '연도',
          maxLength: 4,
          onTapOutside: (event) => yearFocus.unfocus(),
          onChanged: (value) => context.read<EditProfileProvider>().onChangeYear(value, true),
        ),
        SizedBox(width: 12.0.w),
        renderBirthdayInput(
          context: context,
          controller: monthController,
          focusNode: monthFocus,
          hintText: '월',
          maxLength: 2,
          onTapOutside: (event) => monthFocus.unfocus(),
          onChanged: (value) => context.read<EditProfileProvider>().onChangeMonth(value, true),
        ),
        SizedBox(width: 12.0.w),
        renderBirthdayInput(
          context: context,
          controller: dayController,
          focusNode: dayFocus,
          hintText: '월',
          maxLength: 2,
          onTapOutside: (event) => dayFocus.unfocus(),
          onChanged: (value) => context.read<EditProfileProvider>().onChangeDay(value, true),
        ),
      ],
    );
  }

  Widget renderBirthdayInput({
    BuildContext? context,
    TextEditingController? controller,
    FocusNode? focusNode,
    String? hintText,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
    void Function(PointerDownEvent)? onTapOutside,
    void Function(String)? onChanged,
    void Function()? onEditingComplete,
  }) {
    return Flexible(
      flex: 1,
      child: TextFormField(
        controller: controller,
        autofocus: false,
        focusNode: focusNode,
        textInputAction: TextInputAction.next,
        maxLines: 1,
        maxLength: maxLength,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.number,
        style: TextStyle(
          color: Colors.black,
          fontSize: 14.sp,
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: StaticColor.grey100F6,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.0.w,
            vertical: 10.0.h,
          ),
          labelStyle: TextStyle(
            fontSize: 14.sp,
            color: StaticColor.mainSoft,
            fontWeight: FontWeight.w500,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: StaticColor.loginHintTextColor,
            fontWeight: FontWeight.w400,
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(4.0),
            ),
          ),
        ),
        inputFormatters: inputFormatters,
        onTapOutside: onTapOutside,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
      ),
    );
  }
}
