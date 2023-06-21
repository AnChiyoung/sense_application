import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/public_widget/get_widget_size.dart';
import 'package:sense_flutter_application/views/feed/feed_provider.dart';

class CommentHeader extends StatefulWidget {
  int commentCount;
  int postId;
  CommentHeader({Key? key, required this.commentCount, required this.postId}) : super(key: key);

  @override
  State<CommentHeader> createState() => _CommentHeaderState();
}

class _CommentHeaderState extends State<CommentHeader> {
  @override
  Widget build(BuildContext context) {
    return MeasureSize(
      onChange: (Size size) {
        // setState(() {
        //   childSize = size.height;
        // });
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 12),
            child: Center(
              child: Image.asset('assets/feed/comment_header_bar.png', width: 75, height: 4),
            ),
          ),
          Consumer<FeedProvider>(
            builder: (context, data, child) => Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      data.inputMode == 1 ?
                      Row(
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(25.0),
                              onTap: () {
                                /// 댓글로 전환
                                context.read<FeedProvider>().inputModeChange(0);
                              },
                              child: Image.asset('assets/feed/back_arrow.png', width: 22, height: 22),
                            ),
                          ),
                          const SizedBox(width: 4.0),
                        ],
                      ) : const SizedBox.shrink(),
                      Text(data.inputMode == 1 ? '답글' : '댓글', style: TextStyle(fontSize: 18, color: StaticColor.grey80033, fontWeight: FontWeight.w700)),
                      const SizedBox(width: 4),
                      Text(data.inputMode == 1 ? '' : (widget.commentCount == -1 ? '0' : widget.commentCount.toString()), style: TextStyle(fontSize: 12, color: StaticColor.grey60077, fontWeight: FontWeight.w400)),
                    ],
                  ),
                  data.inputMode == 1 ? const SizedBox.shrink() : Row(
                    children: [
                      // data.sortState[0] == false ? const SizedBox.shrink() : Image.asset('assets/feed/comment_sort_check_icon.png', width: 16, height: 16),
                      const SizedBox(width: 4),
                      GestureDetector(
                          onTap: () {
                            context.read<FeedProvider>().commentModelRequest(widget.postId!, '-point');
                          },
                          child: Text('인기순',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: data.sortState == '-point' ? StaticColor.black90015 : StaticColor.grey400BB,
                                  fontWeight: data.sortState == '-point' ? FontWeight.w500 : FontWeight.w400))),
                      const SizedBox(width: 8),
                      // data.sortState[1] == false ? const SizedBox.shrink() : Image.asset('assets/feed/comment_sort_check_icon.png', width: 16, height: 16),
                      const SizedBox(width: 4),
                      GestureDetector(
                          onTap: () {
                            context.read<FeedProvider>().commentModelRequest(widget.postId!, '-created');
                          },
                          child: Text('최신순',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: data.sortState == '-created' ? StaticColor.black90015 : StaticColor.grey400BB,
                                  fontWeight: data.sortState == '-created' ? FontWeight.w500 : FontWeight.w400))),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 1,
            color: StaticColor.grey300E0,
          ),
        ],
      ),
    );
  }
}
