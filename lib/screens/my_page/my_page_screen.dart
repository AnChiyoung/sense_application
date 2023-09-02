import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/views/my_page/my_page_header.dart';
import 'package:sense_flutter_application/views/my_page/my_page_info.dart';
import 'package:sense_flutter_application/views/my_page/my_page_tab.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
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
              MyPageHeader(),
              MyPageInfo(),
              SizedBox(height: 23.0.h),
              Expanded(child: MyPageTab()),
            ],
          ),
        ),
      ),
    );
  }
}