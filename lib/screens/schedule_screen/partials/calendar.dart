import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  int year = 2024;
  int month = 3; // April
  List<String> weeks = [
    'SUN',
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
  ];

  List<DateTime> generateDateList(int year, int month) {
    DateTime firstOfMonth = DateTime(year, month);
    DateTime startDate = firstOfMonth.subtract(Duration(days: firstOfMonth.weekday));
    List<DateTime> dateList = [];
    for (int i = 0; i <= 41; i++) {
      dateList.add(startDate.add(Duration(days: i)));
    }
    return dateList;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom -
        kBottomNavigationBarHeight;
    double screenWidth = MediaQuery.of(context).size.width;

    var formatter = DateFormat('d');
    List<DateTime> dates = generateDateList(year, month);
    double totalDays = dates.length.toDouble();
    double itemWidth = (screenWidth - 40) / weeks.length; // since we have 7 days a week
    int numRows = (totalDays / 7).ceil();
    double itemHeight = (screenHeight - ((16 * 2) + 40)) / numRows;
    double childAspectRatio = itemWidth / itemHeight;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...weeks.map((week) => Expanded(
                    child: Text(
                  week,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFBBBBBB),
                  ),
                )))
          ],
        ),
        const SizedBox(
          height: 6,
        ),
        GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7, // Number of columns
              childAspectRatio: childAspectRatio, // Aspect ratio of each item
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
            ),
            itemCount: dates.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.only(top: 6, bottom: 6),
                alignment: Alignment.topCenter,
                child: Text(
                  formatter.format(dates[index]),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: dates[index].month == month
                        ? const Color(0xFF555555)
                        : const Color(0xFFBBBBBB),
                  ),
                ),
              );
            })
      ],
    );
  }
}
