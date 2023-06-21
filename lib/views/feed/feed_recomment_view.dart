import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/feed/comment_model.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/public_widget/comment_delete_dialog.dart';
import 'package:sense_flutter_application/public_widget/comment_like_button.dart';
import 'package:sense_flutter_application/public_widget/comment_subcomment_button.dart';
import 'package:sense_flutter_application/public_widget/empty_user_profile.dart';
import 'package:sense_flutter_application/views/feed/feed_comment_view.dart';
import 'package:sense_flutter_application/views/feed/feed_provider.dart';

class RecommentView extends StatefulWidget {
  CommentResponseModel? commentModel;
  RecommentView({Key? key, this.commentModel}) : super(key: key);

  @override
  State<RecommentView> createState() => _RecommentViewState();
}

class _RecommentViewState extends State<RecommentView> {

  String commentCreatedTimeString = '';
  CommentResponseModel? model;

  String commentCreatedTime(String compare) {
    /// 댓글 입력 시점
    DateTime nowTime = DateTime.now();
    DateTime compareTime = DateTime.parse(compare);
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

  @override
  void initState() {
    commentCreatedTimeString = commentCreatedTime(widget.commentModel!.created.toString());
    model = widget.commentModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        /// 부모 댓글
        Container(
          color: StaticColor.grey100F6,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// personal comment header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        UserProfileImage(profileImageUrl: model!.commentUser!.profileImageUrl),
                        const SizedBox(width: 8),
                        Text(model!.commentUser!.username! == '' ? 'user-${model!.commentUser!.id}' : model!.commentUser!.username!, style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w500)),
                        const SizedBox(width: 4),
                        Image.asset('assets/feed/comment_dot.png', width: 3, height: 3),
                        const SizedBox(width: 4),
                        Text(commentCreatedTimeString, style: TextStyle(fontSize: 14, color: StaticColor.grey400BB, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            model!.commentUser!.id == PresentUserInfo.id
                                ? showModalBottomSheet(context: context, backgroundColor: Colors.transparent, builder: (context) { return Wrap(children: [myCommentBottomSheet(context, model!.id!)]);})
                                : showModalBottomSheet(context: context, backgroundColor: Colors.transparent, builder: (context) { return Wrap(children: [reportBottomSheet(context, model!.id!)]);});
                          },
                          customBorder: const CircleBorder(),
                          child: Image.asset('assets/feed/comment_etc_icon.png', width: 24, height: 24),
                        )
                    )
                  ],
                ),
                /// personal comment description
                Padding(
                  padding: const EdgeInsets.only(left: 42),
                  child: Text(model!.content!),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 40),
                //   child: OverflowText(
                //       text: CommentModel.description[index], maxLength: 10)
                // ),
                /// personal comment like, subcomment field
                Padding(
                  padding: const EdgeInsets.only(left: 40, top: 10, bottom: 12),
                  child: Row(
                    children: [
                      // CommentLikeButton(state: model!.isLiked!, index: -1),
                      const SizedBox(width: 4),
                      Text(model!.likeCount.toString(), style: TextStyle(fontSize: 13, color: StaticColor.grey400BB, fontWeight: FontWeight.w400)),
                      const SizedBox(width: 16),
                      CommentButton(state: false),
                      const SizedBox(width: 4),
                      Text(model!.likeCount.toString(), style: TextStyle(fontSize: 13, color: StaticColor.grey400BB, fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        /// 대댓글
        model!.childCommentList!.isEmpty
          ? const SizedBox.shrink()
          : ListView.builder(
              shrinkWrap: true,
              itemCount: model!.childCommentList!.length,
              itemBuilder: (context, index) {
                return RecommentField(childCommentModel: model!.childCommentList!.elementAt(index));
              }
            ),
      ],
    );
  }

  Widget myCommentBottomSheet(BuildContext context, [int? index]) {
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
                      showDialog(context: context, builder: (context) {
                        return ReportDialog(index: index!);
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
                        return CommentDeleteDialog(index: index!);
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
                        return ReportDialog(index: index!);
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

class RecommentField extends StatefulWidget {
  ChildComment? childCommentModel;
  RecommentField({Key? key, this.childCommentModel}) : super(key: key);

  @override
  State<RecommentField> createState() => _RecommentFieldState();
}

class _RecommentFieldState extends State<RecommentField> {

  ChildComment model = ChildComment();
  String commentCreatedTimeString = '';

  @override
  void initState() {
    model = widget.childCommentModel!;
    commentCreatedTimeString = commentCreatedTime(model.createdTime!.toString());
    super.initState();
  }

  String commentCreatedTime(String compare) {
    /// 댓글 입력 시점
    DateTime nowTime = DateTime.now();
    DateTime compareTime = DateTime.parse(compare);
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 36, right: 20, top: 12, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// personal comment header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  UserProfileImage(profileImageUrl: model!.childCommentUser!.profileImageUrl),
                  const SizedBox(width: 8),
                  Text(model!.childCommentUser!.username! == '' ? 'user-${model!.childCommentUser!.id}' : model!.childCommentUser!.username!, style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w500)),
                  const SizedBox(width: 4),
                  Image.asset('assets/feed/comment_dot.png', width: 3, height: 3),
                  const SizedBox(width: 4),
                  Text(commentCreatedTimeString, style: TextStyle(fontSize: 14, color: StaticColor.grey400BB, fontWeight: FontWeight.w500)),
                ],
              ),
              Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      model!.childCommentUser!.id == PresentUserInfo.id
                          ? showModalBottomSheet(context: context, backgroundColor: Colors.transparent, builder: (context) { return Wrap(children: [myCommentBottomSheet(context, model!.childCommentId!)]);})
                          : showModalBottomSheet(context: context, backgroundColor: Colors.transparent, builder: (context) { return Wrap(children: [reportBottomSheet(context, model!.childCommentId!)]);});
                    },
                    customBorder: const CircleBorder(),
                    child: Image.asset('assets/feed/comment_etc_icon.png', width: 24, height: 24),
                  )
              )
            ],
          ),
          /// personal comment description
          Padding(
            padding: const EdgeInsets.only(left: 42),
            child: Text(model!.content!),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 40),
          //   child: OverflowText(
          //       text: CommentModel.description[index], maxLength: 10)
          // ),
          /// personal comment like, subcomment field
          Consumer<FeedProvider>(
            builder: (context, data, child) => Padding(
              padding: const EdgeInsets.only(left: 40, top: 10, bottom: 12),
              child: Row(
                children: [
                  // CommentLikeButton(state: model!.isLiked!, index: -1),
                  const SizedBox(width: 4),
                  Text(model!.likeCount.toString(), style: TextStyle(fontSize: 13, color: StaticColor.grey400BB, fontWeight: FontWeight.w400)),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget myCommentBottomSheet(BuildContext context, [int? index]) {
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
                      showDialog(context: context, builder: (context) {
                        return ReportDialog(index: index!);
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
                        return CommentDeleteDialog(index: index!);
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
                        return ReportDialog(index: index!);
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

