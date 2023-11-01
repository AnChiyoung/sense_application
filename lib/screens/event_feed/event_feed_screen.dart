import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/event_feed/event_feed_tab.dart';
import 'package:sense_flutter_application/views/event_feed/event_feed_tabbarview.dart';
import 'package:sense_flutter_application/views/event_feed/event_feed_total.dart';

class EventFeedScreen extends StatefulWidget {
  const EventFeedScreen({super.key});

  @override
  State<EventFeedScreen> createState() => _EventFeedScreenState();
}

class _EventFeedScreenState extends State<EventFeedScreen> with SingleTickerProviderStateMixin{

  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: const Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // EventFeedTab(tabController: tabController),
              // Expanded(
              //   child: EventFeedTabBarView(tabController: tabController,),
              // )
              Expanded(child: EventFeedTotal()),
            ]
          )
        ),
      ),
    );
  }
}
