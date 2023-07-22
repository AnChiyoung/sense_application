import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/screens/event_info/event_info_provider.dart';
import 'package:sense_flutter_application/screens/event_info/event_recommend_step_category.dart';
import 'package:sense_flutter_application/screens/event_info/event_recommend_step_cost.dart';
import 'package:sense_flutter_application/screens/event_info/event_recommend_step_memo.dart';

class EventRecommend extends StatefulWidget {
  const EventRecommend({super.key});

  @override
  State<EventRecommend> createState() => _EventRecommendState();
}

class _EventRecommendState extends State<EventRecommend> {
  @override
  Widget build(BuildContext context) {
    /// 처음일 땐, 추천 정보 입력(종류, 예산, 요청사항)
    return EventRecommendStepView();
  }
}

class EventRecommendStepView extends StatefulWidget {
  const EventRecommendStepView({super.key});

  @override
  State<EventRecommendStepView> createState() => _EventRecommendStepViewState();
}

class _EventRecommendStepViewState extends State<EventRecommendStepView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EventInfoProvider>(
      builder: (context, data, child) {
        if(data.eventRecommendStep == 1) {
          return EventRecommendStepCategory();
        } else if(data.eventRecommendStep == 2) {
          return EventRecommendStepCost();
        } else if(data.eventRecommendStep == 3) {
          return EventRecommendStepMemo();
        } else {
          return Center(child: Text('Step error..', style: TextStyle(color: Colors.black)));
        }
      }
    );
  }
}



