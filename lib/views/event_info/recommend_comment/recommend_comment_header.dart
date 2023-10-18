// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:sense_flutter_application/constants/public_color.dart';
// import 'package:sense_flutter_application/models/event_feed/event_feed_recommend_model.dart';
// import 'package:sense_flutter_application/public_widget/header_menu.dart';
// import 'package:sense_flutter_application/views/create_event/create_event_improve_provider.dart';
//
// class RecommendAddHeader extends StatefulWidget {
//   const RecommendAddHeader({super.key});
//
//   @override
//   State<RecommendAddHeader> createState() => _RecommendAddHeaderState();
// }
//
// class _RecommendAddHeaderState extends State<RecommendAddHeader> {
//
//   @override
//   Widget build(BuildContext context) {
//     return HeaderMenu(backCallback: backCallback, isBackClose: true, title: '추천', rightMenu: rightMenu());
//   }
//
//   void backCallback() {
//     Navigator.pop(context);
//   }
//
//   Widget rightMenu() {
//     return Consumer<CreateEventImproveProvider>(
//       builder: (context, data, child) {
//
//         String comment = data.recommendCommentString;
//
//         return Material(
//           color: Colors.transparent,
//           child: SizedBox(
//             width: 40.w,
//             height: 40.h,
//             child: InkWell(
//                 borderRadius: BorderRadius.circular(25.0),
//                 onTap: () async {
//                   if(comment.isEmpty) {
//                   } else {
//                     bool result = await RecommendsRequest().eventFeedRecommendComment(
//                         context.read<CreateEventImproveProvider>().eventUniqueId,
//                         context);
//                     if(result == true) {
//                       // context.read<CreateEventImproveProvider>().useRebuildChange();
//                       Navigator.pop(context);
//                     } else {}
//                   }
//                 },
//                 child: Center(
//                     child: Text('완료', style: TextStyle(fontSize: 16.0.sp, color: comment.isEmpty ? StaticColor.grey300E0 : StaticColor.mainSoft, fontWeight: FontWeight.w700))
//                 )
//             ),
//           ),
//         );
//       }
//     );
//   }
// }
