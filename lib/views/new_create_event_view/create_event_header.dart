import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';
import 'package:sense_flutter_application/views/new_create_event_view/new_create_event_provider.dart';

class CreateEventHeader02 extends StatefulWidget {
  const CreateEventHeader02({super.key});

  @override
  State<CreateEventHeader02> createState() => _CreateEventHeader02State();
}

class _CreateEventHeader02State extends State<CreateEventHeader02> {

  TextStyle titleStyle = TextStyle(fontSize: 16.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return HeaderMenu(backCallback: backCallback, title: '이벤트 생성', titleStyle: titleStyle);
  }

  void backCallback() {
    context.read<CEProvider>().createEventClear();
    Navigator.pop(context);
  }
}
