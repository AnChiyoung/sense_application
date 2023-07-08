import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/add_event/create_event_view.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({Key? key}) : super(key: key);

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                CreateEventHeader(),
                Container(
                  height: 1.0,
                  color: StaticColor.grey300E0,
                ),
                CreateEventInfoView(),
              ],
            ),
            // const Align(
            //     alignment: Alignment.bottomCenter,
            //     child: CreateEventButton()
            // ),
          ],
        ),
      ),
    );
  }
}
