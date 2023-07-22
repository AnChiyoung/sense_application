import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/create_event/create_event_view.dart';
import 'package:sense_flutter_application/views/create_event/create_event_provider.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({Key? key}) : super(key: key);

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  @override
  Widget build(BuildContext context) {

    /// safe area height
    final safeAreaTopPadding = MediaQuery.of(context).padding.top;
    final safeAreaBottomPadding = MediaQuery.of(context).padding.bottom;
    context.read<CreateEventProvider>().safeAreaPaddingChange(safeAreaTopPadding, safeAreaBottomPadding);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  CreateEventHeader(),
                  Container(
                    height: 1.0,
                    color: StaticColor.grey300E0,
                  ),
                  CreateEventInfoView(),
                ],
              ),
            ),
            const Align(
                alignment: Alignment.bottomCenter,
                child: CreateEventButton()
            ),
          ],
        ),
      ),
    );
  }
}
