import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sense_flutter_application/public_widget/behavior_collection.dart';

class EventList extends StatefulWidget {
  const EventList({Key? key}) : super(key: key);

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {

  final eventListController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: eventListController,
        /// listview bounce effect remove
        physics: const ClampingScrollPhysics(),
        itemCount: 30,
        itemBuilder: (context, index) {
         return Column(
           children: [
             Container(
                 width: double.infinity,
                 height: 60, color: Colors.green),
             Divider(height: 2, color: Colors.white),
           ],
         );
        }
      ),
    );
  }
}
