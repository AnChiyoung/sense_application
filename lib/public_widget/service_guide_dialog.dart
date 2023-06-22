import 'package:flutter/material.dart';

class ServiceGuideDialog extends StatefulWidget {
  const ServiceGuideDialog({Key? key}) : super(key: key);

  @override
  State<ServiceGuideDialog> createState() => _ServiceGuideDialogState();
}

class _ServiceGuideDialogState extends State<ServiceGuideDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)),
      //Dialog Main Title
      title: Column(
        children: [
          // Align(alignment: Alignment.centerLeft, child: Text("Sense TEAM")),
        ],
      ),
      //
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "서비스 준비 중입니다.\n빠른 시일 내에 찾아뵙겠습니다.",
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text("확인"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}