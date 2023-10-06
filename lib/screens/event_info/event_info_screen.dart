import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/event_info/event_info_drawer.dart';
import 'package:sense_flutter_application/views/event_info/event_info_header.dart';
import 'package:sense_flutter_application/views/event_info/event_info_view.dart';

class EventInfoScreen extends StatefulWidget {
  const EventInfoScreen({super.key});

  @override
  State<EventInfoScreen> createState() => _EventInfoScreenState();
}

class _EventInfoScreenState extends State<EventInfoScreen> {
  @override
  Widget build(BuildContext context) {

    /// safe area height
    final safeAreaTopPadding = MediaQuery.of(context).padding.top;
    final safeAreaBottomPadding = MediaQuery.of(context).padding.bottom;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        endDrawer: EventInfoDrawer(),
        body: SafeArea(
          top: true,
          bottom: false,
          child: EventInfoView(),
        ),
      ),
    );
  }
}
