import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/screens/calendar/calendar_screen.dart';
import 'package:sense_flutter_application/screens/event_feed/event_feed_screen.dart';
import 'package:sense_flutter_application/screens/feed/feed_screen.dart';
import 'package:sense_flutter_application/screens/store/store_screen.dart';
import 'package:sense_flutter_application/views/home/home_provider.dart';
import 'package:sense_flutter_application/views/store/store_provider.dart';

class MovePageList {
  static List<Widget> pageList = [
    const FeedScreen(),
    // ContactScreen(),
    const StoreScreen(),
    // TestScreen(),
    const EventFeedScreen(),
    const CalendarScreen(),
  ];
}

class BottomMenu extends StatefulWidget {
  final Function selectCallback;
  final int initPage;
  const BottomMenu({
    super.key,
    required this.selectCallback,
    required this.initPage,
  });

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageIndex = widget.initPage;
  }

  @override
  Widget build(BuildContext context) {
    final safeAreaBottomPadding = MediaQuery.of(context).padding.bottom;

    return SizedBox(
      height: 60.0.h + safeAreaBottomPadding,
      child: Padding(
        padding: EdgeInsets.only(bottom: safeAreaBottomPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _bottomNavigationBarItem(
              label: '홈',
              onTap: () {
                widget.selectCallback(0);
                pageIndex = 0;
                context.read<HomeProvider>().selectHomeIndexChange(0, false);
              },
              isSelected: pageIndex == 0,
              assetPath: 'assets/home/home.png',
            ),
            SizedBox(width: 2.0.w),
            _bottomNavigationBarItem(
              label: '스토어',
              onTap: () {
                context.read<StoreProvider>().storeDataClear();
                widget.selectCallback(1);
                pageIndex = 1;
                context.read<HomeProvider>().selectHomeIndexChange(1, false);
              },
              isSelected: pageIndex == 1,
              assetPath: 'assets/home/store.png',
            ),
            SizedBox(width: 2.0.w),
            _bottomNavigationBarItem(
              label: '피드',
              onTap: () {
                widget.selectCallback(2);
                pageIndex = 2;
                context.read<HomeProvider>().selectHomeIndexChange(2, false);
              },
              isSelected: pageIndex == 2,
              assetPath: 'assets/home/feed.png',
            ),
            SizedBox(width: 2.0.w),
            _bottomNavigationBarItem(
              label: '캘린더',
              onTap: () {
                widget.selectCallback(3);
                pageIndex = 3;
                context.read<HomeProvider>().selectHomeIndexChange(3, false);
              },
              isSelected: pageIndex == 3,
              assetPath: 'assets/home/calendar.png',
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomNavigationBarItem({
    required String label,
    required void Function() onTap,
    required bool isSelected,
    required String assetPath,
  }) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.0.h),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(6.0.r),
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageIcon(
                  AssetImage(assetPath),
                  size: 24.0.h,
                  color: isSelected ? StaticColor.mainSoft : StaticColor.grey80033,
                ),
                SizedBox(height: 4.0.h),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: isSelected ? StaticColor.mainSoft : StaticColor.grey80033,
                    fontWeight: FontWeight.w400,
                    height: 18 / 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomNavigationBarItem(String assetPath, double size, String labelName, int menuIndex) {
    return SizedBox(
      width: 60.0.h,
      height: 60.0.h,
      child: Column(
        children: [
          ImageIcon(
            AssetImage(assetPath),
            size: size,
            color: menuIndex == pageIndex ? StaticColor.mainSoft : StaticColor.grey80033,
          ),
          SizedBox(height: 4.0.h),
          Text(
            labelName,
            style: TextStyle(
              fontSize: 12,
              color: menuIndex == pageIndex ? StaticColor.mainSoft : StaticColor.grey80033,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
