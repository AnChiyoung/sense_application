import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/feed/comment_model.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/public_widget/comment_delete_dialog.dart';
import 'package:sense_flutter_application/public_widget/comment_like_button.dart';
import 'package:sense_flutter_application/public_widget/comment_subcomment_button.dart';
import 'package:sense_flutter_application/public_widget/empty_user_profile.dart';
import 'package:sense_flutter_application/public_widget/report_dialog.dart';
import 'package:sense_flutter_application/views/feed/feed_provider.dart';
import 'package:sense_flutter_application/views/feed_improve/feed_bottom_field.dart';
import 'package:sense_flutter_application/views/feed_improve/feed_comment_header.dart';
import 'package:sense_flutter_application/views/feed_improve/feed_recomment_field.dart';
import 'package:sense_flutter_application/views/feed_improve/feed_recomment_header.dart';

class CommentView extends StatefulWidget {
  int? postId;
  double? bottomPadding;
  CommentView({Key? key, this.postId, this.bottomPadding}) : super(key: key);

  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          bottom: false,
          child: Stack(
              children: [
                Consumer<FeedProvider>(
                    builder: (context, data, child) {

                      bool isRecommentMode = data.recommentMode;
                      List<CommentResponseModel> models = [];
                      models.clear();
                      models = data.commentModels;
                      print('reload');

                      return DraggableScrollableSheet(
                          expand: true,
                          initialChildSize: 0.6,
                          maxChildSize: 1.0,
                          builder: (BuildContext context, ScrollController scrollController) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
                                border: Border.all(color: StaticColor.grey400BB, width: 1),
                              ),
                              child: Column(
                                children: [

                                  /// comment header
                                  SingleChildScrollView(
                                    physics: const ClampingScrollPhysics(),
                                    controller: scrollController,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // headerType,
                                        data.recommentMode == false
                                            ? CommentHeader(commentCount: data.commentModels.length, postId: widget.postId!)
                                            : RecommentHeader(postId: widget.postId!),
                                      ],
                                    ),
                                  ),

                                  /// comment list
                                  isRecommentMode == true
                                      ? Expanded(child: ParentCommentField(postId: widget.postId))
                                  // : Text(models.elementAt(0).content.toString()), // 뷰 재빌드 테스트용
                                      : models.isEmpty
                                        ? const Expanded(
                                            child: Center(child: Text('댓글이 없습니다.'))
                                          )
                                        : Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(bottom: 100),
                                            // child: Text(models.elementAt(0).content.toString()),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics: const ClampingScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              itemCount: models.length,
                                              itemBuilder: (BuildContext context, int index) {
                                                return Material(
                                                    color: Colors.transparent,
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          /// 답글로 전환
                                                          context.read<FeedProvider>().recommentModeChange(
                                                              true, index, models.elementAt(index));
                                                        },
                                                        // child: Text(models.elementAt(index).content.toString())));
                                                        child: commentPersonalRow(models.elementAt(index), index)));
                                              },
                                            ),
                                          )
                                        // child: Container(color: Colors.red),
                                      )
                                ],
                              ),
                            );
                          }
                      );
                    }
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: EdgeInsets.only(bottom: widget.bottomPadding!),
                      child: CommentInputField(postId: widget.postId!)),
                )
              ]
          ),
        ),
      ),
    );
  }

  Widget commentPersonalRow(CommentResponseModel model, int index) {

    print('----');
    print('${model.isLiked}/${model.likeCount}');

    String gap = commentGap(model.created!);
    bool active = false;
    model.content == '삭제된 댓글입니다.' ? active = false : active = true;

    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// personal comment header
                active == false
                    ? Row(
                      children: [
                        UserProfileImage(profileImageUrl: model.commentUser!.profileImageUrl),
                        const SizedBox(width: 8),
                        Text('삭제된 댓글입니다.', style: TextStyle(fontSize: 14, color: StaticColor.grey400BB, fontWeight: FontWeight.w400)),
                      ],
                    )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              UserProfileImage(profileImageUrl: model.commentUser!.profileImageUrl),
                              const SizedBox(width: 8),
                              Text(model.commentUser!.username! == '' ? 'user-${model.commentUser!.id}' : model.commentUser!.username!, style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w500)),
                              const SizedBox(width: 4),
                              Image.asset('assets/feed/comment_dot.png', width: 3, height: 3),
                              const SizedBox(width: 4),
                              Text(gap, style: TextStyle(fontSize: 14, color: StaticColor.grey400BB, fontWeight: FontWeight.w500)),
                            ],
                          ),
                          Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  model.commentUser!.id == PresentUserInfo.id
                                      ? showModalBottomSheet(context: context, backgroundColor: Colors.transparent, builder: (context) { return Wrap(children: [myCommentBottomSheet(context, model)]);})
                                      : showModalBottomSheet(context: context, backgroundColor: Colors.transparent, builder: (context) { return Wrap(children: [reportBottomSheet(context, model.id!)]);});
                                },
                                customBorder: const CircleBorder(),
                                child: Image.asset('assets/feed/comment_etc_icon.png', width: 24, height: 24),
                              )
                          )
                        ],
                      ),
                /// personal comment description
                active == false
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.only(left: 42),
                        child: Text(model.content!, style: const TextStyle(color: Colors.black)),
                      ),
                /// personal comment like, subcomment field
                Padding(
                  padding: const EdgeInsets.only(left: 40, top: 10, bottom: 2),
                  child: Row(
                    children: [
                      active == false
                          ? CommentLikeButton(active: false, state: model.isLiked!, postId: model.postBottomInfo!.id!, id: model.id!)
                          : CommentLikeButton(active: true, state: model.isLiked!, postId: model.postBottomInfo!.id!, id: model.id!),
                      const SizedBox(width: 4),
                      Text(model.likeCount.toString(), style: TextStyle(fontSize: 13, color: model.isLiked! == true ? StaticColor.mainSoft : StaticColor.grey400BB, fontWeight: FontWeight.w400)),
                      const SizedBox(width: 16),
                      CommentButton(state: model.isCommented!),
                      const SizedBox(width: 4),
                      Text(model.childCommentList!.length.toString(), style: TextStyle(fontSize: 13, color: model.isCommented! == true ? StaticColor.mainSoft : StaticColor.grey400BB, fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(height: 0.1, color: Colors.grey),
      ],
    );
  }

  String commentGap(String inputTime) {
    /// 댓글 입력 시점
    DateTime nowTime = DateTime.now();
    DateTime compareTime = DateTime.parse(inputTime);
    final duration = nowTime.difference(compareTime);

    int baseInteger = 0;
    String commentGap = '';
    if(duration.inHours == 0) {
      if(duration.inMinutes == 0) {
        commentGap = '지금';
      } else if(duration.inMinutes <= 59 && duration.inMinutes > 0) {
        baseInteger = duration.inMinutes % 60;
        commentGap = '$baseInteger분 전';
      }

    } else if(duration.inHours <= 23 && duration.inHours > 0) {
      baseInteger = duration.inHours % 24;
      commentGap = '$baseInteger시간 전';
    } else {
      baseInteger = duration.inHours ~/ 24;
      commentGap = '$baseInteger일 전';
    }
    return commentGap;
  }

  Widget myCommentBottomSheet(BuildContext context, [CommentResponseModel? model]) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
      ),
      child: Column(
        children: [
          /// title section
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 26, top: 24, bottom: 32),
            child: Text('나의 댓글', style: TextStyle(fontSize: 18, color: StaticColor.grey80033, fontWeight: FontWeight.w700)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 64),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      model != null ? context.read<FeedProvider>().commentUpdateMode(model) : {};
                      context.read<FeedProvider>().inputController.text = model!.content!;
                      // widget.editingController!.text = model!.content!;
                      // context.read<FeedProvider>().inputModeChange(2, model!.id!);
                      // showDialog(context: context, builder: (context) {
                      //   return ReportDialog(index: model!.id!);
                      // });
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: StaticColor.grey100F6, elevation: 0.0),
                    child: Text('수정하기', style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showDialog(context: context, builder: (context) {
                        return CommentDeleteDialog(postId: model!.postBottomInfo!.id, index: model.id!);
                        // return Container(
                        //   color: Colors.transparent,
                        //   child: Container(
                        //     width: 100,
                        //     height: 100,
                        //     color: Colors.white,
                        //   )
                        // );
                      });
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: StaticColor.errorBackgroundColor, elevation: 0.0),
                    child: Text('삭제하기', style: TextStyle(fontSize: 14, color: StaticColor.textErrorColor, fontWeight: FontWeight.w400)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget reportBottomSheet(BuildContext context, int index) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
      ),
      child: Column(
        children: [
          /// title section
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 26, top: 24, bottom: 32),
            child: Text('신고', style: TextStyle(fontSize: 18, color: StaticColor.grey80033, fontWeight: FontWeight.w700)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 64),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showDialog(context: context, builder: (context) {
                        return ReportDialog(index: index);
                      });
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: StaticColor.errorBackgroundColor, elevation: 0.0),
                    child: Text('신고하기', style: TextStyle(fontSize: 14, color: StaticColor.textErrorColor, fontWeight: FontWeight.w400)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}