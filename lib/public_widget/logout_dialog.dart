import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';

class LogoutDialog extends StatefulWidget {
  Function? action;
  LogoutDialog({Key? key, this.action}) : super(key: key);

  @override
  State<LogoutDialog> createState() => _LogoutDialog();
}

class _LogoutDialog extends State<LogoutDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)),
      //Dialog Main Title
      title: Column(
        children: const [
          // Align(alignment: Alignment.centerLeft, child: Text("Sense TEAM")),
        ],
      ),
      //
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "로그아웃 하시겠습니까?",
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                child: Text("취소"),
                onPressed: () {
                  Navigator.pop(context);
                }
            ),
            TextButton(
              child: Text("확인", style: TextStyle(color: StaticColor.errorColor)),
              onPressed: () {
                widget.action!.call();
              },
            ),
          ]
        )

      ],
    );
  }
}