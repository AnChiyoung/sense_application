// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:sense_flutter_application/constants/public_color.dart';
// import 'package:sense_flutter_application/models/event/event_model.dart';
// import 'package:sense_flutter_application/public_widget/header_menu.dart';
// import 'package:sense_flutter_application/views/create_event/create_event_improve_provider.dart';
// import 'package:sense_flutter_application/views/create_event/create_event_provider.dart';
//
// class RecommendCommentInfoHeader extends StatefulWidget {
//   const RecommendCommentInfoHeader({super.key});
//
//   @override
//   State<RecommendCommentInfoHeader> createState() => _RecommendCommentInfoHeaderState();
// }
//
// class _RecommendCommentInfoHeaderState extends State<RecommendCommentInfoHeader> {
//   @override
//   Widget build(BuildContext context) {
//     return HeaderMenu(backCallback: backCallback, title: '계획');
//   }
//
//   void backCallback() {
//     Navigator.pop(context);
//   }
// }
//
// class RecommendCommentInfo extends StatefulWidget {
//   RecommendRequestModel model;
//   RecommendCommentInfo({super.key, required this.model});
//
//   @override
//   State<RecommendCommentInfo> createState() => _RecommendCommentInfoState();
// }
//
// class _RecommendCommentInfoState extends State<RecommendCommentInfo> {
//
//   String title = '-';
//   int category = -1;
//   String categoryString = '-';
//   int target = -1;
//   String targetString = '-';
//   String date = '-';
//   int region = -1;
//   String regionString = '-';
//   List<int> recommendCategory = [];
//   List<String> recommendCategoryStringList = [];
//   String recommendCategoryString = '';
//   String recommendMemo = '-';
//   String cost = '-';
//
//   @override
//   void initState() {
//     title = context.read<CreateEventImproveProvider>().title;
//     category = context.read<CreateEventImproveProvider>().category;
//     target = context.read<CreateEventImproveProvider>().target;
//     date = context.read<CreateEventImproveProvider>().date;
//     if(date.isEmpty) {
//       date = '-';
//     }
//     region = context.read<CreateEventProvider>().city;
//     if(widget.model.isPresent == true) {
//       recommendCategory.add(1);
//     }
//     if(widget.model.isHotel == true) {
//       recommendCategory.add(2);
//     }
//     if(widget.model.isLunch == true) {
//       recommendCategory.add(3);
//     }
//     if(widget.model.isDinner == true) {
//       recommendCategory.add(4);
//     }
//     if(widget.model.isActivity == true) {
//       recommendCategory.add(5);
//     }
//     if(widget.model.isPub == true) {
//       recommendCategory.add(6);
//     }
//     recommendMemo = context.read<CreateEventImproveProvider>().memo;
//     if(widget.model.totalBudget == -1) {
//       cost = '제한없음';
//     } else {
//       cost = widget.model.totalBudget.toString();
//     }
//
//     print(recommendCategory.toString());
//     if(category == 0) {
//       categoryString = '생일';
//     } else if(category == 1) {
//       categoryString = '데이트';
//     } else if(category == 2) {
//       categoryString = '여행';
//     } else if(category == 3) {
//       categoryString = '모임';
//     } else if(category == 4) {
//       categoryString = '비즈니스';
//     } else {
//       categoryString = '-';
//     }
//
//     if(target == 0) {
//       targetString = '가족';
//     } else if(target == 1) {
//       targetString = '연인';
//     } else if(target == 2) {
//       targetString = '친구';
//     } else if(target == 3) {
//       targetString = '직장';
//     } else {
//       targetString = '-';
//     }
//
//     List<String> cityNameList = ['서울', '경기도', '인천', '강원도', '경상도', '전라도', '충청도', '부산', '제주'];
//     if(region == -1) {
//       regionString = '-';
//     } else {
//       regionString = cityNameList.elementAt(region).toString();
//     }
//
//     for(int i = 0; i < recommendCategory.length; i++) {
//
//       if(recommendCategory.elementAt(i) == 1) {
//         recommendCategoryStringList.add('선물');
//       } else if(recommendCategory.elementAt(i) == 2) {
//         recommendCategoryStringList.add('호텔');
//       } else if(recommendCategory.elementAt(i) == 3) {
//         recommendCategoryStringList.add('점심');
//       } else if(recommendCategory.elementAt(i) == 4) {
//         recommendCategoryStringList.add('저녁');
//       } else if(recommendCategory.elementAt(i) == 5) {
//         recommendCategoryStringList.add('액티비티');
//       } else if(recommendCategory.elementAt(i) == 6) {
//         recommendCategoryStringList.add('술집');
//       }
//     }
//
//
//     for(int i = 0; i < recommendCategoryStringList.length; i++) {
//       if(i < recommendCategoryStringList.length - 1) {
//         recommendCategoryString = recommendCategoryString + recommendCategoryStringList.elementAt(i) + ', ';
//       } else {
//         recommendCategoryString = recommendCategoryString + recommendCategoryStringList.elementAt(i);
//       }
//     }
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 16.0.h),
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Wrap(
//               runSpacing: 10.0,
//               spacing: 4.0,
//               children: [
//                 dataLabel(categoryString),
//                 dataLabel(targetString),
//                 dataLabel(date),
//                 dataLabel(regionString),
//                 dataLabel(recommendCategoryString),
//                 dataLabel(cost),
//               ]
//             ),
//             SizedBox(height: 32.0.h),
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Text(title, style: TextStyle(fontSize: 16.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w700))),
//             SizedBox(height: 16.0.h),
//             Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(recommendMemo, style: TextStyle(fontSize: 14.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w500))),
//           ],
//         ),
//       )
//     );
//   }
//
//   Widget dataLabel(String data) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 7.0.h),
//           decoration: BoxDecoration(
//             color: StaticColor.grey100F6,
//             borderRadius: BorderRadius.circular(18.0),
//           ),
//           child: Center(
//             child: Text(data, style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey80033, fontWeight: FontWeight.w500)),
//           ),
//         ),
//       ],
//     );
//   }
// }
