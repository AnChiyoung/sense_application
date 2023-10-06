import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/views/new_create_event_view/create_event_view/create_event_category_view.dart';
import 'package:sense_flutter_application/views/new_create_event_view/create_event_view/create_event_date_view.dart';
import 'package:sense_flutter_application/views/new_create_event_view/create_event_view/create_event_memo_view.dart';
import 'package:sense_flutter_application/views/new_create_event_view/create_event_view/create_event_region_view.dart';
import 'package:sense_flutter_application/views/new_create_event_view/create_event_view/create_event_target_view.dart';
import 'package:sense_flutter_application/views/new_create_event_view/create_event_view/create_event_title_view.dart';

class CreateEventInfoView02 extends StatefulWidget {
  const CreateEventInfoView02({super.key});

  @override
  State<CreateEventInfoView02> createState() => _CreateEventInfoView02State();
}

class _CreateEventInfoView02State extends State<CreateEventInfoView02> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 20.0.h),
      child: Column(
        children: [
          CreateEventTitleView(),
          SizedBox(height: 16.0.h),
          Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    flex: 1,
                    child: CreateEventCategoryView()),
                SizedBox(width: 26.0.w),
                Expanded(
                    flex: 1,
                    child: CreateEventTargetView()),
              ]
          ),
          SizedBox(height: 8.0.h),
          Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    flex: 1,
                    child: CreateEventDateView()),
                SizedBox(width: 26.0.w),
                Expanded(
                    flex: 1,
                    child: CreateEventRegionView()),
              ]
          ),
          SizedBox(height: 16.0.h),
          CreateEventMemoView(),
        ],
      ),
    );
  }
}
