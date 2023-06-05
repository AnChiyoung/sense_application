import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/models/feed/comment_model.dart';
import 'package:sense_flutter_application/views/feed/feed_provider.dart';

class CommentLikeButton extends StatefulWidget {
  final bool state;
  final int index;
  const CommentLikeButton({Key? key, required this.state, required this.index}) : super(key: key);

  @override
  State<CommentLikeButton> createState() => _CommentLikeButtonState();
}

class _CommentLikeButtonState extends State<CommentLikeButton> {

  bool likeState = false;

  @override
  void initState() {
    likeState = widget.state;
    super.initState();
  }

  void toggleLike() {
    // likeState = !likeState;
    // CommentModel.likeState[widget.index] = likeState;
    // CommentModel.likeState[widget.index] == true ? CommentModel.likeCount[widget.index] = 1 : CommentModel.likeCount[widget.index] = 0;
    // context.read<FeedProvider>().commentStateChange(likeState);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: toggleLike,
        child: likeState == false
            ? Image.asset('assets/feed/comment_like_empty_icon.png', width: 16, height: 16)
            : Image.asset('assets/feed/comment_like_fill_icon.png', width: 16, height: 16),
      ),
    );
  }
}
