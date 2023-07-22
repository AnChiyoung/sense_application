import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';
import 'package:sense_flutter_application/screens/event_info/event_plan.dart';
import 'package:sense_flutter_application/screens/event_info/event_recommend.dart';
import 'package:sense_flutter_application/views/create_event/create_event_provider.dart';

class EventInfoHeader extends StatefulWidget {
  const EventInfoHeader({super.key});

  @override
  State<EventInfoHeader> createState() => _EventInfoHeaderState();
}

class _EventInfoHeaderState extends State<EventInfoHeader> {
  @override
  Widget build(BuildContext context) {
    return HeaderMenu(backCallback: backCallback, title: '이벤트');
  }

  void backCallback() {
    Navigator.of(context).pop();
  }
}

class EventInfo extends StatefulWidget {
  const EventInfo({super.key});

  @override
  State<EventInfo> createState() => _EventInfoState();
}

class _EventInfoState extends State<EventInfo> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        EventInfoTabBar(),
        Expanded(child: EventContent()),
      ],
    );
  }
}

class EventInfoTabBar extends StatefulWidget {
  const EventInfoTabBar({super.key});

  @override
  State<EventInfoTabBar> createState() => _EventInfoTabBarState();
}

class _EventInfoTabBarState extends State<EventInfoTabBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.0.w, vertical: 4.0.h),
        decoration: BoxDecoration(
          color: StaticColor.grey100F6,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Consumer<CreateEventProvider>(
          builder: (context, data, child) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: PlanTab(data.eventInfoTabState.elementAt(0))),
                Expanded(
                  flex: 1,
                  child: RecommendTab(data.eventInfoTabState.elementAt(1))),
              ]
            );
          }
        )
      ),
    );
  }

  Widget PlanTab(bool state) {
    return GestureDetector(
      onTap: () {
        context.read<CreateEventProvider>().eventInfoTabStateChange([true, false]);
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
        context.read<CreateEventProvider>().eventInfoTabStateChange([false, true]);
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

class EventContent extends StatefulWidget {
  const EventContent({super.key});

  @override
  State<EventContent> createState() => _EventContentState();
}

class _EventContentState extends State<EventContent> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CreateEventProvider>(
      builder: (context, data, child) {

        if(data.eventInfoTabState.indexOf(true) == 0) {
          return EventPlan();
        } else if(data.eventInfoTabState.indexOf(true) == 1) {
          return EventRecommend();
        } else {
          return Center(child: Text('error fetching..', style: TextStyle(color: Colors.black)));
        }
      }
    );
  }
}
