import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/views/new_create_event_view/create_event_view/create_event_category_view.dart';
import 'package:sense_flutter_application/views/new_create_event_view/create_event_view/create_event_date_view.dart';
import 'package:sense_flutter_application/views/new_create_event_view/create_event_view/create_event_memo_view.dart';
import 'package:sense_flutter_application/views/new_create_event_view/create_event_view/create_event_region_view.dart';
import 'package:sense_flutter_application/views/new_create_event_view/create_event_view/create_event_target_view.dart';
import 'package:sense_flutter_application/views/new_create_event_view/create_event_view/create_event_title_view.dart';

class PlanView extends StatefulWidget {
  const PlanView({super.key});

  @override
  State<PlanView> createState() => _PlanViewState();
}

class _PlanViewState extends State<PlanView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CreateEventTitleView(edit: true),
          SizedBox(height: 16.0.h),
          Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    flex: 1,
                    child: CreateEventCategoryView(edit: true)),
                SizedBox(width: 26.0.w),
                Expanded(
                    flex: 1,
                    child: CreateEventTargetView(edit: true)),
              ]
          ),
          SizedBox(height: 8.0.h),
          Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    flex: 1,
                    child: CreateEventDateView(edit: true)),
                SizedBox(width: 26.0.w),
                Expanded(
                    flex: 1,
                    child: CreateEventRegionView(edit: true)),
              ]
          ),
          SizedBox(height: 16.0.h),
          CreateEventMemoView(),
        ],
      ),
    );
  }
}
