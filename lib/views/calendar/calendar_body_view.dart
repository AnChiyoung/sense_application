import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/calendar/calendar_bottom_sheet.dart';
import 'package:sense_flutter_application/views/calendar/calendar_provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../models/calendar/calendar_home_model.dart';

class CalendarBody extends StatefulWidget {
  @override
  _CalendarBodyState createState() => _CalendarBodyState();
}

class _CalendarBodyState extends State<CalendarBody> {
  // CalendarFormat _calendarFormat = CalendarFormat.month;
  // RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
  //     .toggledOff; // Can be toggled on/off by longpressing a date
  // DateTime? _rangeStart;
  // DateTime? _rangeEnd;

  late final ValueNotifier<List<Event>> _selectedEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  late final ScrollController scrollController = ScrollController();

  static const int _swipeHistoryLimit = 4;
  final List<SwipeDirection> _swipeHistory = [];

  late double deviceHeight;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      scrollListeners();
    });
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
    // return kEvents[DateTime.utc(2023, 7, 4)]!;
    // return [Event('aa'), Event('bb')];
  }

  // List<Event> _getEventsForRange(DateTime start, DateTime end) {
  //   // Implementation example
  //   final days = daysInRange(start, end);
  //
  //   return [
  //     for (final d in days) ..._getEventsForDay(d),
  //   ];
  // }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {

      // showModalBottomSheet(
      //     backgroundColor: Colors.transparent,
      //     context: context,
      //     isScrollControlled: true,
      //     builder: (context) {
      //       return ScheduleBottomSheet();
      //     }
      // );

      context.read<CalendarProvider>().dayChange(_selectedDay!.day);

      setState(() {

        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        // _rangeStart = null; // Important to clean those
        // _rangeEnd = null;
        // _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  scrollListeners() async {
    if (scrollController.offset == scrollController.position.maxScrollExtent
        && !scrollController.position.outOfRange) {
      print('스크롤이 맨 바닥에 위치해 있습니다');
    } else if (scrollController.offset == scrollController.position.minScrollExtent
        && !scrollController.position.outOfRange) {
      print('스크롤이 맨 위에 위치해 있습니다');
    }
  }

  @override
  Widget build(BuildContext context) {

    deviceHeight = MediaQuery.of(context).size.height;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Consumer<CalendarBodyProvider>(
          builder: (context, data, child) {
            print('여기 들어옴!');
            return TableCalendar<Event>(
                locale: 'ko_KR',
                calendarFormat: data.calendarFormat,
                focusedDay: _focusedDay!,
                firstDay: DateTime.utc(DateTime.now().year, 1, 1),
                lastDay: DateTime.utc(DateTime.now().year, 12, 31),
                headerVisible: false,
                daysOfWeekHeight: 40.0,
                rowHeight: 60.0,
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                  /// marker area
                  canMarkersOverflow: false,
                  markersAutoAligned: true,
                  markerSize: 8.0,
                  markerSizeScale: 1.0,
                  markerMargin: const EdgeInsets.only(left: 0.8, right: 0.8, top: 0),
                  markersAlignment: Alignment.bottomCenter,
                  markersMaxCount: 4,
                  markerDecoration: BoxDecoration(
                    color:  StaticColor.mainSoft,
                    shape: BoxShape.circle,
                  ),
                  /// today area
                  isTodayHighlighted: true,
                  todayDecoration: BoxDecoration(
                    color: StaticColor.unSelectedColor,
                    shape: BoxShape.circle,
                  ),
                  cellAlignment: Alignment.topCenter,
                ),
                calendarBuilders: CalendarBuilders(
                    selectedBuilder: (context, dateTime, _) {
                      return selectBuilder(context, dateTime, _, 0);
                    },
                    defaultBuilder: (context, dateTime, _) {
                      return selectBuilder(context, dateTime, _, 1);
                    },
                    todayBuilder: (context, dateTime, _) {
                      return selectBuilder(context, dateTime, _, 2);
                    }
                ),
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: _onDaySelected,
                eventLoader: _getEventsForDay,
                onPageChanged: (date) {
                  context.read<CalendarProvider>().monthChange(date.month);
                }
              // enabledDayPredicate: false,
            );
          },
        ),
        ScheduleBottomSheet(bodyHeight: deviceHeight),
        // SwipeDetector(
        //   onSwipeUp: (offset) {
        //     _addSwipe(SwipeDirection.up);
        //     print('up');
        //   },
        //   onSwipeDown: (offset) {
        //     _addSwipe(SwipeDirection.down);
        //     print('down');
        //   },
        //   onSwipeLeft: (offset) {
        //     _addSwipe(SwipeDirection.left);
        //     print('left');
        //   },
        //   onSwipeRight: (offset) {
        //     _addSwipe(SwipeDirection.right);
        //     print('right');
        //   },
        //   child: Container(width: double.infinity, height: 100),
        // ),
        // GestureDetector(
        //   onVerticalDragEnd: (details) {
        //     if(details.velocity.pixelsPerSecond.dy < 0) {
        //       print('up!');
        //       context.read<CalendarProvider>().calendarFormatChange(CalendarFormat.month);
        //     } else if(details.velocity.pixelsPerSecond.dy > 0) {
        //       print('down!');
        //       context.read<CalendarProvider>().calendarFormatChange(CalendarFormat.week);
        //     }
        //   },
        //   child: Container(
        //     width: double.infinity,
        //     height: 50,
        //     color: Colors.white,
        //   ),
        // ),
        const SizedBox(height: 8.0),
        // Expanded(
        //   child: ValueListenableBuilder<List<Event>>(
        //     valueListenable: _selectedEvents,
        //     builder: (context, value, _) {
        //       return ListView.builder(
        //         controller: scrollController,
        //         itemCount: value.length,
        //         itemBuilder: (context, index) {
        //           return Container(
        //             margin: const EdgeInsets.symmetric(
        //               horizontal: 12.0,
        //               vertical: 4.0,
        //             ),
        //             decoration: BoxDecoration(
        //               border: Border.all(),
        //               borderRadius: BorderRadius.circular(12.0),
        //             ),
        //             child: ListTile(
        //               onTap: () => print('${value[index]}'),
        //               title: Text('${value[index]}'),
        //             ),
        //           );
        //         },
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }

  void _addSwipe(
      SwipeDirection direction,
      ) {
    setState(() {
      _swipeHistory.insert(0, direction);
      if (_swipeHistory.length > _swipeHistoryLimit) {
        _swipeHistory.removeLast();
      }
    });
  }

  Widget selectBuilder(BuildContext context, DateTime dateTime, _, int type) {
    var dayHighlightColor;
    if(type == 0) {
      dayHighlightColor = StaticColor.mainSoft;
    } else if(type == 1) {
      dayHighlightColor = Colors.white;
    } else if(type == 2) {
      dayHighlightColor = StaticColor.dayHighlightColor;
    }
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Align(
        alignment: Alignment.topCenter,
        child: Stack(
            children: [
              Positioned(
                top: 5,
                left: 13,
                right: 13,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: dayHighlightColor,
                  ),
                  child: Center(child: Text(dateTime.day.toString(), style: TextStyle(fontSize: 14, color: type == 0 || type == 2 ? Colors.white : StaticColor.dayTextColor, fontWeight: FontWeight.w600))),
                ),
              ),
            ]
        ),
      ),
    );
  }
}