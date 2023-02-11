import 'package:flutter/material.dart';

import '../../views/home/home_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MovePageList().pageList.elementAt(pageIndex),
      ),
      bottomNavigationBar: BottomMenu(selectCallback: movePage),
    );
  }
}
