import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/add_event/date_select_view.dart';

class DateSelectScreen extends StatefulWidget {
  const DateSelectScreen({Key? key}) : super(key: key);

  @override
  State<DateSelectScreen> createState() => _DateSelectScreenState();
}

class _DateSelectScreenState extends State<DateSelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: const [
                DateSelectHeader(),
                DateSelectTitle(),
                DateViewSection(),
                DateSelectSection(),
              ]
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: DateSelectNextButton()
            ),
          ]
        ),
      ),
    );
  }
}
