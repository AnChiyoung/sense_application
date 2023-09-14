import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';
import 'package:sense_flutter_application/screens/event_info/recommend_request/recommend_request_screen.dart';
import 'package:sense_flutter_application/views/create_event/create_event_improve_provider.dart';
import 'package:sense_flutter_application/views/create_event/create_event_provider.dart';
import 'package:sense_flutter_application/views/event_info/event_info_content_recommend_finish.dart';
import 'package:sense_flutter_application/views/event_info/event_recommend_step_category.dart';
import 'package:sense_flutter_application/views/event_info/event_recommend_step_cost.dart';
import 'package:sense_flutter_application/views/event_info/event_recommend_step_memo.dart';

class EventRecommend extends StatefulWidget {
  const EventRecommend({super.key});

  @override
  State<EventRecommend> createState() => _EventRecommendState();
}

class _EventRecommendState extends State<EventRecommend> {
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: EventRequest().eventRequest(context.read<CreateEventImproveProvider>().eventUniqueId),
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return const SizedBox.shrink();
        } else if(snapshot.hasData) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox.shrink();
          } else if(snapshot.connectionState == ConnectionState.done) {

            EventModel eventModel = snapshot.data ?? EventModel();
            RecommendRequestModel model = eventModel.recommendModel ?? RecommendRequestModel.initModel;

            if(model == RecommendRequestModel.initModel) {
              return Expanded(
                child: Container(
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(top: 100.0.h),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: TextStyle(fontSize: 16.sp, color: StaticColor.grey50099, fontWeight: FontWeight.w400),
                                children: [
                                  const TextSpan(text: '아직 추천된 아이템이 없어요\n'),
                                  TextSpan(text: '\'요청하기\'', style: TextStyle(fontSize: 16.0.sp, color: StaticColor.grey50099, fontWeight: FontWeight.w700),),
                                  const TextSpan(text: '를 눌러 나를 위한 추천을 받아보세요')
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: double.infinity,
                          height: 70.h,
                          child: ElevatedButton(
                            onPressed: () {
                              // context.read<CreateEventProvider>().isSteppingStateChange(true);
                              Navigator.push(context, MaterialPageRoute(builder: (_) => RecommendRequestScreen()));
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categorySelectedColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
                            child: const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: 56, child: Center(child: Text('요청하기', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700)))),
                                ]
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
              // return Column(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Expanded(
              //       child: Container(
              //         color: Colors.red,
              //         child: Center(
              //           child: RichText(
              //             textAlign: TextAlign.center,
              //             text: TextSpan(
              //               style: TextStyle(fontSize: 16.sp, color: StaticColor.grey50099, fontWeight: FontWeight.w400),
              //               children: [
              //                 const TextSpan(text: '아직 추천된 아이템이 없어요\n'),
              //                 TextSpan(text: '\'요청하기\'', style: TextStyle(fontSize: 16.sp, color: StaticColor.grey50099, fontWeight: FontWeight.w700),),
              //                 const TextSpan(text: '를 눌러 나를 위한 추천을 받아보세요')
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //     Align(
              //       alignment: Alignment.bottomCenter,
              //       child: SizedBox(
              //         width: double.infinity,
              //         height: 70.h,
              //         child: ElevatedButton(
              //           onPressed: () {
              //             context.read<CreateEventProvider>().isSteppingStateChange(true);
              //           },
              //           style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categorySelectedColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
              //           child: const Column(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               children: [
              //                 SizedBox(height: 56, child: Center(child: Text('요청하기', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700)))),
              //               ]
              //           ),
              //         ),
              //       ),
              //     ),
              //   ]
              // );
            } else {
              return Container(width: 30, height: 30, color: Colors.black);
            }

          } else {
            return const SizedBox.shrink();
          }
        } else {
          return const SizedBox.shrink();
        }
      }
    );

    /// 처음일 땐, 추천 정보 입력(종류, 예산, 요청사항)
    return Consumer<CreateEventProvider>(
      builder: (context, data, child) {

        bool isRecommendFinish = data.recommendRequestState;

        /// 요청 완료?
        if(isRecommendFinish == true) {
          return EventRecommendFinish();

        } else { /// 요청 미완료

          /// 요청 중?
          if(data.isStepping == true) {
            return EventRecommendStepView();

          } else {
            return Container(
              color: Colors.black);
            // return Stack(
            //   alignment: Alignment.bottomCenter,
            //   children: [
            //     Expanded(
            //       child: SizedBox(
            //         width: double.infinity,
            //         child: Center(
            //           child: RichText(
            //             textAlign: TextAlign.center,
            //             text: TextSpan(
            //               style: TextStyle(fontSize: 16.sp, color: StaticColor.grey50099, fontWeight: FontWeight.w400),
            //               children: [
            //                 const TextSpan(text: '아직 추천된 아이템이 없어요\n'),
            //                 TextSpan(text: '\'요청하기\'', style: TextStyle(fontSize: 16.sp, color: StaticColor.grey50099, fontWeight: FontWeight.w700),),
            //                 const TextSpan(text: '를 눌러 나를 위한 추천을 받아보세요')
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //     Align(
            //       alignment: Alignment.bottomCenter,
            //       child: SizedBox(
            //         width: double.infinity,
            //         height: 70.h,
            //         child: ElevatedButton(
            //           onPressed: () {
            //             context.read<CreateEventProvider>().isSteppingStateChange(true);
            //           },
            //           style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categorySelectedColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
            //           child: const Column(
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               children: [
            //                 SizedBox(height: 56, child: Center(child: Text('요청하기', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700)))),
            //               ]
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // );
          }
        }


        // if(data.isRecommend == true) {
        //
        //   if(data.recommendRequestState == true) {
        //     return EventRecommendFinish();
        //   } else {
        //     return EventRecommendStepView();
        //   }
        // } else {
        //   return Stack(
        //     children: [
        //       SizedBox(
        //         width: double.infinity,
        //         height: 300.h,
        //         child: Center(
        //           child: RichText(
        //             textAlign: TextAlign.center,
        //             text: TextSpan(
        //               style: TextStyle(fontSize: 16.sp, color: StaticColor.grey50099, fontWeight: FontWeight.w400),
        //               children: [
        //                 const TextSpan(text: '아직 추천된 아이템이 없어요\n'),
        //                 TextSpan(text: '\'요청하기\'', style: TextStyle(fontSize: 16.sp, color: StaticColor.grey50099, fontWeight: FontWeight.w700),),
        //                 const TextSpan(text: '를 눌러 나를 위한 추천을 받아보세요')
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //       Align(
        //         alignment: Alignment.bottomCenter,
        //         child: SizedBox(
        //           width: double.infinity,
        //           height: 70.h,
        //           child: ElevatedButton(
        //             onPressed: () {
        //               context.read<EventInfoProvider>().isSteppingStateChange(true);
        //             },
        //             style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categorySelectedColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
        //             child: const Column(
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 children: [
        //                   SizedBox(height: 56, child: Center(child: Text('요청하기', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700)))),
        //                 ]
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   );
        // }
      }
    );
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
    return Consumer<CreateEventProvider>(
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