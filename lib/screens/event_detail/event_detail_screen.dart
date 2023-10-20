import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/event_detail/drawer/event_detail_drawer.dart';
import 'package:sense_flutter_application/views/event_detail/event_detail_view.dart';

class EventDetailScreen extends StatefulWidget {
  int eventId;
  EventDetailScreen({super.key, required this.eventId});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> with SingleTickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        endDrawer: const EventDetailDrawer(),
        body: SafeArea(
          child: EventDetailView(eventId: widget.eventId)
        ),
      ),
    );
  }
}
