import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/create_event/create_event_provider.dart';
import 'package:sense_flutter_application/views/event_info/recommend_request/recommend_request_step_view.dart';
import 'package:sense_flutter_application/views/event_info/recommend_request/recommend_request_view.dart';

class RecommendRequestScreen extends StatefulWidget {
  const RecommendRequestScreen({super.key});

  @override
  State<RecommendRequestScreen> createState() => _RecommendRequestScreenState();
}

class _RecommendRequestScreenState extends State<RecommendRequestScreen> {
  @override
  Widget build(BuildContext context) {

    /// safe area height
    final safeAreaTopPadding = MediaQuery.of(context).padding.top;
    final safeAreaBottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                RecommendRequestHeader(),
                Container(
                  height: 1.0,
                  color: StaticColor.grey300E0,
                ),
                RecommendRequestStep(),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: RecommendRequestStepButton(),
            )
            // EventGuideView(),
          ],
        ),
      ),
    );
  }
}
