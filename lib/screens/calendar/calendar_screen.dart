import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
            children: [
              const CalendarAppBar(),
              Container(
                width: double.infinity,
                height: 1,
                color: StaticColor.headerDevider,
              ),
              Expanded(
                child: CalendarBody()),
            ],
          ),
      ),
    );
  }
}
