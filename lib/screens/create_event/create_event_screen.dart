import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/create_event_view/create_event_button.dart';
import 'package:sense_flutter_application/views/create_event_view/create_event_data_section.dart';
import 'package:sense_flutter_application/views/create_event_view/create_event_header.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  @override
  Widget build(BuildContext context) {

    /// safe area heightß
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
                      CreateEventHeader(),
                      Container(
                        height: 1.0,
                        color: StaticColor.grey300E0,
                      ),
                      CreateEventDataSection(),
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
