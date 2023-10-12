import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/public_widget/event_info_recommend_cancel_dialog.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';
import 'package:sense_flutter_application/views/event_info/recommend_request/recommend_request_provider.dart';

class RecommendRequestHeader extends StatefulWidget {
  const RecommendRequestHeader({super.key});

  @override
  State<RecommendRequestHeader> createState() => _RecommendRequestHeaderState();
}

class _RecommendRequestHeaderState extends State<RecommendRequestHeader> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RecommendRequestProvider>(
      builder: (context, data, child) {

        bool isStep01 = data.step == 1 ? true : false;

        return HeaderMenu(backCallback: isStep01 == true ? null : backCallback, title: '추천 요청하기', rightMenu: closeMenu());
      }
    );
  }

  void backCallback() {
    context.read<RecommendRequestProvider>().stepChange(
      context.read<RecommendRequestProvider>().step - 1,
      true
    );
  }

  void popFunction() {
    Navigator.of(context).pop();
  }

  Widget closeMenu() {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: 40.w,
        height: 40.h,
        child: InkWell(
          borderRadius: BorderRadius.circular(25.0),
          onTap: () {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return RecommendCancelDialog(backFunction: popFunction);
                }
            );
          },
          child: Center(child: Image.asset('assets/create_event/button_close.png', width: 16.w, height: 16.h)),
        ),
      ),
    );
  }
}
