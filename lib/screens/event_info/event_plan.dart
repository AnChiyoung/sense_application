import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/event_info/event_info_content_plan.dart';

class EventPlan extends StatefulWidget {
  const EventPlan({super.key});

  @override
  State<EventPlan> createState() => _EventPlanState();
}

class _EventPlanState extends State<EventPlan> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EventInfoView(),
        // RecommendView(),
      ],
    );
  }
}
