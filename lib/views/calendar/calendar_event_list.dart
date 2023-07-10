import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';
import 'package:sense_flutter_application/public_widget/behavior_collection.dart';
import 'package:sense_flutter_application/public_widget/event_category_label.dart';
import 'package:sense_flutter_application/views/calendar/calendar_provider.dart';

class EventList extends StatefulWidget {
  const EventList({Key? key}) : super(key: key);

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {

  final eventListController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Consumer<CalendarProvider>(
      builder: (context, data, child) {

        int selectMonth = data.selectMonth;
        int selectDay = data.selectDay;

        return Expanded(
          child: FutureBuilder(
            future: EventRequest().eventListRequest(selectMonth),
            builder: (context, snapshot) {

              /// 삼항연산자와 if의 구동 로직이 다른가?????? 매우 중요. 왜지..
              /// old version
              // String fetchText = '';
              // if(snapshot.data == null) {
              //   fetchText = 'empty';
              // } else if(snapshot.data != null) {
              //   if(snapshot.data!.isEmpty) {
              //     fetchText = 'empty';
              //   } else if(snapshot.data!.isNotEmpty) {
              //     fetchText = snapshot.data!.elementAt(0).eventTitle!;
              //   }
              // }
              //
              // List<EventModel>? models;
              // snapshot.data == null ? models = [] : models = snapshot.data;
              //
              // String title = '';
              // models == [] ? title = 'empty!!' : models!.elementAt(0).eventTitle;

              if(snapshot.hasError) {
                return const Center(child: Text('Error fetching!!'));
              } else if(snapshot.hasData) {

                if(snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
                } else if(snapshot.connectionState == ConnectionState.done) {

                  if(snapshot.data!.isEmpty) {
                    print('없는곳');
                    return const Center(child: Text('이벤트가 없습니다', style: TextStyle(color: Colors.black)));
                  } else {
                    print('있는곳');
                    /// month total data variable
                    List<Map<String, List<EventModel>>> monthEventMap = [];

                    /// data binding
                    List<EventModel>? models;

                    if(snapshot.data == null) {

                    } else if(snapshot.data != null) {
                      if(snapshot.data!.isEmpty) {

                      } else if(snapshot.data!.isNotEmpty) {
                        models = snapshot.data;
                      }
                    }

                    if(models != null) {
                      /// data sort (빠른 날짜 순)
                      models!.sort((a, b) => DateTime.parse(a.eventDate!).compareTo(DateTime.parse(b.eventDate!)));

                      /// data sort (날짜별로 묶)
                      List<int> eventDayIsolate = [];
                      for(int i = 0; i < models.length; i++) {
                        int day = DateTime.parse(models.elementAt(i).eventDate!).day;
                        eventDayIsolate.add(day);
                      }

                      /// data 중복 제거
                      eventDayIsolate = eventDayIsolate.toSet().toList();

                      /// map 생성
                      for(int i = 0; i < eventDayIsolate.length; i++) {
                        List<EventModel> temperatureModel = [];
                        Map<String, List<EventModel>> temperatureMap = {};
                        for(int j = 0; j < models.length; j++) {
                          if(DateTime.parse(models.elementAt(j).eventDate!).day == eventDayIsolate.elementAt(i)) {
                            temperatureModel.add(models.elementAt(j));
                          }
                        }
                        temperatureMap[eventDayIsolate.elementAt(i).toString()] = temperatureModel;

                        /// 여기가 문제
                        monthEventMap.add(temperatureMap); // List<Map>> attach!!
                        // temperatureModel.clear();
                        // temperatureMap.clear();
                      }

                      /// 결과는??
                      print('why?? : $monthEventMap');
                    }

                    // return Container(height: 30, width: 30, color: Colors.red);
                    return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            EventHeader(),
                            EventHeaderMenu(),
                            CalendarEventList(monthListModels: monthEventMap),
                          ],
                        ));
                  }
                } else {
                  return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
                }

              } else {
                return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
              }
            }
          )
        );
      }
    );
  }

  Widget EventHeaderMenu() {
    return Consumer<CalendarProvider>(
        builder: (context, data, child) {

          String selectMonth = data.selectMonth.toString();

          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$selectMonth월', style: TextStyle(fontSize: 20, color: StaticColor.black90015, fontWeight: FontWeight.w700)),
                Material(
                  color: Colors.transparent,
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(25.0),
                      onTap: () {
                        showModalBottomSheet(context: context, backgroundColor: Colors.transparent, builder: (context) { return Wrap(children: [EventListSettingBottomSheet()]);});
                      },
                      child: Center(child: Image.asset('assets/calendar/calendar_eventlist_setting.png', width: 24, height: 24)),
                    ),
                  ),
                ),
              ]
          );
        }
    );
  }

  Widget EventHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 26),
      child: SizedBox(
        width: double.infinity,
        // child: Image.asset('assets/calendar/event_header_bar.png', width: 81, height: 4),
      ),
    );
  }
}

class CalendarEventList extends StatefulWidget {
  // List<EventModel>? monthListModels;
  List<Map<String, List<EventModel>>>? monthListModels;
  CalendarEventList({super.key, this.monthListModels});

  @override
  State<CalendarEventList> createState() => _CalendarEventListState();
}

class _CalendarEventListState extends State<CalendarEventList> {

  List<Map<String, List<EventModel>>>? models;
  int modelLength = 0;
  ScrollController monthEventListController = ScrollController();

  @override
  void initState() {
    models = widget.monthListModels ?? [];
    modelLength = models!.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if(modelLength == 0) {
      return Center(child: Text('no data..'));
    } else {
      /// 월 전체 이벤트 리스트
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: ListView.builder(
            shrinkWrap: true,
            controller: monthEventListController,
            physics: const ClampingScrollPhysics(),
            itemCount: modelLength,
            itemBuilder: (context, index) {
              /// 일자별 이벤트 리스트
              // return Container(height: 30);
              return DayEventList(model: models!.elementAt(index), controller: monthEventListController);
              // return Container(child: Text(models!.elementAt(index).eventDate!, style: TextStyle(color: Colors.black)));
            }
          ),
        ),
      );
    }
  }
}

// class CalendarEventListRow extends StatefulWidget {
//   const CalendarEventListRow({super.key});
//
//   @override
//   State<CalendarEventListRow> createState() => _CalendarEventListRowState();
// }
//
// class _CalendarEventListRowState extends State<CalendarEventListRow> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

class DayEventList extends StatefulWidget {
  Map<String, List<EventModel>> model;
  ScrollController controller;
  DayEventList({super.key, required this.model, required this.controller});

  @override
  State<DayEventList> createState() => _DayEventListState();
}

class _DayEventListState extends State<DayEventList> {

  // @override
  // void initState() {
  //   context.read
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DayEventsInfo(model: widget.model),
        const SizedBox(height: 8.0),
        DayEventsList(model: widget.model, controller: widget.controller),
        const SizedBox(height: 20.0),
      ],
    );
  }
}

class DayEventsInfo extends StatefulWidget {
  Map<String, List<EventModel>> model;

  DayEventsInfo({super.key, required this.model});

  @override
  State<DayEventsInfo> createState() => _DayEventsInfoState();
}

class _DayEventsInfoState extends State<DayEventsInfo> {

  late Map<String, List<EventModel>> modelMap;
  late List<EventModel> model;
  String day = '';
  String eventCount = '';
  String weekString = '';

  @override
  void initState() {
    modelMap = widget.model;
    /// value로 key값 받아오기로 변경해야 함
    day = modelMap.keys.first;
    model = modelMap[day]!;
    eventCount = model.length.toString();

    /// 요일 catch!!
    int weekDay = DateTime.parse(model.elementAt(0).eventDate!).weekday;
    if(weekDay == 7) {
      weekString = '일';
    } else if(weekDay == 1) {
      weekString = '월';
    } else if(weekDay == 2) {
      weekString = '화';
    } else if(weekDay == 3) {
      weekString = '수';
    } else if(weekDay == 4) {
      weekString = '목';
    } else if(weekDay == 5) {
      weekString = '금';
    } else if(weekDay == 6) {
      weekString = '토';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$day일 $weekString요일', style: TextStyle(fontSize: 16, color: StaticColor.eventDayColor, fontWeight: FontWeight.w700)),
        const SizedBox(width: 6.0),
        Image.asset('assets/calendar/event_list_dot.png', width: 4.0, height: 4.0),
        const SizedBox(width: 6.0),
        Text('일정 $eventCount건', style: TextStyle(fontSize: 16, color: StaticColor.grey50099, fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class DayEventsList extends StatefulWidget {
  Map<String, List<EventModel>> model;
  ScrollController controller;
  DayEventsList({super.key, required this.model, required this.controller});

  @override
  State<DayEventsList> createState() => _DayEventsListState();
}

class _DayEventsListState extends State<DayEventsList> {

  late Map<String, List<EventModel>> modelMap;
  late List<EventModel> model;
  String day = '';
  String eventCount = '';
  String weekString = '';

  @override
  void initState() {
    modelMap = widget.model;
    /// value로 key값 받아오기로 변경해야 함
    day = modelMap.keys.first;
    model = modelMap[day]!;
    eventCount = model.length.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      controller: widget.controller,
      itemCount: int.parse(eventCount),
      itemBuilder: (context, index) {
        // return Container();
        return Column(
          children: [
            GestureDetector(
                onTap: () {
                  widget.controller.jumpTo(100);
                },child: EventRow(model: model.elementAt(index))),
            const Divider(height: 12.0, color: Colors.transparent),
          ],
        );
      }
    );
  }
}

class EventRow extends StatefulWidget {
  EventModel model;
  EventRow({super.key, required this.model});

  @override
  State<EventRow> createState() => _EventRowState();
}

class _EventRowState extends State<EventRow> {

  late EventModel model;
  Widget categoryWidget = const SizedBox.shrink();

  @override
  void initState() {
    model = widget.model;
    if(model.eventCategory!.id == 1) {
      categoryWidget = birthdayLabel;
    } else if(model.eventCategory!.id == 2) {
      categoryWidget = dateLabel;
    } else if(model.eventCategory!.id == 3) {
      categoryWidget = travelLabel;
    } else if(model.eventCategory!.id == 4) {
      categoryWidget = meetLabel;
    } else if(model.eventCategory!.id == 5) {
      categoryWidget = businessLabel;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      width: double.infinity,
      // height: 100,
      decoration: BoxDecoration(
        color: StaticColor.eventBoxColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// title + category
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(model.eventTitle!, style: TextStyle(fontSize: 16, color: StaticColor.black90015, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis),
              categoryWidget
            ]
          ),
          /// location + time range
          Row(
            children: [
              Text('${model.city!.title!} ${model.subCity!.title!}', style: TextStyle(fontSize: 12, color: StaticColor.grey60077, fontWeight: FontWeight.w400)),
              /// 시간 없음. 백 수정
            ],
          ),
        ],
      ),
    );
  }
}

class EventListSettingBottomSheet extends StatefulWidget {
  const EventListSettingBottomSheet({super.key});

  @override
  State<EventListSettingBottomSheet> createState() => _EventListSettingBottomSheetState();
}

class _EventListSettingBottomSheetState extends State<EventListSettingBottomSheet> {

  bool check01 = false, check02 = false, check03 = false, check04 = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
      ),
      child: Column(
        children: [
          /// title section
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 26, top: 24, bottom: 32),
            child: Text('대상', style: TextStyle(fontSize: 18, color: StaticColor.grey80033, fontWeight: FontWeight.w700)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 64),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      check01 = !check01;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                    decoration: BoxDecoration(
                      color: StaticColor.grey100F6,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        check01 == true ? Image.asset('assets/signin/policy_check_done.png', width: 20, height: 20) : Image.asset('assets/signin/policy_check_empty.png', width: 20, height: 20),
                        const SizedBox(width: 8.0),
                        Text('친구', style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                      ]
                    )
                  ),
                ),
                const SizedBox(height: 8.0),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      check02 = !check02;
                    });
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                      decoration: BoxDecoration(
                        color: StaticColor.grey100F6,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                          children: [
                            check02 == true ? Image.asset('assets/signin/policy_check_done.png', width: 20, height: 20) : Image.asset('assets/signin/policy_check_empty.png', width: 20, height: 20),
                            const SizedBox(width: 8.0),
                            Text('가족', style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                          ]
                      )
                  ),
                ),
                const SizedBox(height: 8.0),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      check03 = !check03;
                    });
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                      decoration: BoxDecoration(
                        color: StaticColor.grey100F6,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                          children: [
                            check03 == true ? Image.asset('assets/signin/policy_check_done.png', width: 20, height: 20) : Image.asset('assets/signin/policy_check_empty.png', width: 20, height: 20),
                            const SizedBox(width: 8.0),
                            Text('연인', style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                          ]
                      )
                  ),
                ),
                const SizedBox(height: 8.0),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      check04 = !check04;
                    });
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                      decoration: BoxDecoration(
                        color: StaticColor.grey100F6,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                          children: [
                            check04 == true ? Image.asset('assets/signin/policy_check_done.png', width: 20, height: 20) : Image.asset('assets/signin/policy_check_empty.png', width: 20, height: 20),
                            const SizedBox(width: 8.0),
                            Text('직장', style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                          ]
                      )
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
