import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/screens/calendar/calendar_home_screen.dart';
import 'package:sense_flutter_application/screens/contact/contact_screen.dart';
import 'package:sense_flutter_application/screens/feed/feed_screen.dart';
import 'package:sense_flutter_application/screens/mypage/mypage_screen.dart';
import 'package:sense_flutter_application/screens/schedule_create/schedule_create.dart';

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
  
  List<BottomNavigationBarItem> bottomNavigationMenu = [
    BottomNavigationBarItem(icon: Image.asset('assets/home/home.png', width: 18, height: 18.77), label: 'feed'),
    BottomNavigationBarItem(icon: Image.asset('assets/home/calendar.png', width: 18, height: 19.5), label: 'calendar'),
    BottomNavigationBarItem(icon: Image.asset('assets/home/add_schedule.png', width: 14, height: 14), label: 'add_schedule'),
    BottomNavigationBarItem(icon: Image.asset('assets/home/contact.png', width: 23.06, height: 13.51), label: 'contact'),
    BottomNavigationBarItem(icon: Image.asset('assets/home/mypage.png', width: 12, height: 18), label: 'mypage'),
  ];

  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: bottomNavigationMenu,
      currentIndex: pageIndex,
      selectedItemColor: StaticColor.mainSoft,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (index) {
        widget.selectCallback(index);
        pageIndex = index;
      }
    );
  }
}
