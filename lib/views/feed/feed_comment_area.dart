// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sense_flutter_application/constants/public_color.dart';
// import 'package:sense_flutter_application/models/feed/comment_model.dart';
// import 'package:sense_flutter_application/models/login/login_model.dart';
// import 'package:sense_flutter_application/public_widget/comment_delete_dialog.dart';
// import 'package:sense_flutter_application/public_widget/comment_like_button.dart';
// import 'package:sense_flutter_application/public_widget/comment_subcomment_button.dart';
// import 'package:sense_flutter_application/public_widget/empty_user_profile.dart';
// import 'package:sense_flutter_application/public_widget/get_widget_size.dart';
// import 'package:sense_flutter_application/views/feed/feed_comment_view.dart';
// import 'package:sense_flutter_application/views/feed/feed_provider.dart';
//
// class CommentArea extends StatefulWidget {
//   ScrollController? controller;
//   TextEditingController? editingController;
//   int? postId;
//   CommentArea({Key? key, this.controller, this.editingController, this.postId}) : super(key: key);
//
//   @override
//   State<CommentArea> createState() => _CommentAreaState();
// }
//
// class _CommentAreaState extends State<CommentArea> {
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     List<CommentResponseModel> commentModel = context.watch<FeedProvider>().commentModels;
//     int commentCount = commentModel.length;
//
//     if(commentModel!.isEmpty || commentModel! == null) {
//       return Container();
//     } else {
//       return Padding(
//         padding: const EdgeInsets.only(bottom: 85),
//         child: Column(
//           children: [
//             /// 헤더
//             SingleChildScrollView(
//               physics: const ClampingScrollPhysics(),
//               controller: widget.controller,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   bottomSheetHeader(context, commentCount),
//                 ],
//               ),
//             ),
//             /// comment
//             Consumer<FeedProvider>(
//               builder: (context, data, child) {
//                 if(data.inputMode == 0) {
//                   return Expanded(
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       physics: const ClampingScrollPhysics(),
//                       scrollDirection: Axis.vertical,
//                       itemCount: commentModel!.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         // print('${commentModel.elementAt(index).id}/${commentModel.elementAt(index).isLiked}');
//
//                         return Column(
//                           children: [
//                             GestureDetector(
//                                 onTap: () {
//                                   /// 답글로 전환
//                                   context.read<FeedProvider>().inputModeChange(1, commentModel.elementAt(index).id);
//                                 },
//                                 child: commentRow(context, commentModel!, index)),
//                             const Divider(height: 0.1, color: Colors.grey),
//                           ],
//                         );
//                       },
//                     ),
//                   );
//                 } else if(data.inputMode == 1) {
//                   return Container();
//                 } else {
//                   return Container();
//                 }
//               }
//             ),
//           ],
//         ),
//       );
//     }
//
//
//
//     // return FutureBuilder(
//     //     future: CommentRequest().commentRequest(widget.postId!, widget.sortState.toString()),
//     //     builder: (context, snapshot) {
//     //       if(snapshot.hasError) {
//     //         return Container();
//     //       } else if(snapshot.hasData) {
//     //
//     //         commentModels = snapshot.data![0];
//     //         int count = snapshot.data![1];
//     //
//     //         if(commentModels!.isEmpty) {
//     //           return Center(child: Container(color: Colors.white, child: const Text('댓글이 없습니다')));
//     //         } else {
//     //           return Padding(
//     //             padding: const EdgeInsets.only(bottom: 85),
//     //             child: Column(
//     //               children: [
//     //                 SingleChildScrollView(
//     //                   physics: const ClampingScrollPhysics(),
//     //                   controller: widget.controller,
//     //                   child: Column(
//     //                     mainAxisSize: MainAxisSize.min,
//     //                     children: [
//     //                       bottomSheetHeader(context, count),
//     //                     ],
//     //                   ),
//     //                 ),
//     //                 Expanded(
//     //                   child: ListView.builder(
//     //                     shrinkWrap: true,
//     //                     physics: const ClampingScrollPhysics(),
//     //                     scrollDirection: Axis.vertical,
//     //                     itemCount: commentModels!.length,
//     //                     itemBuilder: (BuildContext context, int index) {
//     //                       return Column(
//     //                         children: [
//     //                           GestureDetector(
//     //                               onTap: () {
//     //                                 // context.read<FeedProvider>().recommentModeChange(true, commentModels.elementAt(index));
//     //                               },
//     //                               child: commentRow(context, commentModels!, index)),
//     //                           const Divider(height: 0.1, color: Colors.grey),
//     //                         ],
//     //                       );
//     //                     },
//     //                   ),
//     //                 ),
//     //               ],
//     //             ),
//     //           );
//     //         }
//     //       } else {
//     //         return Container();
//     //       }
//     //     }
//     // );
//   }
//
//   Widget bottomSheetHeader(BuildContext context, [int? commentCount]) {
//
//     return MeasureSize(
//       onChange: (Size size) {
//         // setState(() {
//         //   childSize = size.height;
//         // });
//       },
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 8, bottom: 12),
//             child: Center(
//               child: Image.asset('assets/feed/comment_header_bar.png', width: 75, height: 4),
//             ),
//           ),
//           Consumer<FeedProvider>(
//             builder: (context, data, child) => Padding(
//               padding: const EdgeInsets.only(left: 20, right: 20, bottom: 18),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       data.inputMode == 1 ?
//                       Row(
//                         children: [
//                           Material(
//                             color: Colors.transparent,
//                             child: InkWell(
//                               borderRadius: BorderRadius.circular(25.0),
//                               onTap: () {
//                                 /// 댓글로 전환
//                                 context.read<FeedProvider>().inputModeChange(0);
//                               },
//                               child: Image.asset('assets/feed/back_arrow.png', width: 22, height: 22),
//                             ),
//                           ),
//                           const SizedBox(width: 4.0),
//                         ],
//                       ) : const SizedBox.shrink(),
//                       Text(data.inputMode == 1 ? '답글' : '댓글', style: TextStyle(fontSize: 18, color: StaticColor.grey80033, fontWeight: FontWeight.w700)),
//                       const SizedBox(width: 4),
//                       Text(data.inputMode == 1 ? '' : (commentCount == null ? '' : commentCount.toString()), style: TextStyle(fontSize: 12, color: StaticColor.grey60077, fontWeight: FontWeight.w400)),
//                     ],
//                   ),
//                   data.inputMode == 1 ? const SizedBox.shrink() : Row(
//                     children: [
//                       // data.sortState[0] == false ? const SizedBox.shrink() : Image.asset('assets/feed/comment_sort_check_icon.png', width: 16, height: 16),
//                       const SizedBox(width: 4),
//                       GestureDetector(
//                           onTap: () {
//                             context.read<FeedProvider>().commentModelRequest(widget.postId!, '-point');
//                           },
//                           child: Text('인기순',
//                               style: TextStyle(
//                                   fontSize: 12,
//                                   color: data.sortState == '-point' ? StaticColor.black90015 : StaticColor.grey400BB,
//                                   fontWeight: data.sortState == '-point' ? FontWeight.w500 : FontWeight.w400))),
//                       const SizedBox(width: 8),
//                       // data.sortState[1] == false ? const SizedBox.shrink() : Image.asset('assets/feed/comment_sort_check_icon.png', width: 16, height: 16),
//                       const SizedBox(width: 4),
//                       GestureDetector(
//                           onTap: () {
//                             context.read<FeedProvider>().commentModelRequest(widget.postId!, '-created');
//                           },
//                           child: Text('최신순',
//                               style: TextStyle(
//                                   fontSize: 12,
//                                   color: data.sortState == '-created' ? StaticColor.black90015 : StaticColor.grey400BB,
//                                   fontWeight: data.sortState == '-created' ? FontWeight.w500 : FontWeight.w400))),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             height: 1,
//             color: StaticColor.grey300E0,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget commentRow(BuildContext context, List<CommentResponseModel> model, int index) {
//
//     /// 댓글 입력 시점
//     DateTime nowTime = DateTime.now();
//     DateTime compareTime = DateTime.parse(model.elementAt(index).created!);
//     final duration = nowTime.difference(compareTime);
//
//     int baseInteger = 0;
//     String commentGap = '';
//     if(duration.inHours == 0) {
//       if(duration.inMinutes == 0) {
//         commentGap = '지금';
//       } else if(duration.inMinutes <= 59 && duration.inMinutes > 0) {
//         baseInteger = duration.inMinutes % 60;
//         commentGap = '$baseInteger분 전';
//       }
//
//     } else if(duration.inHours <= 23 && duration.inHours > 0) {
//       baseInteger = duration.inHours % 24;
//       commentGap = '$baseInteger시간 전';
//     } else {
//       baseInteger = duration.inHours ~/ 24;
//       commentGap = '$baseInteger일 전';
//     }
//
//     return Material(
//       color: Colors.transparent,
//       child: Padding(
//         padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// personal comment header
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     UserProfileImage(profileImageUrl: model.elementAt(index).commentUser!.profileImageUrl),
//                     const SizedBox(width: 8),
//                     Text(model.elementAt(index).commentUser!.username! == '' ? 'user-${model.elementAt(index).commentUser!.id}' : model.elementAt(index).commentUser!.username!, style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w500)),
//                     const SizedBox(width: 4),
//                     Image.asset('assets/feed/comment_dot.png', width: 3, height: 3),
//                     const SizedBox(width: 4),
//                     Text(commentGap, style: TextStyle(fontSize: 14, color: StaticColor.grey400BB, fontWeight: FontWeight.w500)),
//                   ],
//                 ),
//                 Material(
//                     color: Colors.transparent,
//                     child: InkWell(
//                       onTap: () {
//                         model.elementAt(index).commentUser!.id == PresentUserInfo.id
//                             ? showModalBottomSheet(context: context, backgroundColor: Colors.transparent, builder: (context) { return Wrap(children: [myCommentBottomSheet(context, model.elementAt(index))]);})
//                             : showModalBottomSheet(context: context, backgroundColor: Colors.transparent, builder: (context) { return Wrap(children: [reportBottomSheet(context, model.elementAt(index).id!)]);});
//                       },
//                       customBorder: const CircleBorder(),
//                       child: Image.asset('assets/feed/comment_etc_icon.png', width: 24, height: 24),
//                     )
//                 )
//               ],
//             ),
//             /// personal comment description
//             Padding(
//               padding: const EdgeInsets.only(left: 42),
//               child: Text(model.elementAt(index).content!),
//             ),
//             // Padding(
//             //   padding: const EdgeInsets.only(left: 40),
//             //   child: OverflowText(
//             //       text: CommentModel.description[index], maxLength: 10)
//             // ),
//             /// personal comment like, subcomment field
//             // Consumer<FeedProvider>(
//             //   builder: (context, data, child) {
//             //     return
//             //   }
//             // ),
//             Padding(
//               padding: const EdgeInsets.only(left: 40, top: 10, bottom: 2),
//               child: Row(
//                 children: [
//                   CommentLikeButton(state: model.elementAt(index).isLiked!, index: index, postId: widget.postId!, id: model.elementAt(index).id!),
//                   const SizedBox(width: 4),
//                   Text(model.elementAt(index).likeCount.toString(), style: TextStyle(fontSize: 13, color: StaticColor.grey400BB, fontWeight: FontWeight.w400)),
//                   const SizedBox(width: 16),
//                   CommentButton(state: false),
//                   const SizedBox(width: 4),
//                   Text(model.elementAt(index).childCommentList!.length.toString(), style: TextStyle(fontSize: 13, color: StaticColor.grey400BB, fontWeight: FontWeight.w400)),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget myCommentBottomSheet(BuildContext context, [CommentResponseModel? model]) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
//       ),
//       child: Column(
//         children: [
//           /// title section
//           Padding(
//             padding: const EdgeInsets.only(left: 24, right: 26, top: 24, bottom: 32),
//             child: Text('나의 댓글', style: TextStyle(fontSize: 18, color: StaticColor.grey80033, fontWeight: FontWeight.w700)),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 20, right: 20, bottom: 64),
//             child: Column(
//               children: [
//                 Container(
//                   width: double.infinity,
//                   height: 48,
//                   decoration: BoxDecoration(
//                     color: Colors.transparent,
//                     borderRadius: BorderRadius.circular(4.0),
//                   ),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                       widget.editingController!.text = model!.content!;
//                       context.read<FeedProvider>().inputModeChange(2, model!.id!);
//                       // showDialog(context: context, builder: (context) {
//                       //   return ReportDialog(index: model!.id!);
//                       // });
//                     },
//                     style: ElevatedButton.styleFrom(backgroundColor: StaticColor.grey100F6, elevation: 0.0),
//                     child: Text('수정하기', style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
//                   ),
//                 ),
//                 const SizedBox(height: 8.0),
//                 Container(
//                   width: double.infinity,
//                   height: 48,
//                   decoration: BoxDecoration(
//                     color: Colors.transparent,
//                     borderRadius: BorderRadius.circular(4.0),
//                   ),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                       showDialog(context: context, builder: (context) {
//                         return CommentDeleteDialog(postId: model!.postBottomInfo!.id, index: model!.id!);
//                         // return Container(
//                         //   color: Colors.transparent,
//                         //   child: Container(
//                         //     width: 100,
//                         //     height: 100,
//                         //     color: Colors.white,
//                         //   )
//                         // );
//                       });
//                     },
//                     style: ElevatedButton.styleFrom(backgroundColor: StaticColor.errorBackgroundColor, elevation: 0.0),
//                     child: Text('삭제하기', style: TextStyle(fontSize: 14, color: StaticColor.textErrorColor, fontWeight: FontWeight.w400)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget reportBottomSheet(BuildContext context, int index) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
//       ),
//       child: Column(
//         children: [
//           /// title section
//           Padding(
//             padding: const EdgeInsets.only(left: 24, right: 26, top: 24, bottom: 32),
//             child: Text('신고', style: TextStyle(fontSize: 18, color: StaticColor.grey80033, fontWeight: FontWeight.w700)),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 20, right: 20, bottom: 64),
//             child: Column(
//               children: [
//                 Container(
//                   width: double.infinity,
//                   height: 48,
//                   decoration: BoxDecoration(
//                     color: Colors.transparent,
//                     borderRadius: BorderRadius.circular(4.0),
//                   ),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                       showDialog(context: context, builder: (context) {
//                         return ReportDialog(index: index!);
//                       });
//                     },
//                     style: ElevatedButton.styleFrom(backgroundColor: StaticColor.errorBackgroundColor, elevation: 0.0),
//                     child: Text('신고하기', style: TextStyle(fontSize: 14, color: StaticColor.textErrorColor, fontWeight: FontWeight.w400)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
