import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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

              String fetchText = '';
              if(snapshot.data == null) {
                fetchText = 'empty';
              } else if(snapshot.data != null) {
                if(snapshot.data!.isEmpty) {
                  fetchText = 'empty';
                } else if(snapshot.data!.isNotEmpty) {
                  fetchText = snapshot.data!.elementAt(0).eventTitle!;
                }
              }

              // List<EventModel>? models;
              // snapshot.data == null ? models = [] : models = snapshot.data;
              //
              // String title = '';
              // models == [] ? title = 'empty!!' : models!.elementAt(0).eventTitle;

              /// 삼항연산자와 if의 구동 로직이 다른가?????? 매우 중요. 왜지..










              return Text(fetchText, style: TextStyle(color: Colors.black));
            }
          )
        );
      }
    );
  }
}
