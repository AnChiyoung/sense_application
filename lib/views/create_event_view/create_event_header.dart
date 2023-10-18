import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';
import 'package:sense_flutter_application/views/create_event_view/create_event_provider.dart';

class CreateEventHeader extends StatefulWidget {
  const CreateEventHeader({super.key});

  @override
  State<CreateEventHeader> createState() => _CreateEventHeaderState();
}

class _CreateEventHeaderState extends State<CreateEventHeader> {

  TextStyle titleStyle = TextStyle(fontSize: 16.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return HeaderMenu(backCallback: backCallback, title: '이벤트 생성', titleStyle: titleStyle);
  }

  void backCallback() {
    context.read<CEProvider>().createEventClear();
    // String title = context.read<CreateEventImproveProvider>().title;
    // int category = context.read<CreateEventImproveProvider>().category;
    // int target = context.read<CreateEventImproveProvider>().target;
    // String date = context.read<CreateEventImproveProvider>().date;
    // int city = context.read<CreateEventProvider>().city;
    // String memo = context.read<CreateEventImproveProvider>().memo;
    //
    // if(title.isEmpty && category == -1 && target == -1 && date.isEmpty && city == -1 && memo.isEmpty) {
    //   context.read<CreateEventImproveProvider>().createEventClear(null);
    //   context.read<CreateEventProvider>().regionInitialize();
    //   context.read<CreateEventProvider>().recommendInitialize();
    //   /// page route reset
    //   Navigator.of(context).pop();
    // } else {
    //   showDialog(
    //       context: context,
    //       barrierDismissible: false,
    //       builder: (BuildContext context) {
    //         return const AddEventCancelDialog();
    //       }
    //   );
    // }
    Navigator.pop(context);
  }
}
