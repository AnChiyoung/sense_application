import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/routes/edit_profile/edit_profile_provider.dart';
import 'package:sense_flutter_application/widgets/animated_elevated_button.dart';

class OwnCarField extends StatefulWidget {
  const OwnCarField({super.key});

  @override
  State<OwnCarField> createState() => _OwnCarFieldState();
}

class _OwnCarFieldState extends State<OwnCarField> {
  onSelected(bool isOwnCar) {
    context.read<EditProfileProvider>().onChangeOwnCar(isOwnCar, true);
  }

  @override
  Widget build(BuildContext context) {
    return Selector<EditProfileProvider, bool?>(
      selector: (context, data) => data.isOwnCar,
      builder: (context, isOwnCar, child) {
        return Row(
          children: [
            _button(
              text: '자차 있음',
              isSelected: isOwnCar == true,
              onPressed: () {
                onSelected(true);
              },
            ),
            SizedBox(width: 8.w),
            _button(
              text: '자차 없음',
              isSelected: isOwnCar == false,
              onPressed: () {
                onSelected(false);
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
