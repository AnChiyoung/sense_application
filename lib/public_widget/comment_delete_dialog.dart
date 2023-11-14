import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/feed/comment_model.dart';
import 'package:sense_flutter_application/views/feed/feed_provider.dart';

class CommentDeleteDialog extends StatefulWidget {
  Function? action;
  int? postId;
  int? index;
  CommentDeleteDialog({super.key, this.action, this.postId, this.index});

  @override
  State<CommentDeleteDialog> createState() => _CommentDeleteDialog();
}

class _CommentDeleteDialog extends State<CommentDeleteDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(10),
      contentPadding: EdgeInsets.zero,
      // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      //Dialog Main Title
      title: Column(
        children: [
          Text('댓글을 완전히 삭제할까요?',
              style: TextStyle(
                  fontSize: 18,
                  color: StaticColor.addEventCancelTitle,
                  fontWeight: FontWeight.w700)),
        ],
      ),
      //
      content: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 28, bottom: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 32,
                decoration: BoxDecoration(
                  color: StaticColor.categoryUnselectedColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: StaticColor.categoryUnselectedColor, elevation: 0.0),
                  child: Text('취소하기',
                      style: TextStyle(
                          fontSize: 14,
                          color: StaticColor.contactLoadTextColor,
                          fontWeight: FontWeight.w400)),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: Container(
                height: 32,
                decoration: BoxDecoration(
                  color: StaticColor.categoryUnselectedColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    // widget.action!.call();
                    Navigator.of(context).pop();
                    CommentResponseModel deleteResponseModel =
                        await CommentRequest().commentDeleteRequest(widget.index!);
                    if (deleteResponseModel == CommentResponseModel()) {
                    } else {
                      context.read<FeedProvider>().commentInputResult(
                          widget.postId!,
                          context.read<FeedProvider>().sortState,
                          deleteResponseModel.postBottomInfo!.isCommented!,
                          deleteResponseModel.postBottomInfo!.commentCount!,
                          deleteResponseModel.postBottomInfo!.isLiked!,
                          deleteResponseModel.postBottomInfo!.likeCount!);

                      /// 삭제 snackbar 추가
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(milliseconds: 2000),
                          backgroundColor: Colors.transparent,
                          elevation: 0.0,
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height - 150,
                          ),
                          content: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(color: StaticColor.snackbarColor, width: 1),
                            ),
                            child: Container(
                              color: Colors.transparent,
                              child: Row(
                                children: [
                                  Image.asset('assets/signin/snackbar_ok_icon.png',
                                      width: 24, height: 24),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      context.read<FeedProvider>().isRecommentOption == true
                                          ? '답글이 삭제 됐습니다'
                                          : '댓글이 삭제 됐습니다',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: StaticColor.snackbarColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );

                      if (deleteResponseModel.parentCommentId == -1) {
                        /// 댓글일 때,
                        context.read<FeedProvider>().recommendModeToCommentMode(
                            widget.postId!, context.read<FeedProvider>().sortState);

                        // if(deleteResponseModel.isDelete == false) {
                        //   print('is deleted => false');
                        //   context.read<FeedProvider>().recommendModeToCommentMode(widget.postId!, context.read<FeedProvider>().sortState);
                        // } else {
                        //   print('etc');
                        // }
                      } else {
                        /// 답글일 때,
                      }
                    }
                    // context.read<FeedProvider>().commentModelRequest(widget.postId!, context.read<FeedProvider>().sortState);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: StaticColor.categorySelectedColor, elevation: 0.0),
                  child: const Text('삭제하기',
                      style: TextStyle(
                          fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400)),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: null,
    );
  }
}
