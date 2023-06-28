// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sense_flutter_application/constants/public_color.dart';
// import 'package:sense_flutter_application/models/feed/comment_model.dart';
// import 'package:sense_flutter_application/models/feed/feed_detail_model.dart';
// import 'package:sense_flutter_application/models/feed/report_model.dart';
// import 'package:sense_flutter_application/models/login/login_model.dart';
// import 'package:sense_flutter_application/public_widget/comment_delete_dialog.dart';
// import 'package:sense_flutter_application/public_widget/comment_like_button.dart';
// import 'package:sense_flutter_application/public_widget/comment_subcomment_button.dart';
// import 'package:sense_flutter_application/public_widget/empty_user_profile.dart';
// import 'package:sense_flutter_application/public_widget/get_widget_size.dart';
// import 'package:sense_flutter_application/public_widget/overflow_text.dart';
// import 'package:sense_flutter_application/public_widget/report_finish.dart';
// import 'package:sense_flutter_application/views/feed/feed_comment_area.dart';
// import 'package:sense_flutter_application/views/feed/feed_provider.dart';
// import 'package:sense_flutter_application/views/feed/feed_recomment_view.dart';
//
// class CommentView extends StatefulWidget {
//   int? postId;
//   double? topPadding;
//   int? commentCount;
//   CommentView({Key? key, this.postId, this.topPadding, this.commentCount}) : super(key: key);
//
//   @override
//   State<CommentView> createState() => _CommentViewState();
// }
//
// class _CommentViewState extends State<CommentView> {
//
//   TextEditingController commentInputController = TextEditingController();
//   double childSize = 0.0;
//
//   double getBottomSheetMaxHeight(BuildContext context, double topPadding) {
//     return (MediaQuery.of(context).size.height - topPadding) / MediaQuery.of(context).size.height;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     double bottomSheetMaxHeight = getBottomSheetMaxHeight(context, widget.topPadding!);
//
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: DraggableScrollableSheet(
//         expand: false,
//         initialChildSize: 0.6,
//         maxChildSize: 1.0,
//         builder: (BuildContext context, ScrollController scrollController) {
//           return Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: const BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
//               border: Border.all(color: StaticColor.grey400BB, width: 1),
//             ),
//             child: Stack(
//               children: [
//                 CommentArea(controller: scrollController, editingController: commentInputController, postId: widget.postId),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: commentInputField(context, commentInputController)),
//
//                 // /// comment request
//                 // Consumer<FeedProvider>(
//                 //   builder: (context, data, child) => data.recommentMode == true
//                 //     ? FutureBuilder(
//                 //         future: CommentRequest().commentRequest(widget.postId!, data.sortState.toString()),
//                 //         builder: (context, snapshot) {
//                 //           if(snapshot.hasError) {
//                 //             return Container();
//                 //           } else if(snapshot.hasData) {
//                 //             List<CommentResponseModel>? commentModels = snapshot.data!.elementAt(0);
//                 //             int commentCount = snapshot.data!.elementAt(1);
//                 //             return Column(
//                 //               mainAxisSize: MainAxisSize.min,
//                 //               children: [
//                 //                 bottomSheetHeader(context),
//                 //                 Padding(
//                 //                   padding: const EdgeInsets.only(bottom: 85),
//                 //                   child: RecommentView(commentModel: data.selectComment)
//                 //                 ),
//                 //               ],
//                 //             );
//                 //           } else {
//                 //             return Container();
//                 //           }
//                 //         }
//                 //       )
//                 //     :
//                 // ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget commentInputField(BuildContext context, TextEditingController controller) {
//
//     bool isRegedit = false;
//
//     return Container(
//       height: 85,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: StaticColor.grey400BB,
//             blurRadius: 1,
//             offset: const Offset(0, -1),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
//         child: Consumer<FeedProvider>(
//           builder: (context, data, child) => Row(
//             children: [
//               UserProfileImage(profileImageUrl: PresentUserInfo.profileImage ?? ''),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: Container(
//                   height: 32,
//                   color: StaticColor.grey100F6,
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: TextFormField(
//                     controller: commentInputController,
//                     autofocus: true,
//                     cursorColor: Colors.black,
//                     cursorHeight: 15,
//                     textInputAction: TextInputAction.done,
//                     maxLines: 1,
//                     textAlignVertical: TextAlignVertical.center,
//                     decoration: InputDecoration(
//                       hintText: data.inputMode == 0 ? '댓글 입력' : '답글 입력',
//                       hintStyle: TextStyle(fontSize: 14, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
//                       border: InputBorder.none,
//                       alignLabelWithHint: true,
//                     ),
//                     onChanged: (value) {
//                       if(value.isNotEmpty) {
//                         if(value.trim() == '') {
//
//                         } else {
//                           isRegedit = true;
//                           context.read<FeedProvider>().inputButtonStateChange(true);
//                         }
//                       } else {
//                         isRegedit = false;
//                         context.read<FeedProvider>().inputButtonStateChange(false);
//                       }
//                     },
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Material(
//                 color: Colors.transparent,
//                 child: InkWell(
//                     borderRadius: BorderRadius.circular(25.0),
//                     // onTap: () {
//                     onTap: () async {
//                       CommentResponseModel responseModel = CommentResponseModel();
//                       bool updateResult = false;
//                       /// 댓글
//                       if(data.inputMode == 0) {
//                         /// 공백이나 스페이스 입력 시에는 등록 x
//                         if(isRegedit == true) {
//                           responseModel = await CommentRequest().commentWriteRequest(widget.postId!, commentInputController.text);
//                         }
//
//                         if(responseModel == CommentResponseModel() || responseModel == null) {}
//                         else {
//                           context.read<FeedProvider>().inputButtonStateChange(false);
//                           context.read<FeedProvider>().feedDetailModelInitialize(
//                               responseModel.postBottomInfo!.isCommented,
//                               responseModel.postBottomInfo!.commentCount,
//                               responseModel.postBottomInfo!.isLiked,
//                               responseModel.postBottomInfo!.likeCount
//                           );
//                           context.read<FeedProvider>().commentModelRequest(widget.postId!, context.read<FeedProvider>().sortState);
//                           commentInputController.text = '';
//                           isRegedit = false;
//                         }
//                       }
//                       /// 답글
//                       else if(data.inputMode == 1) {
//
//                       }
//                       /// 수정
//                       else if(data.inputMode == 2) {
//                         if(isRegedit == true) {
//                           // updateResult = await CommentRequest().commentUpdateRequest(widget.postId!, commentInputController.text);
//                         }
//                         if(updateResult == true) {
//                           context.read<FeedProvider>().inputButtonStateChange(false);
//                           // context.read<FeedProvider>().commentModelRequest(context.read<FeedProvider>().selectCommentId, context.read<FeedProvider>().sortState);
//                           context.read<FeedProvider>().inputModeChange(0);
//                           commentInputController.text = '';
//                           isRegedit = false;
//                         } else {
//                           context.read<FeedProvider>().inputButtonStateChange(false);
//                           context.read<FeedProvider>().inputModeChange(0);
//                           commentInputController.text = '';
//                           isRegedit = false;
//                         }
//                       }
//
//
//
//
//
//
//
//
//
//
//
//                       // if(data.inputMode == true) {
//                       //   /// 여기 수정
//                       //   // bool inputRecommentResult = await CommentRequest().recommentWriteRequest(data.selectComment!.id!, commentInputController.text);
//                       //   // inputRecommentResult == true
//                       //   //     ? {
//                       //   //         context.read<FeedProvider>().inputButtonStateChange(false),
//                       //   //         context.read<FeedProvider>().recommentFieldUpdateChange(true),
//                       //   //         commentInputController.text = ''}
//                       //   //     : {};
//                       // } else
//                     },
//                     child: Consumer<FeedProvider>(
//                       builder: (context, data, child) => Center(child: Image.asset('assets/feed/comment_regedit.png', width: 24, height: 24, color: data.inputButton == true ? StaticColor.mainSoft : StaticColor.grey400BB))),
//                     )
//
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
