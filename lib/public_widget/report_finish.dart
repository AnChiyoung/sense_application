import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';

class ReportFinish extends StatefulWidget {
  bool reportRequest;
  ReportFinish({super.key, required this.reportRequest});

  @override
  State<ReportFinish> createState() => _ReportFinishState();
}

class _ReportFinishState extends State<ReportFinish> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(10.0),
      contentPadding: EdgeInsets.zero,
      // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)),
      //Dialog Main Title
      title: widget.reportRequest == true
        ? Column(
            children: [
              Text('신고해 주셔서 감사합니다.', style: TextStyle(fontSize: 18, color: StaticColor.addEventCancelTitle, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8.0),
              Text('빠르게 검토한 후 조치하도록 하겠습니다.', style: TextStyle(fontSize: 14, color: StaticColor.addEventCancelTitle, fontWeight: FontWeight.w500)),
            ],
          )
        : Column(
            children: [
              Text('이미 신고하신 댓글입니다.', style: TextStyle(fontSize: 18, color: StaticColor.addEventCancelTitle, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8.0),
              Text('빠르게 검토한 후 조치하도록 하겠습니다.', style: TextStyle(fontSize: 14, color: StaticColor.addEventCancelTitle, fontWeight: FontWeight.w500)),
            ],
          ),
      content: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 28, bottom: 18),
        child: Container(
          height: 32,
          decoration: BoxDecoration(
            color: StaticColor.categoryUnselectedColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categorySelectedColor, elevation: 0.0),
            child: const Text('확인', style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400)),
          ),
        ),
      ),
    );
  }
}
