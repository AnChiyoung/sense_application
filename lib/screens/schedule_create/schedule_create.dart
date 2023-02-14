import 'package:flutter/material.dart';

class ScheduleCreateScreen extends StatefulWidget {
  const ScheduleCreateScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleCreateScreen> createState() => _ScheduleCreateScreenState();
}

class _ScheduleCreateScreenState extends State<ScheduleCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('schedule add area'),
    );
  }
}
