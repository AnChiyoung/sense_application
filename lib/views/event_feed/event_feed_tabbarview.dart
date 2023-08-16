import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/event_feed/event_feed_recommend.dart';
import 'package:sense_flutter_application/views/event_feed/event_feed_review.dart';
import 'package:sense_flutter_application/views/event_feed/event_feed_total.dart';

class EventFeedTabBarView extends StatefulWidget {
  TabController tabController;
  EventFeedTabBarView({super.key, required this.tabController});

  @override
  State<EventFeedTabBarView> createState() => _EventFeedTabBarViewState();
}

class _EventFeedTabBarViewState extends State<EventFeedTabBarView> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: widget.tabController,
      children: [
        EventFeedTotal(),
        EventFeedRecommend(),
        EventFeedReview(),
      ],
    );
  }
}
