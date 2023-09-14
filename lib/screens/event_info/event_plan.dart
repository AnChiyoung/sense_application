import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';
import 'package:sense_flutter_application/views/create_event/create_event_improve_provider.dart';
import 'package:sense_flutter_application/views/create_event/create_event_provider.dart';
import 'package:sense_flutter_application/views/event_info/event_info_content_plan.dart';

class EventPlan extends StatefulWidget {
  const EventPlan({super.key});

  @override
  State<EventPlan> createState() => _EventPlanState();
}

class _EventPlanState extends State<EventPlan> {

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateEventImproveProvider>(
      builder: (context, data, child) {

        List<String> cityNameList = ['서울', '경기도', '인천', '강원도', '경상도', '전라도', '충청도', '부산', '제주'];

        String title = data.title.isEmpty ? '-' : data.title;
        int category = data.category == -1 ? -1 : data.category - 1;
        int target = data.target == -1 ? -1 : data.target - 1;
        String date = data.date.isEmpty ? '' : data.date;
        String memo = data.memo.isEmpty ? '-' : data.memo;
        String city = context.read<CreateEventProvider>().city == -1 ? '-' : cityNameList.elementAt(context.read<CreateEventProvider>().city);

        return Padding(
          padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 16.0.w),
          child: Column(
            children: [
              EventInfoPlanTitle(title: title),
              SizedBox(height: 16.0.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      flex: 1,
                      child: EventInfoPlanCategory(category: category)),
                  Flexible(
                      flex: 1,
                      child: EventInfoPlanTarget(target: target)),
                ],
              ),
              SizedBox(height: 8.0.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      flex: 1,
                      child: EventInfoPlanDate(date: date)),
                  Flexible(
                      flex: 1,
                      child: EventInfoPlanRegion(city: city)),
                ],
              ),
              SizedBox(height: 16.0.h),
              EventInfoPlanMemo(memo: memo),
              SizedBox(height: 33.0.h),
              RecommendField(),
            ],
          ),
        );
      }
    );
  }
}