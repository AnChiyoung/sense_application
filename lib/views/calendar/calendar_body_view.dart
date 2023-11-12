import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';
import 'package:sense_flutter_application/views/calendar/calendar_event_list.dart';
import 'package:sense_flutter_application/views/calendar/calendar_provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../models/calendar/calendar_home_model.dart';

class CalendarBody extends StatefulWidget {
  const CalendarBody({super.key});

  @override
  State<CalendarBody> createState() => _CalendarBodyState();
}

class _CalendarBodyState extends State<CalendarBody> {
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

    context.read<CalendarBodyProvider>().calendarFormatChange(CalendarFormat.month, false);

    scrollController.addListener(() {
      scrollListeners();
    });
    _selectedDay = _focusedDay;
    // _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    // _selectedEvents.dispose();
    super.dispose();
  }

  // Future load
  // List<Event> _getEventsForDay(DateTime day) {
  //   return kEvents[day] ?? [];
  // }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      context.read<CalendarProvider>().dayChange(_selectedDay!.day);
      context.read<CalendarProvider>().yearAndMonthChange(selectedDay);
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      // _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  scrollListeners() async {
    if (scrollController.offset == scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      print('스크롤이 맨 바닥에 위치해 있습니다');
    } else if (scrollController.offset == scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {
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
            List<Map<String, List<EventModel>>> eventList = data.monthEventMap;

            return TableCalendar<Event>(
                locale: 'ko_KR',
                calendarFormat: data.calendarFormat,
                focusedDay: context.watch<CalendarProvider>().selectDate,
                pageJumpingEnabled: true,
                firstDay: DateTime.utc(DateTime.now().year, 1, 1),
                lastDay: DateTime.utc(DateTime.now().year + 5, 12, 31),
                headerVisible: false,
                daysOfWeekHeight: 40.0,
                rowHeight: 60.0,
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                  canMarkersOverflow: false,
                  isTodayHighlighted: true,
                  todayDecoration: BoxDecoration(
                    color: StaticColor.unSelectedColor,
                    shape: BoxShape.circle,
                  ),
                  cellAlignment: Alignment.topCenter,
                ),
                calendarBuilders: CalendarBuilders(selectedBuilder: (context, dateTime, _) {
                  return selectBuilder(context, dateTime, _, 0);
                }, defaultBuilder: (context, dateTime, _) {
                  return selectBuilder(context, dateTime, _, 1);
                }, todayBuilder: (context, dateTime, _) {
                  return selectBuilder(context, dateTime, _, 2);
                }, markerBuilder: (context, dateTime, _) {
                  // print('marker!!!! : $dateTime');

                  List<Widget> markerWidgets = [];

                  for (int i = 0; i < eventList.length; i++) {
                    if (eventList.elementAt(i).keys.toString() == null) {
                    } else {
                      /// 날짜에 이벤트가 있다면,
                      int markerCount = 0;
                      if (dateTime.day.toString() == eventList.elementAt(i).keys.first.toString()) {
                        List<EventModel> temperatureList =
                            eventList.elementAt(i)[eventList.elementAt(i).keys.first] ?? [];

                        if (dateTime.month ==
                                int.parse(
                                    temperatureList.elementAt(0).eventDate!.substring(5, 7)) &&
                            dateTime.year ==
                                int.parse(
                                    temperatureList.elementAt(0).eventDate!.substring(0, 4))) {
                          for (var e in temperatureList) {
                            if (markerCount > 3) {
                              /// non add
                            } else {
                              if (e.eventCategoryObject == null) {
                              } else {
                                markerWidgets.add(
                                    personalEventMarkerBuilder(e.eventCategoryObject!.id ?? 0));
                              }
                            }
                            markerCount++;
                          }
                        }
                      }
                    }
                  }
                  return Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: markerWidgets,
                    ),
                  );
                }),
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: _onDaySelected,
                // eventLoader: _getEventsForDay,
                onPageChanged: (date) {
                  print('change day: $date');
                  _onDaySelected(date, date);
                  // context.read<CalendarProvider>().yearAndMonthChange(date);
                });
          },
        ),
        const EventBottomSheet(),
        // ScheduleBottomSheet(bodyHeight: deviceHeight),
        const SizedBox(height: 8.0),
      ],
    );
  }

  Widget EventHeaderMenu() {
    return Consumer<CalendarProvider>(builder: (context, data, child) {
      String selectMonth = data.selectMonth.toString();

      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('$selectMonth월',
            style: TextStyle(
                fontSize: 20, color: StaticColor.black90015, fontWeight: FontWeight.w700)),

        /// disabled. kind of event filter. 20230813
        // Material(
        //   color: Colors.transparent,
        //   child: SizedBox(
        //     width: 40,
        //     height: 40,
        //     child: InkWell(
        //       borderRadius: BorderRadius.circular(25.0),
        //       onTap: () {
        //         showModalBottomSheet(context: context, backgroundColor: Colors.transparent, builder: (context) { return Wrap(children: [EventListSettingBottomSheet()]);});
        //       },
        //       child: Center(child: Image.asset('assets/calendar/calendar_eventlist_setting.png', width: 24, height: 24)),
        //     ),
        //   ),
        // ),
      ]);
    });
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

  Widget personalEventMarkerBuilder([int? eventType]) {
    Color markerColor = StaticColor.markerDefaultColor;

    if (eventType == null) {
    } else {
      if (eventType == 0) {
      } else if (eventType == 1) {
        markerColor = StaticColor.birthdayLabelColor;
      } else if (eventType == 2) {
        markerColor = StaticColor.dateLabelColor;
      } else if (eventType == 3) {
        markerColor = StaticColor.travelLabelColor;
      } else if (eventType == 4) {
        markerColor = StaticColor.meetLabelColor;
      } else if (eventType == 5) {
        markerColor = StaticColor.businessLabelColor;
      }
    }

    return Row(
      children: [
        SizedBox(width: 1.0.w),
        Container(
          padding: const EdgeInsets.only(top: 20.0),
          height: double.infinity,
          child: Container(
            width: 8.0.w,
            height: 8.0.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: markerColor,
            ),
          ),
        ),
        SizedBox(width: 1.0.w),
      ],
    );
  }

  Widget selectBuilder(BuildContext context, DateTime dateTime, _, int type) {
    Color dayHighlightColor = Colors.white;
    if (type == 0) {
      dayHighlightColor = StaticColor.mainSoft;
    } else if (type == 1) {
      dayHighlightColor = Colors.white;
    } else if (type == 2) {
      dayHighlightColor = StaticColor.dayHighlightColor;
    }
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      // color: Colors.grey,
      child: Align(
        alignment: Alignment.topCenter,
        child: Stack(children: [
          Positioned(
            top: 5,
            left: 13,
            right: 13,
            child: Container(
              width: 27,
              height: 27,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: dayHighlightColor,
              ),
              child: Center(
                  child: Text(dateTime.day.toString(),
                      style: TextStyle(
                          fontSize: 14,
                          color: type == 0 || type == 2 ? Colors.white : StaticColor.dayTextColor,
                          fontWeight: FontWeight.w600))),
            ),
          ),
        ]),
      ),
    );
  }
}

class EventBottomSheet extends StatefulWidget {
  const EventBottomSheet({super.key});

  @override
  State<EventBottomSheet> createState() => _EventBottomSheetState();
}

class _EventBottomSheetState extends State<EventBottomSheet> {
  bool dragDirection = false;
  late DraggableScrollableController _controller;

  @override
  void initState() {
    _controller = DraggableScrollableController();
    _controller.addListener(() {
      if (_controller.size > 0.7) {
        context.read<CalendarBodyProvider>().calendarFormatChange(CalendarFormat.week, true);
      } else {
        context.read<CalendarBodyProvider>().calendarFormatChange(CalendarFormat.month, true);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        int sensitivity = 5;
        if (details.delta.dy > sensitivity) {
          print('down!!');
          dragDirection = false;
        } else if (details.delta.dy < -sensitivity) {
          print('up!!');
          dragDirection = true;
        }
      },
      child: DraggableScrollableSheet(
        controller: _controller,
        expand: true,
        initialChildSize: 0.40,
        maxChildSize: 0.85,
        minChildSize: 0.40,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              // borderRadius: const BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
              border: Border(
                top: BorderSide(color: StaticColor.grey400BB, width: 1),
              ),
            ),
            child: Column(
              children: [
                ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    controller: scrollController,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      SizedBox(width: double.infinity, height: 30.0.h),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                          child: EventHeaderMenu()),
                    ]),
                  ),
                ),

                /// event header + event header menu => event list area
                const EventList(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget EventHeaderMenu() {
    return Consumer<CalendarProvider>(builder: (context, data, child) {
      String selectMonth = data.selectMonth.toString();

      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('$selectMonth월',
            style: TextStyle(
                fontSize: 20, color: StaticColor.black90015, fontWeight: FontWeight.w700)),

        /// disabled. kind of event filter. 20230813
        // Material(
        //   color: Colors.transparent,
        //   child: SizedBox(
        //     width: 40,
        //     height: 40,
        //     child: InkWell(
        //       borderRadius: BorderRadius.circular(25.0),
        //       onTap: () {
        //         showModalBottomSheet(context: context, backgroundColor: Colors.transparent, builder: (context) { return Wrap(children: [EventListSettingBottomSheet()]);});
        //       },
        //       child: Center(child: Image.asset('assets/calendar/calendar_eventlist_setting.png', width: 24, height: 24)),
        //     ),
        //   ),
        // ),
      ]);
    });
  }
}
