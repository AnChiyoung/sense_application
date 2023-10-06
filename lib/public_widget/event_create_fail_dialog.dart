import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';

class CreateEventFailDialog extends StatefulWidget {
  const CreateEventFailDialog({super.key});

  @override
  State<CreateEventFailDialog> createState() => _CreateEventFailDialogState();
}

class _CreateEventFailDialogState extends State<CreateEventFailDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(40.0),
      contentPadding: EdgeInsets.zero,
      // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)),
      //Dialog Main Title
      title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Center(child: Text('다시 시도해주세요!', style: TextStyle(fontSize: 18.0.sp, color: StaticColor.grey80033, fontWeight: FontWeight.w400)))),
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
              // Navigator.push(context, MaterialPageRoute(builder: (_) => EventInfoScreen(visitCount: 0, recommendCount: 0)));
            },
            style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categorySelectedColor, elevation: 0.0),
            child: Text('확인', style: TextStyle(fontSize: 14.0.sp, color: Colors.white, fontWeight: FontWeight.w400)),
          ),
        ),
      ),
    );
  }
}
