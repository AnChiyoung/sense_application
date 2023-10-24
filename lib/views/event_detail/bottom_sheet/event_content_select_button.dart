import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';

class EventContentSelectButton extends StatefulWidget {
  bool checkState;
  String? iconPath;
  String? title;
  Function? onPressed;
  EventContentSelectButton({super.key, required this.checkState, this.iconPath, this.title, this.onPressed});

  @override
  State<EventContentSelectButton> createState() => _EventContentSelectButtonState();
}

class _EventContentSelectButtonState extends State<EventContentSelectButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ElevatedButton(
        onPressed: () {
          widget.onPressed == null ? {} : widget.onPressed!.call();
        },
        style: ElevatedButton.styleFrom(elevation: 0.0, backgroundColor: widget.checkState == true ? StaticColor.categorySelectedColor : StaticColor.categoryUnselectedColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.iconPath == null ? const SizedBox.shrink() : Image.asset(widget.iconPath!, width: 32.w, height: 32.h, color: widget.checkState == true ? Colors.white : Colors.black),
            widget.iconPath == null || widget.title == null ? const SizedBox.shrink() : SizedBox(height: 12.0.h),
            widget.title == null ? const SizedBox.shrink() : Text(widget.title!, style: TextStyle(fontSize: 13.sp, color: widget.checkState == true ? Colors.white : StaticColor.addEventFontColor, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}
