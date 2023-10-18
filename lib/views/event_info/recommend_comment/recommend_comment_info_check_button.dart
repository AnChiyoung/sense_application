// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:sense_flutter_application/constants/public_color.dart';
// import 'package:sense_flutter_application/models/event/event_model.dart';
// import 'package:sense_flutter_application/screens/event_info/recommend_comment/recommend_comment_info_screen.dart';
// import 'package:sense_flutter_application/views/create_event/create_event_improve_provider.dart';
//
// class RecommendAddInfoCheckSection extends StatefulWidget {
//   RecommendRequestModel model;
//   RecommendAddInfoCheckSection({super.key, required this.model});
//
//   @override
//   State<RecommendAddInfoCheckSection> createState() => _RecommendAddInfoCheckSectionState();
// }
//
// class _RecommendAddInfoCheckSectionState extends State<RecommendAddInfoCheckSection> {
//
//   String titleName = '';
//
//   @override
//   void initState() {
//     titleName = context.read<CreateEventImproveProvider>().title;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 16.0.h),
//       child: Container(
//         width: double.infinity,
//         height: 50.0.h,
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.push(context, MaterialPageRoute(builder: (_) => RecommendCommentInfoScreen(model: widget.model)));
//           },
//           style: ElevatedButton.styleFrom(backgroundColor: StaticColor.mainSoft, elevation: 3.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(titleName, style: TextStyle(fontSize: 14.0.sp, color: Colors.white, fontWeight: FontWeight.w400)),
//               Icon(Icons.chevron_right),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
