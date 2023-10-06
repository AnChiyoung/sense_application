import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';
import 'package:sense_flutter_application/screens/calendar/calendar_screen.dart';
import 'package:sense_flutter_application/screens/home/home_screen.dart';
import 'package:sense_flutter_application/views/new_create_event_view/new_create_event_provider.dart';

class EventInfoHeader extends StatefulWidget {
  const EventInfoHeader({super.key});

  @override
  State<EventInfoHeader> createState() => _EventInfoHeaderState();
}

class _EventInfoHeaderState extends State<EventInfoHeader> {

  @override
  Widget build(BuildContext context) {
    return HeaderMenu(backCallback: backCallback, title: context.read<CEProvider>().title, rightMenu: rightMenu());
  }

  void backCallback() {
    context.read<CEProvider>().createEventClear();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomeScreen(initPage: 3)), (route) => false);
  }

  Widget rightMenu() {
    return Consumer<CEProvider>(
        builder: (context, data, child) {
          return GestureDetector(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
              child: Image.asset(
                  'assets/recommended_event/menu.png', width: 24, height: 24)
          );
        }
    );
  }
}
