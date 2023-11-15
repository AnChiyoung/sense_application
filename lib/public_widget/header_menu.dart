import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';

class HeaderMenu extends StatefulWidget {
  final Function? backCallback;
  final bool? isBackClose;
  final String? title;
  final Function? closeCallback;
  final Widget? rightMenu;
  final TextStyle? titleStyle;
  final double? backPadding;
  const HeaderMenu({
    super.key,
    this.backCallback,
    this.isBackClose,
    this.title,
    this.closeCallback,
    this.rightMenu,
    this.titleStyle,
    this.backPadding,
  });

  @override
  State<HeaderMenu> createState() => _HeaderMenuState();
}

class _HeaderMenuState extends State<HeaderMenu> {
  bool isBackClose = false;

  @override
  void initState() {
    super.initState();
    isBackClose = widget.isBackClose ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: Stack(
        children: [
          widget.backCallback == null
              ? Container()
              : Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: widget.backPadding ?? 12.w),
                    child: Material(
                      color: Colors.transparent,
                      child: SizedBox(
                        width: 40.h,
                        height: 40.h,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(25.0),
                          onTap: () {
                            widget.backCallback?.call();
                          },
                          child: Center(
                            child: Image.asset(
                              isBackClose == true
                                  ? 'assets/signin/button_close.png'
                                  : 'assets/store/back_arrow_thin.png',
                              width: 24.h,
                              height: 24.h,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 70.0.w),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                widget.title ?? '',
                style: widget.titleStyle ??
                    TextStyle(
                      fontSize: 16.sp,
                      color: StaticColor.contactTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          widget.rightMenu == null
              ? Container()
              : Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.only(right: 12.w),
                    child: widget.rightMenu!,
                  ),
                ),
          widget.closeCallback == null
              ? Container()
              : Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 18.w),
                    child: GestureDetector(
                      onTap: () {
                        widget.closeCallback?.call();
                      },
                      child: Image.asset(
                        'assets/add_event/button_close.png',
                        width: 15.0.w,
                        height: 15.0.w,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
