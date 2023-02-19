import 'package:flutter/material.dart';
import '../../views/calendar/calendar_appbar_view.dart';
import '../../views/calendar/calendar_body_view.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
          children: [
            CalendarAppBar(),
            Container(
              width: double.infinity,
              height: 1,
              color: Color(0xFFD2DAE8),
            ),
            const Expanded(child: CalendarBase()),
          ],
      ),
    );
  }
}
