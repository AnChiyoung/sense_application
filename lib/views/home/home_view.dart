import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/screens/calendar/calendar_screen.dart';
import 'package:sense_flutter_application/screens/event_feed/event_feed_screen.dart';
import 'package:sense_flutter_application/screens/feed/feed_screen.dart';
import 'package:sense_flutter_application/screens/store/store_screen.dart';
import 'package:sense_flutter_application/screens/test_screen/test_screen.dart';
import 'package:sense_flutter_application/views/home/home_provider.dart';
import 'package:sense_flutter_application/views/store/store_provider.dart';
import '../../public_widget/login_dialog.dart';

class MovePageList {
  static List<Widget> pageList = [
    FeedScreen(),
    // ContactScreen(),
    StoreScreen(),
    // TestScreen(),
    EventFeedScreen(),
    CalendarScreen(),
  ];
}

class BottomMenu extends StatefulWidget {
  Function selectCallback;
  double? safeAreaBottomPadding;
  int initPage;
  BottomMenu({Key? key, required this.selectCallback, this.safeAreaBottomPadding, required this.initPage}) : super(key: key);

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  int pageIndex = 0;
  List<BottomNavigationBarItem> bottomNavigationMenu = [];

  /// inkwell shape의 활성화를 위해 container - center - column의 구조를 취함
  Widget bottomNavigationBarItem(String assetPath, double size, String labelName, int menuIndex) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageIcon(AssetImage(assetPath), size: size, color: menuIndex == pageIndex ? StaticColor.mainSoft : StaticColor.grey80033),
            const SizedBox(height: 4),
            Text(labelName, style: TextStyle(fontSize: 12, color: menuIndex == pageIndex ? StaticColor.mainSoft : StaticColor.grey80033, fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    pageIndex = widget.initPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return PhysicalModel(
      color: Colors.white,
      shadowColor: Colors.blue,
      elevation: 30.0,
      child: Container(
        padding: EdgeInsets.only(bottom: widget.safeAreaBottomPadding!),
        height: 60.0 + widget.safeAreaBottomPadding!,
        child: Row(
          children: [

            Expanded(
              flex: 1,
              child: Center(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30.0),
                    onTap: () {
                      widget.selectCallback(0);
                      pageIndex = 0;
                      context.read<HomeProvider>().selectHomeIndexChange(0, false);
                    },
                    child: bottomNavigationBarItem('assets/home/home.png', 24.0, '홈', 0))),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                        borderRadius: BorderRadius.circular(30.0),
                        onTap: () {
                          context.read<StoreProvider>().storeDataClear();
                          widget.selectCallback(1);
                          pageIndex = 1;
                          context.read<HomeProvider>().selectHomeIndexChange(1, false);
                          // showDialog(
                          //   context: context,
                          //   barrierDismissible: false,
                          //   builder: (BuildContext context) {
                          //     return const ServiceGuideDialog();
                          //   }
                          // );
                        },
                        child: bottomNavigationBarItem('assets/home/store.png', 24.0, '스토어', 1))),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                        borderRadius: BorderRadius.circular(30.0),
                        onTap: () {
                          widget.selectCallback(2);
                          pageIndex = 2;
                          context.read<HomeProvider>().selectHomeIndexChange(2, false);
                          // showDialog(
                          //     context: context,
                          //     barrierDismissible: false,
                          //     builder: (BuildContext context) {
                          //       return const ServiceGuideDialog();
                          //     }
                          // );
                        },
                        child: bottomNavigationBarItem('assets/home/feed.png', 24.0, '피드', 2))),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                        borderRadius: BorderRadius.circular(30.0),
                        onTap: () {
                          widget.selectCallback(3);
                          pageIndex = 3;
                          context.read<HomeProvider>().selectHomeIndexChange(3, false);
                          // showDialog(
                          //     context: context,
                          //     barrierDismissible: false,
                          //     builder: (BuildContext context) {
                          //       return const ServiceGuideDialog();
                          //     }
                          // );
                        },
                        child: bottomNavigationBarItem('assets/home/calendar.png', 24.0, '캘린더', 3))),
              ),
            ),
          ]
        ),
      ),
    );
  }
}