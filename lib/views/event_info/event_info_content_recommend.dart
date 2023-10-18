// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:sense_flutter_application/constants/logger.dart';
// import 'package:sense_flutter_application/constants/public_color.dart';
// import 'package:sense_flutter_application/models/event/event_model.dart';
// import 'package:sense_flutter_application/screens/event_info/recommend_request/recommend_request_screen.dart';
// import 'package:sense_flutter_application/views/create_event/create_event_improve_provider.dart';
// import 'package:sense_flutter_application/views/create_event/create_event_provider.dart';
// import 'package:sense_flutter_application/views/event_info/event_info_content_recommend_finish.dart';
// import 'package:sense_flutter_application/views/event_info/event_recommend_step_category.dart';
// import 'package:sense_flutter_application/views/event_info/event_recommend_step_cost.dart';
// import 'package:sense_flutter_application/views/event_info/event_recommend_step_memo.dart';
//
// class EventRecommend extends StatefulWidget {
//   int visitCount;
//   int recommendCount;
//   EventRecommend({super.key, required this.visitCount, required this.recommendCount});
//
//   @override
//   State<EventRecommend> createState() => _EventRecommendState();
// }
//
// class _EventRecommendState extends State<EventRecommend> {
//   @override
//   Widget build(BuildContext context) {
//
//     return FutureBuilder(
//       future: EventRequest().eventRequest(context.read<CreateEventImproveProvider>().eventUniqueId),
//       builder: (context, snapshot) {
//         if(snapshot.hasError) {
//           SenseLogger().error('snapshot error');
//           return const SizedBox.shrink();
//         } else if(snapshot.hasData) {
//           if(snapshot.connectionState == ConnectionState.waiting) {
//             return const SizedBox.shrink();
//           } else if(snapshot.connectionState == ConnectionState.done) {
//
//             EventModel eventModel = snapshot.data ?? EventModel();
//             RecommendRequestModel model = eventModel.recommendModel ?? RecommendRequestModel.initModel;
//
//             if(model == RecommendRequestModel.initModel) {
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Container(
//                     padding: EdgeInsets.only(top: 100.0.h),
//                     child: Align(
//                       alignment: Alignment.topCenter,
//                       child: RichText(
//                         textAlign: TextAlign.center,
//                         text: TextSpan(
//                           style: TextStyle(fontSize: 16.sp, color: StaticColor.grey50099, fontWeight: FontWeight.w400),
//                           children: [
//                             const TextSpan(text: '아직 추천된 아이템이 없어요\n'),
//                             TextSpan(text: '\'요청하기\'', style: TextStyle(fontSize: 16.0.sp, color: StaticColor.grey50099, fontWeight: FontWeight.w700),),
//                             const TextSpan(text: '를 눌러 나를 위한 추천을 받아보세요')
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20.0.h),
//                   ElevatedButton(
//                       onPressed: () {
//                         // context.read<CreateEventProvider>().isSteppingStateChange(true);
//                         Navigator.push(context, MaterialPageRoute(builder: (_) => RecommendRequestScreen())).then((value) {
//                           setState(() {});
//                         });
//                       },
//                       style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categorySelectedColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
//                       child: Container(
//                         width: 180.0.w,
//                         padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 12.0.h),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(16.0),
//                           ),
//                         child: Center(child: Text('요청하기', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700))))
//                     ),
//                 ],
//               );
//             } else {
//               return EventRecommendFinish(eventModel: eventModel, visitCount: widget.visitCount, recommendCount: widget.recommendCount);
//             }
//
//           } else {
//             return const SizedBox.shrink();
//           }
//         } else {
//           return const SizedBox.shrink();
//         }
//       }
//     );
//
//
//   }
// }
//
// class EventRecommendStepView extends StatefulWidget {
//   const EventRecommendStepView({super.key});
//
//   @override
//   State<EventRecommendStepView> createState() => _EventRecommendStepViewState();
// }
//
// class _EventRecommendStepViewState extends State<EventRecommendStepView> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CreateEventProvider>(
//       builder: (context, data, child) {
//         if(data.eventRecommendStep == 1) {
//           return EventRecommendStepCategory();
//         } else if(data.eventRecommendStep == 2) {
//           return EventRecommendStepCost();
//         } else if(data.eventRecommendStep == 3) {
//           return EventRecommendStepMemo();
//         } else {
//           return Center(child: Text('Step error..', style: TextStyle(color: Colors.black)));
//         }
//       }
//     );
//   }
// }