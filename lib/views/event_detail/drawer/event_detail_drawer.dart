import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/event_detail/drawer/event_detail_drawer_delete.dart';
import 'package:sense_flutter_application/views/event_detail/drawer/event_detail_drawer_setting.dart';

class EventDetailDrawer extends StatefulWidget {
  const EventDetailDrawer({Key? key}) : super(key: key);

  @override
  State<EventDetailDrawer> createState() => _EventDetailDrawerState();
}

class _EventDetailDrawerState extends State<EventDetailDrawer> {

  @override
  Widget build(BuildContext context) {
    /// safe area 상단 height
    var safePaddingTop = MediaQuery.of(context).padding.top;
    var safePaddingBottom = MediaQuery.of(context).padding.bottom;

    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          SizedBox(height: safePaddingTop),
          const EventDetailDrawerSetting(),
          // Container(
          //   width: double.infinity, 
          //   height: 1, 
          //   color: StaticColor.drawerDividerColor,
          // ),
          const Expanded(
            // child: DrawerJoinUser()
            child: SizedBox.shrink(),
          ),
          Container(
            width: double.infinity, 
            height: 1, 
            color: StaticColor.drawerDividerColor,
          ),
          const EventDetailDrawerDelete(),
          SizedBox(height: safePaddingBottom),
        ]
      ),
    );
  }
}
