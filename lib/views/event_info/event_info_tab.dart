import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/screens/event_info/event_info_provider.dart';
import 'package:sense_flutter_application/views/create_event/create_event_provider.dart';

class EventInfoTabBar extends StatefulWidget {
  const EventInfoTabBar({super.key});

  @override
  State<EventInfoTabBar> createState() => _EventInfoTabBarState();
}

class _EventInfoTabBarState extends State<EventInfoTabBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EventInfoProvider>(
        builder: (context, data, child) {

          /// is the request in progress? variable
          bool isStepping = data.isStepping;

          if(isStepping == true) {
            return const SizedBox.shrink();
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: Container(
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
                            child: PlanTab(data.eventInfoTabState.elementAt(0))),
                        Expanded(
                            flex: 1,
                            child: RecommendTab(data.eventInfoTabState.elementAt(1))),
                      ]
                  )
              ),
            );
          }
        }
    );
  }

  Widget PlanTab(bool state) {
    return GestureDetector(
      onTap: () {
        context.read<EventInfoProvider>().eventInfoTabStateChange([true, false]);
      },
      child: Container(
        height: 40.0.h,
        decoration: BoxDecoration(
          color: state == true ? StaticColor.mainSoft : StaticColor.grey100F6,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Center(child: Text('계획', style: TextStyle(fontSize: 14.sp, color: state == true ? Colors.white : StaticColor.grey60077))),
      ),
    );
  }

  Widget RecommendTab(bool state) {
    return GestureDetector(
      onTap: () {
        context.read<EventInfoProvider>().eventInfoTabStateChange([false, true]);
      },
      child: Container(
        height: 40.0.h,
        decoration: BoxDecoration(
          color: state == true ? StaticColor.mainSoft : StaticColor.grey100F6,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Center(child: Text('추천', style: TextStyle(fontSize: 14.sp, color: state == true ? Colors.white : StaticColor.grey60077))),
      ),
    );
  }
}