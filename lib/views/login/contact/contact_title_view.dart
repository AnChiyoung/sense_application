import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sense_flutter_application/screens/home/home_screen.dart';
import 'dart:async';

class ContactTitleVeiw extends StatefulWidget {
  @override
  _ContactTitleVeiw createState() => _ContactTitleVeiw();
}

class _ContactTitleVeiw extends State<ContactTitleVeiw> {
  final certificationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    NavigatorHome();
  }

  void NavigatorHome() async {
    Timer(const Duration(milliseconds: 5000), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen(initPage: 0)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Text(
          '센스있는 순간을 함께 하고 싶은\n친구를 찾아볼까요?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w700,
            color: const Color.fromRGBO(0, 0, 0, 1),
            height: 1.5,
          ),
        ),
      ),
    );
  }
}
