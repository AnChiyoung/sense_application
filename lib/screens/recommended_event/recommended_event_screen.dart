import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/recommended_event/recommended_event_view.dart';

class RecommendedEventScreen extends StatefulWidget {
  const RecommendedEventScreen({Key? key}) : super(key: key);

  @override
  State<RecommendedEventScreen> createState() => _RecommendedEventScreenState();
}

class _RecommendedEventScreenState extends State<RecommendedEventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // 버튼 제외 상단
            Column(
              children: const [
                RecommendedEventHeaderMenu(),
                RecommendedEventTitle(),
                RecommendedEventCategory(),
              ],
            ),
            const Align(
                alignment: Alignment.bottomCenter,
                child: RecommendedEventNextButton(),
            ),
          ],
        ),
      ),
    );
  }
}
