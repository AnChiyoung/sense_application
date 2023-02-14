import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/calendar/calendar_home_view.dart';
import 'package:sense_flutter_application/views/calendar/calendar_utils.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: CalendarBase(),
    );
  }
}
