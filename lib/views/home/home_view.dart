import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/public_widget/service_guide_dialog.dart';
import 'package:sense_flutter_application/screens/add_event/add_event_screen.dart';
import 'package:sense_flutter_application/screens/calendar/calendar_screen.dart';
import 'package:sense_flutter_application/screens/contact/contact_screen.dart';
import 'package:sense_flutter_application/screens/feed/feed_screen.dart';
import 'package:sense_flutter_application/screens/mypage/mypage_screen.dart';

import '../../public_widget/login_dialog.dart';

class MovePageList {
  List<Widget> pageList = [
    FeedScreen(),
    ContactScreen(),
    AddEventScreen(),
    CalendarScreen(),

    /// old version
    // FeedScreen(),
    // CalendarScreen(),
    // AddEventScreen(),
    // ContactScreen(),
    // MypageScreen(),
  ];
}

class BottomMenu extends StatefulWidget {
  Function selectCallback;
  double? safeAreaBottomPadding;
  BottomMenu({Key? key, required this.selectCallback, this.safeAreaBottomPadding}) : super(key: key);

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
                          widget.selectCallback(1);
                          pageIndex = 1;
                          // showDialog(
                          //   context: context,
                          //   //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
                          //   barrierDismissible: false,
                          //   builder: (BuildContext context) {
                          //     return const ServiceGuideDialog();
                          //   }
                          // );
                        },
                        // child: bottomNavigationBarItem('assets/home/store.png', 24.0, '스토어', 1))),
                        child: bottomNavigationBarItem('assets/home/store.png', 24.0, '연락처임시', 1))),
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
                          // widget.selectCallback(2);
                          // pageIndex = 2;
                          showDialog(
                              context: context,
                              //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return const ServiceGuideDialog();
                              }
                          );
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
                          // widget.selectCallback(3);
                          // pageIndex = 3;
                          showDialog(
                              context: context,
                              //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return const ServiceGuideDialog();
                              }
                          );
                        },
                        child: bottomNavigationBarItem('assets/home/calendar.png', 24.0, '캘린더', 3))),
              ),
            ),

            /// old version ; bottom navigation
            // BottomNavigationBar(
            //   elevation: 0.0,
            //   items: bottomNavigationMenu,
            //   currentIndex: pageIndex,
            //   selectedItemColor: StaticColor.mainSoft,
            //   unselectedItemColor: StaticColor.unselectedColor,
            //   type: BottomNavigationBarType.fixed,
            //   showSelectedLabels: false,
            //   showUnselectedLabels: false,
            //   onTap: (index) {
            //     // if(index == 1 || index == 2 || index == 3) {
            //     //   showDialog(
            //     //     context: context,
            //     //     //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
            //     //     barrierDismissible: false,
            //     //     builder: (BuildContext context) {
            //     //       return const ServiceGuideDialog();
            //     //     }
            //     //   );
            //     // } else {
            //     //   widget.selectCallback(index);
            //     // }
            //     widget.selectCallback(index);
            //     pageIndex = index;
            //   }
            // ),
          ]
        ),
      ),
    );
  }

  /// old version
  // Widget addEvent() {
  //   return Container(
  //     width: 40,
  //     height: 40,
  //     decoration: BoxDecoration(
  //       color: StaticColor.mainSoft,
  //       shape: BoxShape.circle,
  //     ),
  //     child: Center(
  //         child: Container(
  //             width: 24,
  //             height: 24,
  //             decoration: BoxDecoration(
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: StaticColor.shadowColor,
  //                   spreadRadius: 5,
  //                   blurRadius: 7,
  //                   offset: const Offset(0, 3),
  //                 ),
  //               ],
  //             ),
  //             child: Image.asset('assets/home/add_event.png'))),
  //   );
  // }
}