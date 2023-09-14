import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';
import 'package:sense_flutter_application/views/my_page/my_page_provider.dart';

class MyInfoUpdateHeader extends StatefulWidget {
  const MyInfoUpdateHeader({super.key});

  @override
  State<MyInfoUpdateHeader> createState() => _MyInfoUpdateHeaderState();
}

class _MyInfoUpdateHeaderState extends State<MyInfoUpdateHeader> {
  @override
  Widget build(BuildContext context) {
    return HeaderMenu(backCallback: backCallback, title: '내 정보');
  }

  void backCallback() {
    context.read<MyPageProvider>().updateInfoInit();
    Navigator.of(context).pop();
  }
}
