import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';
import 'package:sense_flutter_application/models/event_feed/event_feed_model.dart';

class EventFeedReview extends StatefulWidget {
  const EventFeedReview({super.key});

  @override
  State<EventFeedReview> createState() => _EventFeedReviewState();
}

class _EventFeedReviewState extends State<EventFeedReview> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: EventFeedRequest().recommendEventListRequest('created'),
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
                return Center(child: Text('추천을 요청한 이벤트가 없습니다.', style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400)));
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
}
