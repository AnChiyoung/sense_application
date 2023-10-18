// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:sense_flutter_application/constants/public_color.dart';
// import 'package:sense_flutter_application/views/create_event/create_event_provider.dart';
// import 'package:sense_flutter_application/views/event_info/event_info_provider.dart';
// import 'package:sense_flutter_application/views/event_info/recommend_request/recommend_request_provider.dart';
// import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';
//
// class EventRecommendStepCategory extends StatefulWidget {
//   const EventRecommendStepCategory({super.key});
//
//   @override
//   State<EventRecommendStepCategory> createState() => _EventRecommendStepCategoryState();
// }
//
// class _EventRecommendStepCategoryState extends State<EventRecommendStepCategory> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<RecommendRequestProvider>(
//       builder: (context, data, child) {
//         return Stack(
//           children: [
//             Padding(
//               padding: EdgeInsets.only(top: 32.0.h, left: 20.0.w, right: 20.0.w),
//               child: Column(
//                 children: [
//                   ContentDescription(presentPage: 1, totalPage: 3, description: '무엇이 필요하신가요?'),
//                   SizedBox(height: 28.0.h),
//                   Row(
//                     children: [
//                       Flexible(
//                         fit: FlexFit.tight,
//                         flex: 1,
//                         child: CreateRecommendSelectTab(
//                           checkState: data.recommendCategory.elementAt(0),
//                           iconPath: 'assets/recommended_event/present.png',
//                           title: '선물',
//                           index: 0,
//                         ),
//                       ),
//                       SizedBox(width: 12.0.w),
//                       Flexible(
//                         fit: FlexFit.tight,
//                         flex: 1,
//                         child: CreateRecommendSelectTab(
//                           checkState: data.recommendCategory.elementAt(1),
//                           iconPath: 'assets/recommended_event/hotel.png',
//                           title: '호텔',
//                           index: 1,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 12.0.h),
//                   Row(
//                     children: [
//                       Flexible(
//                         fit: FlexFit.tight,
//                         flex: 1,
//                         child: CreateRecommendSelectTab(
//                           checkState: data.recommendCategory.elementAt(2),
//                           iconPath: 'assets/recommended_event/lunch.png',
//                           title: '점심',
//                           index: 2,
//                         ),
//                       ),
//                       SizedBox(width: 12.0.w),
//                       Flexible(
//                         fit: FlexFit.tight,
//                         flex: 1,
//                         child: CreateRecommendSelectTab(
//                           checkState: data.recommendCategory.elementAt(3),
//                           iconPath: 'assets/recommended_event/dinner.png',
//                           title: '저녁',
//                           index: 3,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 12.0.h),
//                   Row(
//                     children: [
//                       Flexible(
//                         fit: FlexFit.tight,
//                         flex: 1,
//                         child: CreateRecommendSelectTab(
//                           checkState: data.recommendCategory.elementAt(4),
//                           iconPath: 'assets/recommended_event/activity.png',
//                           title: '액티비티',
//                           index: 4,
//                         ),
//                       ),
//                       SizedBox(width: 12.0.w),
//                       Flexible(
//                         fit: FlexFit.tight,
//                         flex: 1,
//                         child: CreateRecommendSelectTab(
//                           checkState: data.recommendCategory.elementAt(5),
//                           iconPath: 'assets/recommended_event/pub.png',
//                           title: '술집',
//                           index: 5,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         );
//       }
//     );
//   }
//
//   void onPressedCallback(bool state, int index) {
//     context.read<CreateEventProvider>().recommendCategoryValueChange(state, index);
//   }
// }
//
// class CreateRecommendSelectTab extends StatefulWidget {
//   bool checkState;
//   String iconPath;
//   String title;
//   int index;
//
//   CreateRecommendSelectTab({super.key, required this.checkState, required this.iconPath, required this.title, required this.index});
//
//   @override
//   State<CreateRecommendSelectTab> createState() => _CreateRecommendSelectTab();
// }
//
// class _CreateRecommendSelectTab extends State<CreateRecommendSelectTab> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 96.h,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: ElevatedButton(
//         onPressed: () {
//           /// 선택된 아이템이 하나일 때는, 선택 해제할 수 없음.
//           int trueCount = context.read<RecommendRequestProvider>().recommendCategory.where((e) => true == e).length;
//
//           if(trueCount == 1) {
//             if(widget.checkState == true) {
//              return ;
//             } else if(widget.checkState == false) {
//               context.read<RecommendRequestProvider>().recommendCategoryValueChange(!widget.checkState, widget.index);
//             }
//           } else {
//             context.read<RecommendRequestProvider>().recommendCategoryValueChange(!widget.checkState, widget.index);
//           }
//         },
//         style: ElevatedButton.styleFrom(elevation: 0.0, backgroundColor: widget.checkState == true ? StaticColor.categorySelectedColor : StaticColor.categoryUnselectedColor),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             /// null 처리 필요없음. 지워야 함.
//             widget.iconPath == null ? const SizedBox.shrink() : Image.asset(widget.iconPath!, width: 32.w, height: 32.h, color: widget.checkState == true ? Colors.white : Colors.black),
//             widget.iconPath == null || widget.title == null ? const SizedBox.shrink() : SizedBox(height: 12.0.h),
//             widget.title == null ? const SizedBox.shrink() : Text(widget.title!, style: TextStyle(fontSize: 13.sp, color: widget.checkState == true ? Colors.white : StaticColor.addEventFontColor, fontWeight: FontWeight.w700)),
//           ],
//         ),
//       ),
//     );
//   }
// }
