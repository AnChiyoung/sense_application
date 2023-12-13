import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/models/user/user_model.dart';
import 'package:sense_flutter_application/routes/edit_profile/edit_profile_provider.dart';
import 'package:sense_flutter_application/widgets/animated_elevated_button.dart';

class GenderField extends StatefulWidget {
  const GenderField({super.key});

  @override
  State<GenderField> createState() => _GenderFieldState();
}

class _GenderFieldState extends State<GenderField> {
  onSelected(EnumUserGender gender) {
    context.read<EditProfileProvider>().onChangeGender(gender, true);
  }

  @override
  Widget build(BuildContext context) {
    return Selector<EditProfileProvider, EnumUserGender?>(
      selector: (context, data) => data.gender,
      builder: (context, gender, child) {
        return Row(
          children: [
            _button(
              text: EnumUserGender.female.label,
              isSelected: gender == EnumUserGender.female,
              onPressed: () {
                onSelected(EnumUserGender.female);
              },
            ),
            SizedBox(width: 8.w),
            _button(
              text: EnumUserGender.male.label,
              isSelected: gender == EnumUserGender.male,
              onPressed: () {
                onSelected(EnumUserGender.male);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _button({
    required String text,
    required bool isSelected,
    void Function()? onPressed,
  }) {
    return Expanded(
      child: SizedBox(
        height: 38.h,
        child: AnimatedElevatedButton(
          text: text,
          isSelected: isSelected,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
