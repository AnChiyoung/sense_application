import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/event_detail/event_detail_provider.dart';

class EventPlanEmptyRecommend extends StatefulWidget {
  const EventPlanEmptyRecommend({super.key});

  @override
  State<EventPlanEmptyRecommend> createState() => _EventPlanEmptyRecommendState();
}

class _EventPlanEmptyRecommendState extends State<EventPlanEmptyRecommend> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EDProvider>(
      builder: (context, data, child) {

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 32.0.h,),
            Text('선택', style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700, height: 1.4)),
            SizedBox(height: 8.0.h,),
            Container(
              height: 132.0.h,
              decoration: BoxDecoration(
                color: StaticColor.grey100F6,
                borderRadius: BorderRadius.circular(8.0.r)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('아직 선택한 이벤트가 없어요', style: TextStyle(fontSize: 14.sp, color: StaticColor.grey400BB, fontWeight: FontWeight.w400, height: 1.4)),
                  SizedBox(height: 16.0.h,),
                  ElevatedButton(
                    onPressed: () {
                      data.setEventDetailTabState(EnumEventDetailTab.recommend, true);
                    }, 
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 6.0.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0.r))
                    ),
                    child: Text('추천보기', style: TextStyle(fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.w400, height: 1.4)),
                  ),
                ]
              ),
            )
          ],
        );
      },
    );
  }
}