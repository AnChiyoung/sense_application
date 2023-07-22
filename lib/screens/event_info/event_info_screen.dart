import 'package:flutter/material.dart';
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

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Stack(
          children: [
            // EventGuideView(),
            Column(
              children: [
                EventInfoHeader(),
                Expanded(child: EventInfo()),
                // EventInfoRecommended(),
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
