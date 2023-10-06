import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/my_page/my_info_update_content.dart';
import 'package:sense_flutter_application/views/my_page/my_info_update_header.dart';

class MyInfoUpdate extends StatefulWidget {
  int page;
  MyInfoUpdate({super.key, required this.page});

  @override
  State<MyInfoUpdate> createState() => _MyInfoUpdateState();
}

class _MyInfoUpdateState extends State<MyInfoUpdate> {
  @override
  Widget build(BuildContext context) {

    /// safe area height
    final safeAreaTopPadding = MediaQuery.of(context).padding.top;
    final safeAreaBottomPadding = MediaQuery.of(context).padding.bottom;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          bottom: false,
          child: Column(
            children: [
              MyInfoUpdateHeader(),
              Expanded(
                child: MyInfoUpdateContent(page: widget.page, topPadding: safeAreaTopPadding),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
