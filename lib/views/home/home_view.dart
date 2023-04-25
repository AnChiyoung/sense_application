import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/screens/add_event/add_event_screen.dart';
import 'package:sense_flutter_application/screens/calendar/calendar_screen.dart';
import 'package:sense_flutter_application/screens/contact/contact_screen.dart';
import 'package:sense_flutter_application/screens/feed/feed_screen.dart';
import 'package:sense_flutter_application/screens/mypage/mypage_screen.dart';


import '../../public_widget/alert_dialog_miss_content.dart';

class MovePageList {
  List<Widget> pageList = [
    FeedScreen(),
    CalendarScreen(),
    AddEventScreen(),
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
    feedIcon = 'feed.png'; calendarIcon = 'calendar_old.png'; add_scheduleIcon = 'add_schedule_old.png'; contactIcon = 'contact_old.png'; mypageIcon = 'mypage_old.png';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Widget addEvent() {
      return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: StaticColor.mainSoft,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: StaticColor.shadowColor,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Image.asset('assets/home/add_event.png'))),
      );
    }

    List<BottomNavigationBarItem> bottomNavigationMenu = [
      const BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/home/feed.png'), size: 24), label: 'feed'),
      const BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/home/event.png'), size: 24), label: 'calendar'),
      BottomNavigationBarItem(icon: addEvent(), label: 'add_event'),
      const BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/home/contact.png'), size: 21), label: 'contact'),
      const BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/home/mypage.png'), size: 24), label: 'mypage'),
    ];

    return Container(
      height: 80,
      child: Wrap(
        children: [
          BottomNavigationBar(
            elevation: 0.0,
            items: bottomNavigationMenu,
            currentIndex: pageIndex,
            selectedItemColor: StaticColor.mainSoft,
            unselectedItemColor: StaticColor.unselectedColor,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (index) {
              // 이벤트 생성만 다른 페이지로 변경
              if(index == 2) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddEventScreen()));
              } else {
                widget.selectCallback(index);
              }
              pageIndex = index;
              if(index == 3 || index == 4) {
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