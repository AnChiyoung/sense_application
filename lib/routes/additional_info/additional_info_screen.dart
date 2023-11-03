import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';
import 'package:sense_flutter_application/screens/home/home_screen.dart';
import 'package:sense_flutter_application/views/my_page/my_info_update_moreinfo.dart';
import 'package:sense_flutter_application/views/my_page/my_page_provider.dart';

class AdditionalInfoScreen extends StatefulWidget {
  const AdditionalInfoScreen({super.key});

  @override
  State<AdditionalInfoScreen> createState() => _AdditionalInfoScreenState();
}

class _AdditionalInfoScreenState extends State<AdditionalInfoScreen> {
  @override
  void initState() {
    context.read<MyPageProvider>().setPrevRoute(
          MyPagePrevRouteEnum.fromFirstLogin,
          false,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final safeAreaTopPadding = MediaQuery.paddingOf(context).top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0.w,
                vertical: 24.0.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    PresentUserInfo.username,
                    style: TextStyle(
                      fontSize: 20.0.sp,
                      fontWeight: FontWeight.w700,
                      color: StaticColor.grey80033,
                    ),
                  ),
                  Text(
                    '회원님을 알려주세요!',
                    style: TextStyle(
                      fontSize: 20.0.sp,
                      fontWeight: FontWeight.w700,
                      color: StaticColor.grey80033,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: MyMoreInfo(
                topPadding: safeAreaTopPadding,
              ),
            )
          ],
        ),
      ),
    );
  }
}
