import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/my_page/my_info_update_content.dart';
import 'package:sense_flutter_application/views/my_page/my_info_update_header.dart';

class MyInfoUpdate extends StatefulWidget {
  const MyInfoUpdate({super.key});

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
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - safeAreaTopPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      MyInfoUpdateHeader(),
                      Container(
                        width: double.infinity,
                        height: 1.0.h,
                        color: StaticColor.grey300E0,
                      ),
                      MyInfoUpdateContent(),
                    ],
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: MyInfoUpdateButton(),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
