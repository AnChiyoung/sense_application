import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';
import 'package:sense_flutter_application/models/event_feed/event_feed_model.dart';
import 'package:sense_flutter_application/views/event_feed/event_feed_list.dart';
import 'package:sense_flutter_application/views/event_feed/event_feed_provider.dart';

class EventFeedRecommend extends StatefulWidget {
  const EventFeedRecommend({super.key});

  @override
  State<EventFeedRecommend> createState() => _EventFeedRecommendState();
}

class _EventFeedRecommendState extends State<EventFeedRecommend> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EventFeedProvider>(
      builder: (context, data, child) {

        String filter = data.recommendButton;

        return FutureBuilder(
            future: EventFeedRequest().recommendEventListRequest(filter),
            builder: (context, snapshot) {

              if(snapshot.hasError) {
                return const SizedBox.shrink();
              } else if(snapshot.hasData) {

                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox.shrink();
                } else if(snapshot.connectionState == ConnectionState.done) {

                  List<EventModel> modelList = snapshot.data ?? [];
                  if(modelList.isEmpty) {
                    return Center(child: Text('추천을 요청한 이벤트가 없습니다.', style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400)));
                  } else {
                    return EventFeedList(eventModelList: modelList, type: 1);
                  }

                } else {
                  return const SizedBox.shrink();
                }

              } else {
                return const SizedBox.shrink();
              }
            }
        );
      }
    );
  }
}
