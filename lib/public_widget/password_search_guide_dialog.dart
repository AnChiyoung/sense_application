import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';

class PasswordSearchGuideDialog extends StatefulWidget {
  const PasswordSearchGuideDialog({super.key});

  @override
  State<PasswordSearchGuideDialog> createState() => _PasswordSearchGuideDialogState();
}

class _PasswordSearchGuideDialogState extends State<PasswordSearchGuideDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(40.0),
      contentPadding: EdgeInsets.zero,
      // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)),
      //Dialog Main Title
      title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Center(child: Text('dev@runners.im으로 문의해 주세요', style: TextStyle(fontSize: 18, color: StaticColor.grey80033, fontWeight: FontWeight.w700)))),
      content: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 28, bottom: 18),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: StaticColor.categoryUnselectedColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categorySelectedColor, elevation: 0.0),
            child: Text('확인', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400)),
          ),
        ),
      ),
    );
  }
}
