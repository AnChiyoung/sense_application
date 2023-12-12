import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/event_detail/drawer/event_detail_drawer_delete_dialog.dart';

class EventDetailDrawerDelete extends StatefulWidget {
  const EventDetailDrawerDelete({super.key});

  @override
  State<EventDetailDrawerDelete> createState() => _EventDetailDrawerDeleteState();
}

class _EventDetailDrawerDeleteState extends State<EventDetailDrawerDelete> {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          height: 35,
          decoration: BoxDecoration(
            color: StaticColor.categoryUnselectedColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return const EventDetailDrawerDeleteDialog();
                }
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categoryUnselectedColor, elevation: 0.0),
            child: Text('이벤트 삭제하기', style: TextStyle(fontSize: 13, color: StaticColor.drawerEventDeleteTextColor, fontWeight: FontWeight.w400)),
          ),
        ),
      ),
    );
  }
}