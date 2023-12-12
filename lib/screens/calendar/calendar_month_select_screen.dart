import 'package:flutter/material.dart';

import '../../constants/public_color.dart';
import '../../views/calendar/calendar_month_select_view.dart';

class CalendarMonthSelect extends StatefulWidget {
  const CalendarMonthSelect({super.key});

  @override
  State<CalendarMonthSelect> createState() => _CalendarMonthSelectState();
}

class _CalendarMonthSelectState extends State<CalendarMonthSelect> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Column(
          children: [
            const MonthSelectHeader(),
            const SizedBox(height: 6),
            Container(width: double.infinity, color: StaticColor.selectScreenDevider),
            const MonthSelect(),
          ]
        )
      ),
    );
  }
}
