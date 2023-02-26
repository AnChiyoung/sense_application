import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/views/calendar/calendar_utils.dart';
import '../../constants/public_color.dart';
import '../../internal_libraries/src/customization/calendar_builders.dart';
import '../../internal_libraries/src/customization/calendar_style.dart';
import '../../internal_libraries/src/shared/utils.dart';
import '../../internal_libraries/src/table_calendar.dart';
import '../../models/calendar/calendar_home_model.dart';

class DUMMY {
  static int currentMonth = DateTime.now().month;
}

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
  int selectDay = 0;
  int selectWeekDayNumber = 0;
  String selectWeekDay = '';

  @override
  void initState() {
    super.initState();

    selectYear = DateTime.now().year;
    selectMonth = DateTime.now().month;
    selectDay = DateTime.now().day;
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
    // bottom sheet 높이 조정
    if(context.read<PageProvider>().bottomSheetHeight != 0.5) {
      print('aa');
      context.read<PageProvider>().bottomSheetHeightController(true);
    }
    context.read<DateProvider>().monthChange(selectedDay.month);

    // 임시 데이터, request로 받아야하는 부분
    af = focusedDay.month.toString();
    selectYear = selectedDay.year;
    selectMonth = selectedDay.month;
    DUMMY.currentMonth = selectedDay.month;
    PublicVariable.ab = selectMonth.toString() + '월';
    selectDay = selectedDay.day;
    selectWeekDayNumber = selectedDay.weekday;
    if (selectWeekDayNumber == 0) {
      selectWeekDay = '일';
    } else if (selectWeekDayNumber == 1) {
      selectWeekDay = '월';
    } else if (selectWeekDayNumber == 2) {
      selectWeekDay = '화';
    } else if (selectWeekDayNumber == 3) {
      selectWeekDay = '수';
    } else if (selectWeekDayNumber == 4) {
      selectWeekDay = '목';
    } else if (selectWeekDayNumber == 5) {
      selectWeekDay = '금';
    } else if (selectWeekDayNumber == 6) {
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
        body: context.watch<PageProvider>().isBuilderPage ? const FullDragUpPage() :
        Stack(
          children: [
            TableCalendar<Event>(
              rowHeight: 80,
              daysOfWeekHeight: 40,
              headerVisible: false,
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              calendarFormat: context.watch<PageProvider>().formatBuilder,
              eventLoader: _getEventsForDay,
              startingDayOfWeek: StartingDayOfWeek.sunday,
              calendarStyle: CalendarStyle(
                cellPadding: const EdgeInsets.only(top: 20),
                cellMargin: const EdgeInsets.only(bottom: 25)
                cellAlignment: Alignment.topCenter,
                outsideDaysVisible: false,
                todayDecoration: BoxDecoration(
                  color: StaticColor.unselectedColor,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: StaticColor.selectDayColor,
                  shape: BoxShape.circle,
                ),
                rowDecoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: StaticColor.rowDevider, width: 1)),
                ),
                markerSize: 8.0,
                markersMaxCount: 8,
                // markerMargin: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                markersOffset: PositionedOffset(start: -1.0),
                markersAutoAligned: true,
                markerDecoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              ),
              calendarBuilders: CalendarBuilders(
                dowBuilder: (context, day) {
                  return Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: StaticColor.rowDevider, width: 1)),
                      ),
                      child: Center(child: Text(days[day.weekday])));
                },
              ),
              onDaySelected: _onDaySelected,
              onRangeSelected: _onRangeSelected,
              onFormatChanged: (format) {
                // CalendarFormat.month;
                // if (_calendarFormat != format) {
                //   setState(() {
                //     _calendarFormat = format;
                //   });
                // }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            // notification listener -> modal bottom sheet live height call
            SizedBox.expand(
              child: NotificationListener<DraggableScrollableNotification> (
                onNotification: (DraggableScrollableNotification dsNotify) {
                  if(dsNotify.extent>=0.8){
                    setState(() {
                      context.read<PageProvider>().pageChangeBuilder(false, CalendarFormat.week);
                    });

                    if(dsNotify.extent>=1.0) {
                      context.read<PageProvider>().pageChangeBuilder(true, CalendarFormat.month);
                    }
                  }
                  else if(dsNotify.extent<0.8){
                    setState(() {
                      context.read<PageProvider>().pageChangeBuilder(false, CalendarFormat.month);
                    });
                  }
                  return true;
                },
                // drag able bottom sheet
                child: DraggableScrollableSheet(
                  initialChildSize: context.watch<PageProvider>().bottomSheetHeight,
                  maxChildSize: 1.0,
                  minChildSize: 0.05,
                  builder: (BuildContext context, ScrollController controller) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                        border: Border.all(
                            width: 1,
                            color: StaticColor.bottomSheetHeaderMain,
                        ),
                      ),
                      child: ListView.builder(
                          controller: controller,
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 21.0),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height * 0.8,
                                child: Column(
                                  children: [
                                    // 헤더
                                    SizedBox(
                                        width: double.infinity,
                                        height: 40,
                                        child: Align(
                                            alignment: Alignment.topCenter,
                                            child: Padding(
                                                padding: const EdgeInsets.only(top: 10),
                                                child: Image.asset('assets/calendar/modal_bottom_sheet_headerline.png', width: 81, height: 4)))),
                                    // 달
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text('$selectMonth월', style: TextStyle(fontSize: 20, color: StaticColor.selectMonthColor, fontWeight: FontWeight.w600))),
                                    SizedBox(height: 8),
                                    // 데이터 영역
                                    SingleChildScrollView(
                                      child: Column(children: [
                                        selectMonth == 2
                                            ? DayEventCollection()
                                            : Container(
                                            padding: const EdgeInsets.only(top: 70), height: MediaQuery.of(context).size.height * 0.7, child: Align(alignment: Alignment.topCenter, child: Text('등록된 일정이 없습니다'))),
                                        // 이벤트 트리거
                                        // Container(height: 100, color: Colors.red), Container(height: 100, color: Colors.yellow)
                                      ]),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}

class FullDragUpPage extends StatefulWidget {
  const FullDragUpPage({Key? key}) : super(key: key);

  @override
  State<FullDragUpPage> createState() => _FullDragUpPageState();
}

class _FullDragUpPageState extends State<FullDragUpPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        children: [
          DayEventCollection(),
        ]
      ),
    );
  }
}

class DayEventCollection extends StatefulWidget {
  const DayEventCollection({Key? key}) : super(key: key);

  @override
  State<DayEventCollection> createState() => _DayEventCollectionState();
}

class _DayEventCollectionState extends State<DayEventCollection> {

  Map<DateTime, List<Event>>? eventList;
  List<Event>? aa;
  String? days;
  int? eventLength;
  List<Widget> cc = [];
  var ee;

  @override
  void initState() {
    eventList = sampleEvent;
    aa = eventList![sampleEvent.keys.elementAt(0)];
    days = sampleEvent.keys.elementAt(0).toString();
    eventLength = aa?.length;
    ee = aa?.asMap().entries.map((e) {
      return EventElement(e: e.key);
    });
    for (int i = 0; i < aa!.length; i++) {
      cc.add(ee!.elementAt(i));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: DUMMY.currentMonth == DateTime.now().month ? Column(children: [
          Row(children: [
            Text('18일 토요일 일정 ', style: TextStyle(fontSize: 14, color: StaticColor.eventDayColor, fontWeight: FontWeight.w600)),
            Text('$eventLength', style: TextStyle(fontSize: 14, color: StaticColor.eventCountColor, fontWeight: FontWeight.w600)),
            Text('건', style: TextStyle(fontSize: 14, color: StaticColor.eventDayColor, fontWeight: FontWeight.w600)),
          ]),
          SizedBox(height: 8),
          Column(children: cc)
        ]) : Container(width: double.infinity, height: 500, child: Center(child: Text('등록된 일정이 없습니다.'))),
      ),
    );
  }
}

class EventElement extends StatefulWidget {
  int e;
  EventElement({Key? key, required this.e}) : super(key: key);

  @override
  State<EventElement> createState() => _EventElementState();
}

class _EventElementState extends State<EventElement> {

  List<Color> eventColorList = [
    Color(0xFFBE6E24),
    Color(0xFFFF7B8B),
    Color(0xFF91C300),
    Color(0xFF6E79DD),
  ];

  Map<DateTime, List<Event>>? eventList;
  List<Event>? aa;

  @override
  void initState() {
    eventList = sampleEvent;
    aa = eventList![sampleEvent.keys.elementAt(0)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: eventColorList.elementAt(widget.e),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: Row(children: [
              Image.asset('assets/calendar/event_header_bar.png', width: 4, height: 40),
              SizedBox(width: 10.0),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(aa!.elementAt(widget.e).title, style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600))),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(aa!.elementAt(widget.e).location, style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w400))),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(aa!.elementAt(widget.e).time, style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w400))),
              ])
            ])),
        SizedBox(height: 26),
      ],
    );
  }
}

class DateProvider with ChangeNotifier {
  int _selectMonth = DateTime.now().month;
  int get selectMonth => _selectMonth;
  void monthChange(int month) {
    _selectMonth = month;
    notifyListeners();
  }
}

class PageProvider with ChangeNotifier {
  bool _isBuilderPage = false;
  bool get isBuilderPage => _isBuilderPage;
  CalendarFormat _format = CalendarFormat.month;
  CalendarFormat get formatBuilder => _format;
  double _bottomSheetHeight = 0.05;
  double get bottomSheetHeight => _bottomSheetHeight;

  void pageChangeBuilder(bool state, CalendarFormat state02) {
    _isBuilderPage = state;
    _format = state02;
    notifyListeners();
  }

  void bottomSheetHeightController(bool isFocus) {
    // isFocus ? _bottomSheetHeight = 0.4 : _bottomSheetHeight = 0.05;
    _bottomSheetHeight = 0.35;
    notifyListeners();
  }
}