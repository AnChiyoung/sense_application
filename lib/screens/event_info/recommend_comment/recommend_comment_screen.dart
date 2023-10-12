import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';
import 'package:sense_flutter_application/views/event_info/recommend_comment/recommend_comment_header.dart';
import 'package:sense_flutter_application/views/event_info/recommend_comment/recommend_comment_info_check_button.dart';
import 'package:sense_flutter_application/views/event_info/recommend_comment/recommend_comment_text_input.dart';

class RecommendCommentScreen extends StatefulWidget {
  RecommendRequestModel model;
  RecommendCommentScreen({super.key, required this.model});

  @override
  State<RecommendCommentScreen> createState() => _RecommendCommentScreenState();
}

class _RecommendCommentScreenState extends State<RecommendCommentScreen> {
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
        child: Column(
          children: [
            RecommendAddHeader(),
            Container(
              width: double.infinity,
              height: 1.0.h,
              color: StaticColor.grey300E0,
            ),
            RecommendAddInfoCheckSection(model: widget.model),
            RecommendAddTextInputSection(),
          ],
        ),
      ),
    );
  }
}
