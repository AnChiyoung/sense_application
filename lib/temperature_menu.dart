import 'package:flutter/material.dart';
import 'package:sense_flutter_application/screens/calendar/calendar_screen.dart';
import 'package:sense_flutter_application/screens/event/add_event_screen.dart';
import 'package:sense_flutter_application/screens/login/login_screen.dart';

class TemperatureMenu extends StatefulWidget {
  const TemperatureMenu({Key? key}) : super(key: key);

  @override
  State<TemperatureMenu> createState() => _TemperatureMenuState();
}

class _TemperatureMenuState extends State<TemperatureMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
          },
          child: Text('로그인 / 회원가입')
        ),
        const SizedBox(height: 10),
        OutlinedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => AddEventScreen()));
            },
            child: Text('이벤트 생성 + 추천목록')
        ),
        const SizedBox(height: 10),
        OutlinedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => CalendarScreen()));
            },
            child: Text('달력이요')
        ),
      ],
    );
  }
}
