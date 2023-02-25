import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/calendar/calendar_utils.dart';
import '../../constants/public_color.dart';
import '../../internal_libraries/calendar/src/customization/calendar_builders.dart';
import '../../internal_libraries/calendar/src/customization/calendar_style.dart';
import '../../internal_libraries/calendar/src/shared/utils.dart';
import '../../internal_libraries/calendar/src/table_calendar.dart';
import '../../models/calendar/calendar_home_model.dart';

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

  String af = '';

  List<String> days = ['_', '월', '화', '수', '목', '금', '토', '일'];

  int selectYear = 0;
  int selectMonth = 0;
  int selectday = 0;
  int selectWeekDayNumber = 0;
  String selectWeekDay = '';

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
    af = focusedDay.month.toString();
    selectYear = selectedDay.year;
    selectMonth = selectedDay.month;
    PublicVariable.ab = selectMonth.toString() + '월';
    selectday = selectedDay.day;
    selectWeekDayNumber = selectedDay.weekday;
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
      // Map<DateTime, List<Event>> selectDayEvent = sampleEvent;
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
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            )
          ),
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                  children: [
                    SizedBox(width: double.infinity, height: 40, child: Align(alignment: Alignment.topCenter, child: Padding(padding: EdgeInsets.only(top: 10), child: Image.asset('assets/calendar/modal_bottom_sheet_headerline.png', width: 81, height: 4)))),
                    Align(alignment: Alignment.centerLeft, child: Text('$selectMonth월', style: TextStyle(fontSize: 20, color: StaticColor.selectMonthColor, fontWeight: FontWeight.w600))),
                    SizedBox(height: 8),
                    SingleChildScrollView(child: Column(
                      children: [
                        selectMonth == 2 ? DayEventCollection() : Container(height: MediaQuery.of(context).size.height * 0.7, child: Align(alignment: Alignment.center, child: Text('등록된 일정이 없습니다'))),
                        // 이벤트 트리거
                        // Container(height: 100, color: Colors.red), Container(height: 100, color: Colors.yellow)
                      ]
                    )),
                ]
              ),
              ),
            );
          });
    }
  }

  Widget DayEventCollection() {
    Map<DateTime, List<Event>> eventList = sampleEvent;
    List<Event>? aa = eventList[sampleEvent.keys.elementAt(0)];
    String days = sampleEvent.keys.elementAt(0).toString();
    int? eventLength = aa?.length;
    List<Widget> cc = [];
    var ee = aa?.asMap().entries.map((e) {
      return EventElement(e.key);
    });
    for(int i = 0; i < aa!.length; i++) {
      cc.add(ee!.elementAt(i));
    }

    return Column(
      children: [
        Row(
          children: [
            Text('18일 $selectWeekDay요일 일정 ', style: TextStyle(fontSize: 14, color: StaticColor.eventDayColor, fontWeight: FontWeight.w600)),
            Text('$eventLength', style: TextStyle(fontSize: 14, color: StaticColor.eventCountColor, fontWeight: FontWeight.w600)),
            Text('건', style: TextStyle(fontSize: 14, color: StaticColor.eventDayColor, fontWeight: FontWeight.w600)),
          ]
        ),
        SizedBox(height: 8),
        Column(
          children: cc
        )
      ]
    );
  }

  Widget EventElement(int e) {
    List<Color> eventColorList = [
      Color(0xFFBE6E24),
      Color(0xFFFF7B8B),
      Color(0xFF91C300),
      Color(0xFF6E79DD),
    ];

    Map<DateTime, List<Event>> eventList = sampleEvent;
    List<Event>? aa = eventList[sampleEvent.keys.elementAt(0)];

    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: eventColorList.elementAt(e),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: Row(
            children: [
              Image.asset('assets/calendar/event_header_bar.png', width: 4, height: 40),
              SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(alignment: Alignment.centerLeft, child: Text(aa!.elementAt(e).title, style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600))),
                  Align(alignment: Alignment.centerLeft, child: Text(aa!.elementAt(e).location, style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w400))),
                  Align(alignment: Alignment.centerLeft, child: Text(aa!.elementAt(e).time, style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w400))),
                ]
              )
            ]
          )
        ),
        SizedBox(height: 26),
      ],
    );
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
              calendarFormat: _calendarFormat,
              rangeSelectionMode: _rangeSelectionMode,
              eventLoader: _getEventsForDay,
              startingDayOfWeek: StartingDayOfWeek.sunday,
              calendarStyle: CalendarStyle(
                outsideDaysVisible: true,
                todayDecoration: BoxDecoration(
                  color: StaticColor.unselectedColor,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: StaticColor.selectDayColor,
                  shape: BoxShape.circle,
                ),
                markerSize: 8.0,
                markersMaxCount: 8,
                markerMargin: const EdgeInsets.symmetric(horizontal: 2),
                markersAutoAligned: true,
                markerDecoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle
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