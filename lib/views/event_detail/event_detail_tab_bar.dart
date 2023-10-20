import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/event_detail/event_detail_provider.dart';

class EventDetailTabBar extends StatefulWidget {
  const EventDetailTabBar({super.key});

  @override
  State<EventDetailTabBar> createState() => _EventDetailTabBarState();
}

class _EventDetailTabBarState extends State<EventDetailTabBar> {

  final List<EnumEventDetailTab> tabList = [
    EnumEventDetailTab.plan,
    EnumEventDetailTab.recommend,
  ];

  Widget eventDetailTab(EnumEventDetailTab tabState) {
    bool isActive = context.read<EDProvider>().eventDetailTabState == tabState;

    return GestureDetector(
      onTap: () {
        context.read<EDProvider>().setEventDetailTabState(tabState, true);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 40.0.h,
        decoration: BoxDecoration(
          color: isActive ? StaticColor.mainSoft : StaticColor.grey100F6,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Center(child: Text(tabState.label, style: TextStyle(fontSize: 14.sp, color: isActive ? Colors.white : StaticColor.grey60077))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EDProvider>(
      builder: (context, data, child) {
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
                children: tabList.map((tabState) => Expanded(flex: 1, child: eventDetailTab(tabState))).toList()
              )
          ),
        );
      }
    );
  }
}