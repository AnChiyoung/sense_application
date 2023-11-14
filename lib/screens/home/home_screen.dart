import 'package:flutter/material.dart';

import '../../views/home/home_view.dart';

class HomeScreen extends StatefulWidget {
  final int initPage;
  const HomeScreen({super.key, required this.initPage});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;

  void movePage(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    movePage(widget.initPage);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      /// onWillPop: null은 android back button에만 대응된다. 하단의 방법으로 처리
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: MovePageList.pageList.elementAt(pageIndex),
        ),
        bottomNavigationBar: BottomMenu(
          selectCallback: movePage,
          initPage: pageIndex,
        ),
      ),
    );
  }
}
