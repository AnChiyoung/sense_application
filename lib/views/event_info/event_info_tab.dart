import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/event_info/plan_view/event_info_plan_view.dart';
import 'package:sense_flutter_application/views/new_create_event_view/new_create_event_provider.dart';

class EventInfoTab extends StatefulWidget {
  const EventInfoTab({super.key});

  @override
  State<EventInfoTab> createState() => _EventInfoTabState();
}

class _EventInfoTabState extends State<EventInfoTab> with TickerProviderStateMixin {

  late TabController eventInfoTabController;

  @override
  void initState() {
    eventInfoTabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CEProvider>(
        builder: (context, data, child) {

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.0.w, vertical: 4.0.h),
                    decoration: BoxDecoration(
                      color: StaticColor.grey100F6,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                              flex: 1,
                              child: planTab(data.eventInfoTabState)),
                          Expanded(
                              flex: 1,
                              child: recommendTab(data.eventInfoTabState)),
                        ]
                    )
                ),
                SizedBox(height: 16.0.h),
                // 하단 탭 상세 내용
                Consumer<CEProvider>(
                    builder: (context, data, child) {
                      if(data.eventInfoTabState == 0) {
                        return Expanded(child: PlanView());
                      } else {
                        return Expanded(child: Container());
                        // return RecommendView();
                      }
                    }
                )
              ],
            ),
          );
        }
    );
  }

  Widget planTab(int state) {
    return GestureDetector(
      onTap: () {
        context.read<CEProvider>().eventInfoTabChange(0);
      },
      child: Container(
        height: 40.0.h,
        decoration: BoxDecoration(
          color: state == 0 ? StaticColor.mainSoft : StaticColor.grey100F6,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Center(child: Text('계획', style: TextStyle(fontSize: 14.sp, color: state == 0 ? Colors.white : StaticColor.grey60077, fontWeight: state == 0 ? FontWeight.w700 : FontWeight.w500))),
      ),
    );
  }

  Widget recommendTab(int state) {
    return GestureDetector(
      onTap: () {
        context.read<CEProvider>().eventInfoTabChange(1);
      },
      child: Container(
        height: 40.0.h,
        decoration: BoxDecoration(
          color: state == 1 ? StaticColor.mainSoft : StaticColor.grey100F6,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Center(child: Text('추천', style: TextStyle(fontSize: 14.sp, color: state == 1 ? Colors.white : StaticColor.grey60077, fontWeight: state == 1 ? FontWeight.w700 : FontWeight.w500))),
      ),
    );
  }
}
