import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/event_feed/event_feed_recommend_model.dart';
import 'package:sense_flutter_application/views/create_event/create_event_improve_provider.dart';

class RecommendCommentDeleteDialog extends StatefulWidget {
  int commentId;
  RecommendCommentDeleteDialog({super.key, required this.commentId});

  @override
  State<RecommendCommentDeleteDialog> createState() => _RecommendCommentDeleteDialogState();
}

class _RecommendCommentDeleteDialogState extends State<RecommendCommentDeleteDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(10),
      contentPadding: EdgeInsets.zero,
      // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)),
      //Dialog Main Title
      title: Column(
        children: [
          Text('추천을 삭제하시겠습니까?', style: TextStyle(fontSize: 18, color: StaticColor.addEventCancelTitle, fontWeight: FontWeight.w700)),
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
                  child: Text('취소', style: TextStyle(fontSize: 14, color: StaticColor.contactLoadTextColor, fontWeight: FontWeight.w400)),
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

                    bool result = await RecommendsRequest().deleteReCommendComment(widget.commentId);
                    if(result == true) {
                      context.read<CreateEventImproveProvider>().useRebuildChange();
                      Navigator.of(context).pop();
                    } else {}
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categorySelectedColor, elevation: 0.0),
                  child: Text('확인', style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400)),
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
