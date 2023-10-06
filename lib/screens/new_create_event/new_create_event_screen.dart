import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/new_create_event_view/create_event_button.dart';
import 'package:sense_flutter_application/views/new_create_event_view/create_event_header.dart';
import 'package:sense_flutter_application/views/new_create_event_view/create_event_view.dart';

class CreateEventScreen02 extends StatefulWidget {
  const CreateEventScreen02({super.key});

  @override
  State<CreateEventScreen02> createState() => _CreateEventScreen02State();
}

class _CreateEventScreen02State extends State<CreateEventScreen02> {
  @override
  Widget build(BuildContext context) {

    /// safe area height
    final safeAreaTopPadding = MediaQuery.of(context).padding.top;
    final safeAreaBottomPadding = MediaQuery.of(context).padding.bottom;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          top: true,
          bottom: false,
          child: Stack(
            children: [
              ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const CreateEventHeader02(),
                      Container(
                        height: 1.0,
                        color: StaticColor.grey300E0,
                      ),
                      CreateEventInfoView02(),
                    ],
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: CreateEventButton()
              ),
            ],
          ),
        ),
      ),
    );
  }
}
