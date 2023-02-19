import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/screens/calendar/calendar_home_screen.dart';
import 'package:sense_flutter_application/screens/contact/contact_screen.dart';
import 'package:sense_flutter_application/screens/feed/feed_screen.dart';
import 'package:sense_flutter_application/screens/mypage/mypage_screen.dart';
import 'package:sense_flutter_application/screens/schedule_create/schedule_create.dart';

import '../../public_widget/alert_dialog.dart';

class MovePageList {
  List<Widget> pageList = [
    FeedScreen(),
    CalendarScreen(),
    ScheduleCreateScreen(),
    ContactScreen(),
    MypageScreen(),
  ];
}

class BottomMenu extends StatefulWidget {
  Function selectCallback;
  BottomMenu({Key? key, required this.selectCallback}) : super(key: key);

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {

  String feedIcon = '', calendarIcon = '', add_scheduleIcon = '', contactIcon = '', mypageIcon = '';
  int pageIndex = 0;

  @override
  void initState() {
    feedIcon = 'feed.png'; calendarIcon = 'calendar.png'; add_scheduleIcon = 'add_schedule.png'; contactIcon = 'contact.png'; mypageIcon = 'mypage.png';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    List<BottomNavigationBarItem> bottomNavigationMenu = [
      const BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/home/feed.png'), size: 18), label: 'feed'),
      const BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/home/calendar.png'), size: 18), label: 'calendar'),
      const BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/home/add_schedule.png'), size: 14), label: 'feed'),
      const BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/home/contact.png'), size: 23), label: 'feed'),
      const BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/home/mypage.png'), size: 18), label: 'feed'),
    ];

    return Container(
      height: 80,
      child: Wrap(
        children: [
          BottomNavigationBar(
            items: bottomNavigationMenu,
            currentIndex: pageIndex,
            selectedItemColor: StaticColor.mainSoft,
            unselectedItemColor: StaticColor.unselectedColor,

            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (index) {
              widget.selectCallback(index);
              pageIndex = index;
              if(index == 2 || index == 3 || index == 4) {
                showDialog(
                    context: context,
                    //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return const CustomDialog();
                    });
              }
            }
          ),
        ]
      ),
    );
  }
}