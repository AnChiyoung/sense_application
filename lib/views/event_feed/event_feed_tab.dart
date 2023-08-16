import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';

class EventFeedTab extends StatefulWidget {
  TabController tabController;
  EventFeedTab({super.key, required this.tabController});

  @override
  State<EventFeedTab> createState() => _EventFeedTabState();
}

class _EventFeedTabState extends State<EventFeedTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
              controller: widget.tabController,
              labelColor: StaticColor.mainSoft,
              labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
              unselectedLabelColor: StaticColor.grey70055,
              indicatorWeight: 3,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: StaticColor.mainSoft, width: 3.0),
              ),
              unselectedLabelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              tabs: [
                SizedBox(
                  height: 37.0.h,
                  child: const Tab(
                      text: '전체'
                  ),
                ),
                SizedBox(
                  height: 37.0.h,
                  child: const Tab(
                      text: '추천하기'
                  ),
                ),
                SizedBox(
                  height: 37.0.h,
                  child: const Tab(
                      text: '후기보기'
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
