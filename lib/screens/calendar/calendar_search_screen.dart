import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/calendar/calendar_search_view.dart';

class CalendarSearchScreen extends StatefulWidget {
  const CalendarSearchScreen({super.key});

  @override
  State<CalendarSearchScreen> createState() => _CalendarSearchScreenState();
}

class _CalendarSearchScreenState extends State<CalendarSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SearchAppBar(),
            Container(
              width: double.infinity,
              height: 1,
              color: StaticColor.headerDevider,
            ),
          ],
        ),
      ),
    );
  }
}
