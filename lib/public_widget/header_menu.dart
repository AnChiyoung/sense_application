import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';

class HeaderMenu extends StatefulWidget {
  Function? backCallback;
  String? title;
  Function? closeCallback;
  Widget? rightMenu;
  TextStyle? titleStyle;
  HeaderMenu({Key? key, this.backCallback, this.title, this.closeCallback, this.rightMenu, this.titleStyle}) : super(key: key);

  @override
  State<HeaderMenu> createState() => _HeaderMenuState();
}

class _HeaderMenuState extends State<HeaderMenu> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: Stack(
        children: [
          widget.backCallback == null ? Container() : Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Material(
                color: Colors.transparent,
                child: SizedBox(
                  width: 40.w,
                  height: 40.h,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(25.0),
                    onTap: () {
                      widget.backCallback?.call();
                    },
                    child: Center(child: Image.asset('assets/create_event/button_back.png', width: 24.w, height: 24.h)),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(widget.title ?? '', style: widget.titleStyle ?? TextStyle(fontSize: 16.sp, color: StaticColor.contactTextColor, fontWeight: FontWeight.w500)),
          ),
          widget.rightMenu == null ? Container() : Align(alignment: Alignment.centerRight, child: Padding(padding: EdgeInsets.only(right: 18.w), child: widget.rightMenu!)),
          widget.closeCallback == null  ? Container() : Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 18.w),
              child: GestureDetector(
                  onTap: () {
                    widget.closeCallback?.call();
                  },
                  child: Image.asset('assets/add_event/button_close.png', width: 15.01, height: 14.96)
              ),
            ),
          ),
        ],
      ),
    );
  }
}