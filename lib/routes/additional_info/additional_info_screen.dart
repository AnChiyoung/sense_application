import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
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

  void backCallback() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(
          initPage: 0,
        ),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final safeAreaTopPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            HeaderMenu(
              backCallback: backCallback,
              title: '추가 정보',
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: StaticColor.grey300E0,
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
