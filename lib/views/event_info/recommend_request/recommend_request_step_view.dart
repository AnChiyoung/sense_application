import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/public_widget/event_info_recommend_request_dialog.dart';
import 'package:sense_flutter_application/views/event_info/event_recommend_step_category.dart';
import 'package:sense_flutter_application/views/event_info/event_recommend_step_cost.dart';
import 'package:sense_flutter_application/views/event_info/event_recommend_step_memo.dart';
import 'package:sense_flutter_application/views/event_info/recommend_request/recommend_request_provider.dart';

class RecommendRequestStep extends StatefulWidget {
  const RecommendRequestStep({super.key});

  @override
  State<RecommendRequestStep> createState() => _RecommendRequestStepState();
}

class _RecommendRequestStepState extends State<RecommendRequestStep> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RecommendRequestProvider>(
      builder: (context, data, child) {

        int recommendRequestStep = data.step;

        if(recommendRequestStep == 1) {
          return EventRecommendStepCategory();
        } else if(recommendRequestStep == 2) {
          return EventRecommendStepCost();
        } else if(recommendRequestStep == 3) {
          return EventRecommendStepMemo();
        } else {
          return const SizedBox.shrink();
        }
      }
    );
  }
}

class RecommendRequestStepButton extends StatefulWidget {
  const RecommendRequestStepButton({super.key});

  @override
  State<RecommendRequestStepButton> createState() => _RecommendRequestStepButtonState();
}

class _RecommendRequestStepButtonState extends State<RecommendRequestStepButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70.h,
      child: ElevatedButton(
        onPressed: () {
          int stepState = context.read<RecommendRequestProvider>().step;
          if(stepState == 1) {
            categoryStepCallback();
          } else if(stepState == 2) {
            costStepCallback();
          } else if(stepState == 3) {
            memoStepCallback();
          }
        },
        style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categorySelectedColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
        child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 56, child: Center(child: Text('저장', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700)))),
            ]
        ),
      ),
    );
  }

  void categoryStepCallback() {
    context.read<RecommendRequestProvider>().stepChange(2, true);
  }

  void costStepCallback() {
    context.read<RecommendRequestProvider>().stepChange(3, true);
  }

  void memoStepCallback() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const RecommendRequestDialog();
        }
    );
  }
}