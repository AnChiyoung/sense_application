import 'package:flutter/material.dart';

import '../../views/home/home_view.dart';

class HomeScreen extends StatefulWidget {
  int initPage;
  HomeScreen({Key? key, required this.initPage}) : super(key: key);

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
    movePage(widget.initPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    /// safe area height
    final safeAreaBottomPadding = MediaQuery.of(context).padding.bottom;

    return WillPopScope(
      /// onWillPop: null은 android back button에만 대응된다. 하단의 방법으로 처리
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: MovePageList().pageList.elementAt(pageIndex),
        ),
        bottomNavigationBar: BottomMenu(selectCallback: movePage, safeAreaBottomPadding: safeAreaBottomPadding, initPage: pageIndex),
        // bottomNavigationBar: Container(height: 100),
      ),
    );
  }
}
