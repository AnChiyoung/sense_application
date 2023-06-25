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
      insetPadding: EdgeInsets.all(10),
      contentPadding: EdgeInsets.zero,
      // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)),
      //Dialog Main Title
      title: Column(
        children: [
          Text('로그아웃 하시겠습니까?', style: TextStyle(fontSize: 18, color: StaticColor.addEventCancelTitle, fontWeight: FontWeight.w700)),
        ],
      ),
      //
      content: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 28, bottom: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
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
                  style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categoryUnselectedColor, elevation: 0.0),
                  child: Text('취소하기', style: TextStyle(fontSize: 14, color: StaticColor.contactLoadTextColor, fontWeight: FontWeight.w400)),
                ),
              ),
            ),
            const SizedBox(
                width: 8
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: StaticColor.categoryUnselectedColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    widget.action!.call();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categorySelectedColor, elevation: 0.0),
                  child: Text('로그아웃', style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400)),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: null,
    );
  }
}