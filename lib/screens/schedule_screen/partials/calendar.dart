import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Calendar extends StatefulWidget {
  final double widgetSize;
  final double height;

  const Calendar({
    super.key,
    required this.widgetSize,
    required this.height,
  });

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime presentDate = DateTime.now();

  List<String> weeks = [
    'SUN',
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
  ];

  List<DateTime> generateDateList() {
    int year = presentDate.year;
    int month = presentDate.month; // April
    DateTime firstOfMonth = DateTime(year, month);
    DateTime startDate = firstOfMonth.subtract(Duration(days: firstOfMonth.weekday));
    List<DateTime> dateList = [];
    for (int i = 0; i <= 41; i++) {
      dateList.add(startDate.add(Duration(days: i)));
    }
    return dateList;
  }

  List<DateTime> generateWeekFromDate({bool startFromMonday = false}) {
    // Find the last Sunday (or Monday if startFromMonday is true)
    DateTime date = DateTime.now();
    int backToDay = startFromMonday ? (date.weekday - 1) % 7 : (date.weekday) % 7;
    DateTime startDate = date.subtract(Duration(days: backToDay));

    // Generate the week list starting from the calculated start date
    List<DateTime> weekList = [];
    for (int i = 0; i < 7; i++) {
      weekList.add(startDate.add(Duration(days: i)));
    }
    return weekList;
  }

  Widget dayItem(DateTime d, double screenWidth) {
    var formatter = DateFormat('d');
    return d.month == presentDate.month
        ? Text(
            formatter.format(d),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: (14 / 375 * screenWidth),
              color: d.day == presentDate.day ? Colors.white : const Color(0xFF555555),
            ),
          )
        : Text(
            formatter.format(d),
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: (14 / 375 * screenWidth),
                color: const Color(0xFFBBBBBB)),
          );
  }

  Widget circleDotEvents({double screenWidth = 375}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: (5 / 375) * screenWidth,
          height: (5 / 375) * screenWidth,
          child: Container(
            margin: const EdgeInsets.only(left: 2),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(255, 123, 139, 1),
            ),
          ),
        ),
        SizedBox(
          width: (5 / 375) * screenWidth,
          height: (5 / 375) * screenWidth,
          child: Container(
            margin: const EdgeInsets.only(left: 2),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(250, 136, 54, 1),
            ),
          ),
        ),
        SizedBox(
          width: (5 / 375) * screenWidth,
          height: (5 / 375) * screenWidth,
          child: Container(
            margin: const EdgeInsets.only(left: 2),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(62, 151, 255, 1),
            ),
          ),
        ),
        SizedBox(
          width: (5 / 375) * screenWidth,
          height: (5 / 375) * screenWidth,
          child: Container(
            margin: const EdgeInsets.only(left: 2),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(0, 203, 154, 1),
            ),
          ),
        )
      ],
    );
  }

  Widget eventTiles({double screenWidth = 375}) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                height: (13 / 375) * screenWidth,
                padding: const EdgeInsets.all(2),
                color: const Color.fromRGBO(255, 123, 139, 1),
                child: Text(
                  '현경이 생일파티',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 9 / 375 * screenWidth,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Container(
                height: (13 / 375) * screenWidth,
                padding: const EdgeInsets.all(2),
                color: const Color.fromRGBO(250, 136, 54, 1),
                child: Text(
                  '현경이 생일파티',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 9 / 375 * screenWidth,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              '+2',
              style: TextStyle(
                color: const Color(0xFF999999),
                fontSize: 12 / 375 * screenWidth,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print('HEIGHT: ${}');
    // double floatingHeight = 40;
    // double padding = 40;
    // double screenHeight = widget.height - (kBottomNavigationBarHeight + floatingHeight + 16);
    // double screenWidth = MediaQuery.of(context).size.width - padding;
    List<DateTime> dates = widget.widgetSize >= 0.8 ? generateWeekFromDate() : generateDateList();
    double totalDays = dates.length.toDouble();
    // double itemWidth = (screenWidth) / weeks.length; // since we have 7 days a week
    // int numRows = (totalDays / 7).ceil();

    // double ceilHeight = widget.height * widget.widgetSize - 16;
    // double itemHeight = ceilHeight / 6;
    // double childAspectRatio = widget.widgetSize >= 0.4
    //     ? itemWidth / (((widget.height * widget.widgetSize)) / numRows)
    //     : itemWidth / itemHeight;

    // return Container(
    //   color: Colors.red,
    // );

    return Container(
      height: widget.height,
      color: Colors.white,
      child: Column(
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
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                double screenWidth = constraints.maxWidth;
                double screenHeight = constraints.maxHeight;
                double itemWidth = (screenWidth) / weeks.length;
                double totalDays = dates.length.toDouble();
                int numRows = (totalDays / 7).ceil();
                double itemHeight = (screenHeight) / numRows;
                double childAspectRatio = widget.widgetSize <= 0
                    ? itemWidth / itemHeight
                    : itemWidth / (screenHeight / numRows);

                print('screen width: ${MediaQuery.of(context).size.width}');
                print('layout width: ${constraints.maxWidth}');
                print('layout height: ${constraints.maxHeight}');
                print('widget.widgetSize ${widget.widgetSize}');

                return SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  // color: Colors.red,
                  child: GridView.builder(
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
                          decoration: const BoxDecoration(
                              // border: Border.all(
                              //   color: Colors.black,
                              //   width: 0.5,
                              // ),
                              ),
                          padding: EdgeInsets.only(
                            top: 6 / 375 * screenWidth,
                            bottom: 6 / 375 * screenWidth,
                            left: 2,
                            right: 2,
                          ),
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 24 / 375 * screenWidth,
                                height: 24 / 375 * screenWidth,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: dates[index].day == presentDate.day
                                      ? const Color.fromRGBO(21, 21, 21, 0.6)
                                      : Colors.transparent,
                                ),
                                child: dayItem(dates[index], screenWidth),
                              ),
                              SizedBox(
                                height: 6 / 375 * screenWidth,
                              ),
                              if (dates[index].day == presentDate.day || dates[index].day == 23)
                                widget.widgetSize > 0
                                    ? circleDotEvents(screenWidth: screenWidth)
                                    : eventTiles(screenWidth: screenWidth),
                            ],
                          ),
                        );
                      }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
