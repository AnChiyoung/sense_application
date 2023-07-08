import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';
import 'package:sense_flutter_application/public_widget/behavior_collection.dart';
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

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: CalendarEventList(monthListModels: monthEventMap));
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
      return ListView.builder(
        physics: const ClampingScrollPhysics(),
        itemCount: modelLength,
        itemBuilder: (context, index) {
          /// 일자별 이벤트 리스트
          return DayEventList(model: models!.elementAt(index));
          // return Container(child: Text(models!.elementAt(index).eventDate!, style: TextStyle(color: Colors.black)));
        }
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
  DayEventList({super.key, required this.model});

  @override
  State<DayEventList> createState() => _DayEventListState();
}

class _DayEventListState extends State<DayEventList> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

