import 'package:flutter/material.dart';
import 'package:sense_flutter_application/models/feed/comment_model.dart';

class CommentPersonalRow extends StatefulWidget {

  CommentResponseModel model;
  int index;

  CommentPersonalRow({Key? key, required this.model, required this.index}) : super(key: key);

  @override
  State<CommentPersonalRow> createState() => _CommentPersonalRowState();
}

class _CommentPersonalRowState extends State<CommentPersonalRow> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            /// 답글로 전환
            // context.read<FeedProvider>().inputModeChange(1, commentModel.elementAt(index).id);
          },
          // child: commentRow(context, commentModelList!, index),
          child: Container(height: 30),
        ),
        const Divider(height: 0.1, color: Colors.grey),
      ],
    );
  }
}
