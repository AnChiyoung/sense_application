import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/views/event_detail/event_detail_provider.dart';
import 'package:sense_flutter_application/views/event_detail/plan/event_plan_field.dart';
import 'package:sense_flutter_application/views/event_detail/plan/event_plan_title.dart';

class EventPlanView extends StatefulWidget {
  const EventPlanView({super.key});

  @override
  State<EventPlanView> createState() => _EventPlanViewState();
}

class _EventPlanViewState extends State<EventPlanView> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: Column(
        children: [
          const EventPlanTitle(),
          SizedBox(height: 16.0.h),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible( flex: 1, child: EventPlanField(eventField: EnumEventDetailBottomSheetField.category)),
              Flexible( flex: 1, child: EventPlanField(eventField: EnumEventDetailBottomSheetField.target)),
            ],
          ),
          SizedBox(height: 8.0.h),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible( flex: 1, child: EventPlanField(eventField: EnumEventDetailBottomSheetField.date)),
              Flexible( flex: 1, child: EventPlanField(eventField: EnumEventDetailBottomSheetField.region)),
            ],
          ),
        ],
      ),
    );
  }
}