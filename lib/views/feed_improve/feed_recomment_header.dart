import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/feed/feed_provider.dart';

class RecommentHeader extends StatefulWidget {
  int postId;
  RecommentHeader({super.key, required this.postId});

  @override
  State<RecommentHeader> createState() => _RecommentHeaderState();
}

class _RecommentHeaderState extends State<RecommentHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 12),
          child: Center(
            child: Image.asset('assets/feed/comment_header_bar.png', width: 75, height: 4),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 18),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              highlightColor: Colors.transparent,
              borderRadius: BorderRadius.circular(25.0),
              onTap: () {
                /// 댓글로 전환
                context.read<FeedProvider>().recommentModeToCommentMode(widget.postId, context.read<FeedProvider>().sortState);
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/feed/back_arrow.png', width: 22, height: 22),
                    const SizedBox(width: 4.0),
                    Text('답글', style: TextStyle(fontSize: 18, color: StaticColor.grey80033, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
