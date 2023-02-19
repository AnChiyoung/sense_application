import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/views/calendar/calendar_utils.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../constants/public_color.dart';

class CalendarBase extends StatefulWidget {
  const CalendarBase({Key? key}) : super(key: key);

  @override
  State<CalendarBase> createState() => _CalendarBaseState();
}

class _CalendarBaseState extends State<CalendarBase> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  List<String> days = ['_', '월', '화', '수', '목', '금', '토', '일'];

  @override
  void initState() {
    super.initState();

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
    // return kEvents[day] ?? [];
    return sampleEvent[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    // 임시 데이터, request로 받아야하는 부분
    int selectYear = selectedDay.year;
    int selectMonth = selectedDay.month;
    int selectday = selectedDay.day;
    int selectWeekDayNumber = selectedDay.weekday;
    String selectWeekDay = '';
    if(selectWeekDayNumber == 0) {
      selectWeekDay = '일';
    } else if(selectWeekDayNumber == 1) {
      selectWeekDay = '월';
    } else if(selectWeekDayNumber == 2) {
      selectWeekDay = '화';
    } else if(selectWeekDayNumber == 3) {
      selectWeekDay = '수';
    } else if(selectWeekDayNumber == 4) {
      selectWeekDay = '목';
    } else if(selectWeekDayNumber == 5) {
      selectWeekDay = '금';
    } else if(selectWeekDayNumber == 6) {
      selectWeekDay = '토';
    }


    if (!isSameDay(_selectedDay, selectedDay)) {
      Map<DateTime, List<Event>> selectDayEvent = sampleEvent;
      // 특정 날짜 이벤트가 없다면, 가장 빠른 날짜나 오늘로 이동. 어느쪽??
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });
      _selectedEvents.value = _getEventsForDay(selectedDay);
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            )
          ),
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 21.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                  children: [
                    SizedBox(width: double.infinity, height: 40, child: Align(alignment: Alignment.topCenter, child: Padding(padding: EdgeInsets.only(top: 10), child: Image.asset('assets/calendar/modal_bottom_sheet_headerline.png', width: 81, height: 4)))),
                    Align(alignment: Alignment.centerLeft, child: Text('$selectMonth월', style: TextStyle(fontSize: 20, color: StaticColor.selectMonthColor, fontWeight: FontWeight.w600))),
                    Text('$selectday/$selectWeekDay'),
                    SingleChildScrollView(child: Column(
                      children: [
                        
                        // 이벤트 트리거
                        // Container(height: 100, color: Colors.red), Container(height: 100, color: Colors.yellow)
                      ]
                    )),
                    // SingleChildScrollView(
                    //   child: ListView.builder(
                    //     itemCount: sampleEvent.length,
                    //     itemBuilder: (context, index) {
                    //       return Container(
                    //       );
                    //     }
                    //   )
                    // )
                    // ListView.builder(
                    //   itemCount: sampleEvent.length,
                    //   itemBuilder: (context, index) {
                    //     // 일단위 리스트 생성 중
                    //     return Container(
                    //       child: Column(
                    //         children: [
                    //           Text('$selectday/$selectWeekDay'),
                    //         ]
                    //       )
                    //     );
                    //   }
                    // )
                    // ValueListenableBuilder<List<Event>>(
                    //   valueListenable: _selectedEvents,
                    //   builder: (context, value, _) {
                    //     return ListView.builder(
                    //       itemCount: value.length,
                    //       itemBuilder: (context, index) {
                    //         return Container(
                    //           margin: const EdgeInsets.symmetric(
                    //             horizontal: 12.0,
                    //             vertical: 4.0,
                    //           ),
                    //           decoration: BoxDecoration(
                    //             border: Border.all(),
                    //             borderRadius: BorderRadius.circular(12.0),
                    //           ),
                    //           child: ListTile(
                    //             onTap: () => print('${value[index]}'),
                    //             title: Text('${value[index]}'),
                    //           ),
                    //         );
                    //       },
                    //     );
                    //   },
                    // ),
                ]
              ),
              ),
            );
          });
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            TableCalendar<Event>(
              daysOfWeekHeight: 40,
              headerVisible: false,
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              // rangeStartDay: _rangeStart,
              // rangeEndDay: _rangeEnd,
              calendarFormat: _calendarFormat,
              // rangeSelectionMode: _rangeSelectionMode,
              eventLoader: _getEventsForDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: CalendarStyle(
                // Use `CalendarStyle` to customize the UI
                outsideDaysVisible: true,
                todayDecoration: BoxDecoration(
                  color: StaticColor.unselectedColor,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: StaticColor.selectDayColor,
                  shape: BoxShape.circle,
                ),
              ),
              calendarBuilders: CalendarBuilders(
                dowBuilder: (context, day) {
                  return Center(child: Text(days[day.weekday]));
                },
              ),
              onDaySelected: _onDaySelected,
              onRangeSelected: _onRangeSelected,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
        ),



              // daysOfWeekHeight: 40,
              // headerVisible: false,
              // firstDay: kFirstDay,
              // lastDay: kLastDay,
              // focusedDay: _focusedDay,
              //
              // selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              // calendarFormat: _calendarFormat,
              // rangeSelectionMode: _rangeSelectionMode,
              // eventLoader: _getEventsForDay,
              // // startingDayOfWeek: StartingDayOfWeek.monday,
              // calendarStyle: CalendarStyle(
                // Use `CalendarStyle` to customize the UI
                // todayDecoration: BoxDecoration(
                // ),
                // markerSize: 7,
                // outsideDaysVisible: true,
                // selectedDecoration: BoxDecoration(
                //   color: StaticColor.selectDayColor,
                //   shape: BoxShape.circle,
                // ),
              // ),
              // onDaySelected: _onDaySelected,
              // // onRangeSelected: _onRangeSelected,
              // onFormatChanged: (format) {
              //   if (_calendarFormat != format) {
              //     setState(() {
              //       _calendarFormat = format;
              //     });
              //   }
              // },
              // onPageChanged: (focusedDay) {
              //   _focusedDay = focusedDay;
              // },
              // calendarBuilders: CalendarBuilders(
              //   dowBuilder: (context, day) {
              //     return Center(child: Text(days[day.weekday]));
              //   },
              //   markerBuilder: (context, date, events) {
              //     DateTime _date = DateTime(date.year, date.month, date.day);
              //     // if(isSameDay(_date,))
              //   }
              // ),
            // ),
            const SizedBox(height: 8.0),

            // Bottomsheet area
            // Container(
            //   width: double.infinity,
            //   height: 200,
            //   color: Colors.red,
            //   child:
            // )
            // Expanded(
            //   child:
            // ),
          ],
        ),
      ),
    );
  }
}

class DateProvider with ChangeNotifier {
  String _selectMonth = '';
  String get selectMonth => _selectMonth;
  void MonthChange(String month) {
    _selectMonth = month;
    notifyListeners();
  }
}