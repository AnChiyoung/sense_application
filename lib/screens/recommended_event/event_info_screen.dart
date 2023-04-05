import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/recommended_event/event_info_view.dart';

class EventInfoScreen extends StatefulWidget {
  const EventInfoScreen({Key? key}) : super(key: key);

  @override
  State<EventInfoScreen> createState() => _EventInfoScreenState();
}

class _EventInfoScreenState extends State<EventInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // 버튼 제외 상단
            Column(
              children: [
                EventInfoHeaderMenu(),
                EventInfoTitle(),
                EventInfoNameSection(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: StaticColor.eventInfoPersonSectionDividerColor,
                  )
                ),
                EventInfoPersonSection(),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: double.infinity,
                      height: 1,
                      color: StaticColor.eventInfoPersonSectionDividerColor,
                    )
                ),
                EventInfoEtcSection(),
                EventInfoRecommendedSection(),
                // EventInfoMyChoiceSection(),
              ],
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              // child: EventInfoRecommendedButton(),
            ),
          ],
        ),
      ),
    );
  }
}
