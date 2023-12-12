import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/models/feed/comment_model.dart';
import 'package:sense_flutter_application/views/feed/feed_provider.dart';

class CommentLikeButton extends StatefulWidget {
  bool active;
  bool state;
  int? postId;
  int id;
  CommentLikeButton({super.key, required this.active, required this.state, this.postId, required this.id});

  @override
  State<CommentLikeButton> createState() => _CommentLikeButtonState();
}

class _CommentLikeButtonState extends State<CommentLikeButton> {

  bool? isLiked;

  @override
  void initState() {
    isLiked = widget.state;
    super.initState();
  }

  void toggleLike() async {
    // likeState = !likeState;
    // CommentModel.likeState[widget.index] = likeState;
    // CommentModel.likeState[widget.index] == true ? CommentModel.likeCount[widget.index] = 1 : CommentModel.likeCount[widget.index] = 0;
    // context.read<FeedProvider>().commentStateChange(likeState);

    if(widget.active == false) {

    } else if(widget.active == true) {
      setState(() {
        isLiked = !isLiked!;
      });

      if(isLiked == true) {
        CommentResponseModel model = await CommentRequest().commentLikeRequest(widget.id);
        // setState(() {});
        // FeedDetailModel responseModel = await FeedRequest().postDetailLiked(widget.feedId);
        context.read<FeedProvider>().commentModelRequest(widget.postId!, context.read<FeedProvider>().sortState);
      } else if(isLiked == false) {
        CommentResponseModel model = await CommentRequest().commentUnlikeRequest(widget.id);
        // setState(() {});
        // FeedDetailModel responseModel = await FeedRequest().postDetailUnliked(widget.feedId);
        context.read<FeedProvider>().commentModelRequest(widget.postId!, context.read<FeedProvider>().sortState);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(25.0),
        onTap: toggleLike,
        child: widget.state == false
            ? Image.asset('assets/feed/comment_like_empty_icon.png', width: 16, height: 16)
            : Image.asset('assets/feed/comment_like_fill_icon.png', width: 16, height: 16),
      ),
    );
  }
}