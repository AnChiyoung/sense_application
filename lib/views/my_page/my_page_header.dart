import 'package:flutter/material.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';
import 'package:sense_flutter_application/routes/setting/setting_screen.dart';

class MyPageHeader extends StatefulWidget {
  const MyPageHeader({super.key});

  @override
  State<MyPageHeader> createState() => _MyPageHeaderState();
}

class _MyPageHeaderState extends State<MyPageHeader> {
  @override
  Widget build(BuildContext context) {
    return HeaderMenu(backCallback: backCallback, rightMenu: rightMenu());
  }

  void backCallback() {
    Navigator.of(context).pop();
  }

  Widget rightMenu() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Material(
          color: Colors.transparent,
          child: SizedBox(
            width: 40,
            height: 40,
            child: InkWell(
              borderRadius: BorderRadius.circular(25.0),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingScreen()));
              },
              child: Center(
                child: Image.asset('assets/my_page/setting.png', width: 24, height: 24),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
