import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/create_event/create_event_bottom_sheet.dart';

class TriggerActions {
  void showCreateEventView(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      useSafeArea: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      // ),
      builder: (context) {
        return CreateEventBottomSheetView();
      }
    );
  }
}