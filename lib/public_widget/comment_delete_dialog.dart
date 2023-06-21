import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/feed/comment_model.dart';
import 'package:sense_flutter_application/views/feed/feed_provider.dart';

class CommentDeleteDialog extends StatefulWidget {
  Function? action;
  int? postId;
  int? index;
  CommentDeleteDialog({Key? key, this.action, this.postId, this.index}) : super(key: key);

  @override
  State<CommentDeleteDialog> createState() => _CommentDeleteDialog();
}

class _CommentDeleteDialog extends State<CommentDeleteDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(10),
      contentPadding: EdgeInsets.zero,
      // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)),
      //Dialog Main Title
      title: Column(
        children: [
          Text('댓글을 완전히 삭제할까요?', style: TextStyle(fontSize: 18, color: StaticColor.addEventCancelTitle, fontWeight: FontWeight.w700)),
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
                  style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categoryUnselectedColor, elevation: 0.0),
                  child: Text('취소하기', style: TextStyle(fontSize: 14, color: StaticColor.contactLoadTextColor, fontWeight: FontWeight.w400)),
                ),
              ),
            ),
            const SizedBox(
                width: 8
            ),
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
                    CommentResponseModel model = await CommentRequest().commentDeleteRequest(widget.index!);
                    context.read<FeedProvider>().commentModelRequest(widget.postId!, context.read<FeedProvider>().sortState);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categorySelectedColor, elevation: 0.0),
                  child: Text('삭제하기', style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400)),
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