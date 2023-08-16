import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/create_event/create_event_provider.dart';
import 'package:sense_flutter_application/views/event_info/event_info_provider.dart';
import 'package:sense_flutter_application/views/event_info/event_info_content_plan.dart';

class EventRecommendFinish extends StatefulWidget {
  const EventRecommendFinish({super.key});

  @override
  State<EventRecommendFinish> createState() => _EventRecommendFinishState();
}

class _EventRecommendFinishState extends State<EventRecommendFinish> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 16.0.w),
      child: Column(
        children: [
          SizedBox(height: 16.0.h),
          Row(
            children: [
              Flexible(
                  flex: 1,
                  child: EventInfoPlanCategory()),
              SizedBox(width: 4.0.w),
              Flexible(
                  flex: 1,
                  child: EventInfoPlanTarget()),
            ],
          ),
          SizedBox(height: 8.0.h),
          Row(
            children: [
              Flexible(
                  flex: 1,
                  child: EventInfoPlanDate()),
              SizedBox(width: 4.0.w),
              Flexible(
                  flex: 1,
                  child: EventInfoPlanRegion()),
            ],
          ),
          SizedBox(height: 8.0.h),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: EventInfoPlanRecommendCategory()),
              SizedBox(width: 4.0.w),
              Expanded(
                  flex: 1,
                  child: EventInfoPlanRecommendCost()),
              SizedBox(width: 4.0.w),
            ],
          ),
          SizedBox(height: 16.0.h),
          EventInfoPlanMemo(),
          SizedBox(height: 33.0.h),
          RecommendField(),
        ],
      ),
    );
  }
}

class EventInfoPlanRecommendCategory extends StatefulWidget {
  const EventInfoPlanRecommendCategory({super.key});

  @override
  State<EventInfoPlanRecommendCategory> createState() => _EventInfoPlanRecommendCategoryState();
}

class _EventInfoPlanRecommendCategoryState extends State<EventInfoPlanRecommendCategory> {
  String recommendCategoryTitle = '요청';
  String recommendCategoryString = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateEventProvider>(
        builder: (context, data, child) {

          List<int> categoryState = data.recommendCategoryNumber;

          if(data.recommendCategoryNumber.isEmpty) {
            recommendCategoryString = '-';
          } else {
            String temperatureString = '';
            for(int i = 0; i < categoryState.length; i++) {

              if(categoryState.elementAt(i) == 1) {
                temperatureString = '선물';
              } else if(categoryState.elementAt(i) == 2) {
                temperatureString = '호텔';
              } else if(categoryState.elementAt(i) == 3) {
                temperatureString = '점심';
              } else if(categoryState.elementAt(i) == 4) {
                temperatureString = '저녁';
              } else if(categoryState.elementAt(i) == 5) {
                temperatureString = '액티비티';
              } else if(categoryState.elementAt(i) == 6) {
                temperatureString = '술집';
              }

              if(i == categoryState.length - 1) {
                recommendCategoryString = recommendCategoryString + temperatureString;
              } else {
                recommendCategoryString = '$recommendCategoryString$temperatureString, ';
              }
            }
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Text(recommendCategoryTitle, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
                SizedBox(width: 8.0.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 7.0.h),
                  decoration: BoxDecoration(
                    color: StaticColor.grey100F6,
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Center(child: Text(recommendCategoryString, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w500))),
                )
              ],
            ),
          );
        }
    );
  }
}

class EventInfoPlanRecommendCost extends StatefulWidget {
  const EventInfoPlanRecommendCost({super.key});

  @override
  State<EventInfoPlanRecommendCost> createState() => _EventInfoPlanRecommendCostState();
}

class _EventInfoPlanRecommendCostState extends State<EventInfoPlanRecommendCost> {
  String recommendCostTitle = '예산';
  String recommendCostString = '-';

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateEventProvider>(
        builder: (context, data, child) {

          recommendCostString = '${(data.totalCost / 10000).toInt()}만원';

          /// 금액 일금으로 표시
          // var f = NumberFormat('###,###,###,###');
          // recommendCostString = f.format(data.totalCost);

          return Row(
            children: [
              Text(recommendCostTitle, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
              SizedBox(width: 8.0.w),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 7.0.h),
                  decoration: BoxDecoration(
                    color: StaticColor.grey100F6,
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Center(child: Text(recommendCostString, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w500))),
                ),
              )
            ],
          );
        }
    );
  }
}
