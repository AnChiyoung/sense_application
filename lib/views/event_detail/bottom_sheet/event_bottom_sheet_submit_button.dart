import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';

class EventBottomSheetSubmitButton extends StatefulWidget {
  void Function() onPressed;
  EventBottomSheetSubmitButton({super.key, required this.onPressed});

  @override
  State<EventBottomSheetSubmitButton> createState() => _EventBottomSheetSubmitButtonState();
}

class _EventBottomSheetSubmitButtonState extends State<EventBottomSheetSubmitButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70.h,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categorySelectedColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 56, child: Center(child: Text('저장', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700)))),
          ]
        )
      ),
    );
  }
}
