import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';
import 'package:sense_flutter_application/views/create_event/create_event_improve_provider.dart';
import 'package:sense_flutter_application/views/event_info/event_info_content.dart';
import 'package:sense_flutter_application/views/event_info/event_info_header.dart';
import 'package:sense_flutter_application/views/event_info/event_info_tab.dart';

class EventInfoLoadView extends StatefulWidget {
  const EventInfoLoadView({super.key});

  @override
  State<EventInfoLoadView> createState() => _EventInfoLoadViewState();
}

class _EventInfoLoadViewState extends State<EventInfoLoadView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: EventRequest().eventRequest(context.read<CreateEventImproveProvider>().eventUniqueId),
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return Text('Data fetching..', style: TextStyle(color: Colors.black));
        } else if(snapshot.hasData) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Text('Data fetching..', style: TextStyle(color: Colors.black));
          } else if(snapshot.connectionState == ConnectionState.done) {

            EventModel loadEventModel = snapshot.data ?? EventModel();

            String title = loadEventModel.eventTitle ?? '';
            context.read<CreateEventImproveProvider>().eventDataLoad(
              loadEventModel.eventTitle ?? '',
              loadEventModel.eventCategoryObject!.id ?? -1,
              loadEventModel.targetCategoryObject!.id ?? -1,
              loadEventModel.eventDate ?? '',
              loadEventModel.description ?? ''
            );

            return Column(
              children: [
                /// 이벤트 타이틀 변경이 일어나면 헤더도 변화
                Consumer<CreateEventImproveProvider>(
                  builder: (context, data, child) {
                    String title = data.title;
                    return EventInfoHeader(title: title);
                  }
                ),
                EventInfoTabBar(),
                EventContent(),
              ],
            );

          } else {
            return Text('Data fetching..', style: TextStyle(color: Colors.black));
          }
        } else {
          return Text('Data fetching..', style: TextStyle(color: Colors.black));
        }
      }
    );
  }
}