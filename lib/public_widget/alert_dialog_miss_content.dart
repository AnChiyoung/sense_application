import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({Key? key}) : super(key: key);

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)),
      //Dialog Main Title
      title: Column(
        children: const [
          Align(alignment: Alignment.centerLeft, child: Text("Sense TEAM")),
        ],
      ),
      //
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "서비스 준비중입니다.\n빠른 시일 내에 찾아뵙겠습니다.",
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