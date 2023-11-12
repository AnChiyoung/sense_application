import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';

class ServiceGuideDialog extends StatefulWidget {
  const ServiceGuideDialog({Key? key}) : super(key: key);

  @override
  State<ServiceGuideDialog> createState() => _ServiceGuideDialogState();
}

class _ServiceGuideDialogState extends State<ServiceGuideDialog> {
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
        child: Center(child: Text('서비스 준비 중입니다.', style: TextStyle(fontSize: 18, color: StaticColor.grey80033, fontWeight: FontWeight.w700)))),
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
            child: const Text('확인', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400)),
          ),
        ),
      ),
    );
  }
}