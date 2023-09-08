import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';
import 'package:sense_flutter_application/views/create_event/create_event_improve_provider.dart';
import 'package:sense_flutter_application/screens/event_info/event_plan.dart';
import 'package:sense_flutter_application/views/event_info/event_info_content_recommend.dart';

class EventContent extends StatefulWidget {
  const EventContent({super.key});

  @override
  State<EventContent> createState() => _EventContentState();
}

class _EventContentState extends State<EventContent> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateEventImproveProvider>(
        builder: (context, data, child) {

          if(data.eventInfoTabState.indexOf(true) == 0) {
            return EventPlan();
          } else if(data.eventInfoTabState.indexOf(true) == 1) {
            return EventRecommend();
          } else {
            return const Center(child: Text('Data fetching..', style: TextStyle(color: Colors.black)));
          }
        }
    );
  }
}
