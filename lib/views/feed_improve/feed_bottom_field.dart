import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/feed/feed_detail_model.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/public_widget/empty_user_profile.dart';
import 'package:sense_flutter_application/public_widget/icon_ripple_button.dart';
import 'package:sense_flutter_application/public_widget/service_guide_dialog.dart';
import 'package:sense_flutter_application/views/feed/feed_post_detail_view.dart';
import 'package:sense_flutter_application/views/feed/feed_provider.dart';
import 'package:sense_flutter_application/views/feed_improve/feed_comment_field.dart';

class FeedBottomField extends StatefulWidget {
  FeedDetailModel? feedModel;
  double? bottomPadding;
  FeedBottomField({Key? key, this.feedModel, this.bottomPadding}) : super(key: key);

  @override
  State<FeedBottomField> createState() => _FeedBottomFieldState();
}

class _FeedBottomFieldState extends State<FeedBottomField> {

  FeedDetailModel? feedModel;

  @override
  void initState() {
    feedModel = widget.feedModel!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FeedProvider>(
        builder: (context, data, child) {

          bool commentState = false;
          bool likeState = false;
          int commentCount = 0;
          int likeCount = 0;

          if(data.commentCount == -1) {
            commentState = feedModel!.isCommented!;
            commentCount = feedModel!.commentCount!;
            likeState = feedModel!.isLiked!;
            likeCount = feedModel!.likeCount!;
          } else if(data.commentCount != -1) {
            commentState = data.isCommented;
            commentCount = data.commentCount;
            likeState = data.isLiked;
            likeCount = data.likeCount;
          }

          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: StaticColor.grey400BB,
                      blurRadius: 1,
                      offset: const Offset(0, -1),
                    )
                  ]
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          context.read<FeedProvider>().commentModelRequest(feedModel!.id!, context.read<FeedProvider>().sortState);
                          // context.read<FeedProvider>().commentVisibilityChange(true);
                          showModalBottomSheet(
                              isScrollControlled: true,
                              useSafeArea: true,
                              enableDrag: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                // return Container(height: 500, color: Colors.red,
                                // child: Expanded(child: Container(color: Colors.white)));
                                // return CommentView(postId: feedModel!.id);
                                return CommentView(postId: feedModel!.id, bottomPadding: widget.bottomPadding);
                              }
                          );
                        },
                        /// container로 gesture detector 영역 확장
                        child: Container(
                          height: double.infinity,
                          color: Colors.transparent,
                          child: Row(
                              children: [
                                commentState == true
                                    ? Image.asset('assets/feed/my_comment_fill.png', width: 22, height: 22)
                                    : Image.asset('assets/feed/my_comment_empty.png', width: 22, height: 22),
                                const SizedBox(width: 8),
                                Text(commentCount.toString(), style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                              ]
                          ),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LikeButton(isLiked: likeState!, likeCount: likeCount!, feedId: feedModel!.id!),
                        Text(likeCount.toString(), style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                        const SizedBox(width: 4),
                        IconRippleButton(
                          icon: Icons.share_rounded,
                          color: StaticColor.grey400BB,
                          size: 24,
                          padding: 8,
                          onPressed: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return const ServiceGuideDialog();
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}

class CommentInputField extends StatefulWidget {
  const CommentInputField({Key? key}) : super(key: key);

  @override
  State<CommentInputField> createState() => _CommentInputFieldState();
}

class _CommentInputFieldState extends State<CommentInputField> {

  bool isRegedit = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: StaticColor.grey400BB,
            blurRadius: 1,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Row(
          children: [
            UserProfileImage(profileImageUrl: PresentUserInfo.profileImage ?? ''),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                height: 32,
                color: StaticColor.grey100F6,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  // controller: commentInputController,
                  autofocus: true,
                  cursorColor: Colors.black,
                  cursorHeight: 15,
                  textInputAction: TextInputAction.done,
                  maxLines: 1,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    // hintText: data.inputMode == 0 ? '댓글 입력' : '답글 입력',
                    hintStyle: TextStyle(fontSize: 14, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                    border: InputBorder.none,
                    alignLabelWithHint: true,
                  ),
                  onChanged: (value) {
                    if(value.isNotEmpty) {
                      if(value.trim() == '') {
                      } else {
                        isRegedit = true;
                        context.read<FeedProvider>().inputButtonStateChange(true);
                      }
                    } else {
                      isRegedit = false;
                      context.read<FeedProvider>().inputButtonStateChange(false);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(width: 8),
            Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(25.0),
                  // onTap: () {
                  onTap: () async {
                    // CommentResponseModel responseModel = CommentResponseModel();
                    // bool updateResult = false;
                    // /// 댓글
                    // if(data.inputMode == 0) {
                    //   /// 공백이나 스페이스 입력 시에는 등록 x
                    //   if(isRegedit == true) {
                    //     responseModel = await CommentRequest().commentWriteRequest(widget.postId!, commentInputController.text);
                    //   }
                    //
                    //   if(responseModel == CommentResponseModel() || responseModel == null) {}
                    //   else {
                    //     context.read<FeedProvider>().inputButtonStateChange(false);
                    //     context.read<FeedProvider>().feedDetailModelInitialize(
                    //         responseModel.postBottomInfo!.isCommented,
                    //         responseModel.postBottomInfo!.commentCount,
                    //         responseModel.postBottomInfo!.isLiked,
                    //         responseModel.postBottomInfo!.likeCount
                    //     );
                    //     context.read<FeedProvider>().commentModelRequest(widget.postId!, context.read<FeedProvider>().sortState);
                    //     commentInputController.text = '';
                    //     isRegedit = false;
                    //   }
                    // }
                    // /// 답글
                    // else if(data.inputMode == 1) {
                    //
                    // }
                    // /// 수정
                    // else if(data.inputMode == 2) {
                    //   if(isRegedit == true) {
                    //     updateResult = await CommentRequest().commentUpdateRequest(widget.postId!, commentInputController.text);
                    //   }
                    //   if(updateResult == true) {
                    //     context.read<FeedProvider>().inputButtonStateChange(false);
                    //     context.read<FeedProvider>().commentModelRequest(context.read<FeedProvider>().selectCommentId, context.read<FeedProvider>().sortState);
                    //     context.read<FeedProvider>().inputModeChange(0);
                    //     commentInputController.text = '';
                    //     isRegedit = false;
                    //   } else {
                    //     context.read<FeedProvider>().inputButtonStateChange(false);
                    //     context.read<FeedProvider>().inputModeChange(0);
                    //     commentInputController.text = '';
                    //     isRegedit = false;
                    //   }
                    // }
                  },
                  child: Consumer<FeedProvider>(
                    builder: (context, data, child) {
                      return Center(child: Image.asset('assets/feed/comment_regedit.png', width: 24, height: 24, color: data.inputButton == true ? StaticColor.mainSoft : StaticColor.grey400BB));
                    }
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
