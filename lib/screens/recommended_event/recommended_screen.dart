import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/recommended_event/recommended_view.dart';

class RecommendedScreen extends StatefulWidget {
  const RecommendedScreen({Key? key}) : super(key: key);

  @override
  State<RecommendedScreen> createState() => _RecommendedScreenState();
}

class _RecommendedScreenState extends State<RecommendedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // 버튼 제외 상단
            Column(
              children: [
                RecommendedTitle(),
                // RecommendedTagSection(),
                // RecommendedItemSection(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
