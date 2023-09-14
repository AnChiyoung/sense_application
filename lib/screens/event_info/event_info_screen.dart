import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/views/create_event/create_event_improve_provider.dart';
import 'package:sense_flutter_application/views/event_info/event_info_header.dart';
import 'package:sense_flutter_application/views/recommended_event/event_info_view.dart';
import 'package:sense_flutter_application/views/event_info/improve/event_info_load_view.dart';

class EventInfoScreen extends StatefulWidget {
  const EventInfoScreen({super.key});

  @override
  State<EventInfoScreen> createState() => _EventInfoScreenState();
}

class _EventInfoScreenState extends State<EventInfoScreen> {

  final GlobalKey<ScaffoldState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {

    /// safe area height
    final safeAreaTopPadding = MediaQuery.of(context).padding.top;
    final safeAreaBottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      key: key,
      endDrawer: EventInfoDrawer(),
      body: SafeArea(
        top: true,
        bottom: false,
        child: Stack(
          children: [
            // EventGuideView(),
            Column(
              children: [
                EventInfoLoadView(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EventGuideView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withOpacity(0.5),
    );
  }
}
