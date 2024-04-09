import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sense_flutter_application/apis/post/post_api.dart';
import 'package:sense_flutter_application/models/comment.dart';
import 'package:sense_flutter_application/screens/widgets/common/TextIcon.dart';
import 'package:sense_flutter_application/screens/widgets/common/comment_text_area.dart';
import 'package:sense_flutter_application/store/providers/Post/comment_collection_provider.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';

class CommentSection extends ConsumerWidget {
  final int postId;
  final int commentCount;

  const CommentSection({super.key, required this.postId, this.commentCount = 0});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue fetcher = ref.watch(futureCommentProvider(postId.toString()));
    final commentProviders = ref.watch(commentProvider);
    if (fetcher.isLoading || commentProviders.isEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Container(
          color: Colors.white,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor[50] ?? Colors.white),
            ),
          ),
        ),
      );
    }

    List<dynamic> comments = commentProviders['data'].toList();

    return Container(
      padding: const EdgeInsets.only(top: 32),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xFFEEEEEE),
            width: 2,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(children: [
              const TextSpan(
                text: '댓글 ',
                style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF151515)),
              ),
              TextSpan(
                text: '$commentCount',
                style: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF151515)),
              ),
            ]),
          ),
          const SizedBox(
            height: 16,
          ),
          CommentTextArea(onSend: (String comment) {
            PostApi()
                .writeComment(postId.toString(), comment)
                .then((value) => ref.read(commentProvider.notifier).addComment(value));
          }),
          const SizedBox(
            height: 16,
          ),
          fetcher.when(
              data: (_) {
                return Column(
                  children: comments
                      .map((comment) => CommentTile(
                            commentId: comment['id'],
                            content: comment['content'],
                            user: comment['user'],
                            replies: comment['child_comments'],
                          ))
                      .toList(),
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text('Error: $error')),
        ],
      ),
    );
  }
}

class CommentTile extends StatefulWidget {
  final Map<String, dynamic> user;
  final String content;
  final List<dynamic> replies;
  final int commentId;

  const CommentTile(
      {super.key,
      required this.commentId,
      required this.content,
      required this.user,
      this.replies = const []});

  @override
  State<CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  bool isReplying = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> childComment = widget.replies
        .map((e) => ReplyTile(
              child: CommentTile(commentId: e['id'], content: e['content'], user: e['user']),
            ))
        .toList();

    return Column(children: [
      Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFEEEEEE),
              width: 1,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    ProfileAvatar(
                      size: 32,
                      imageUrl: widget.user['profile_image_url'] ?? '',
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    RichText(
                        text: TextSpan(
                            text: '${widget.user['username']}',
                            children: const [
                              TextSpan(text: ' • 5시간', style: TextStyle(color: Color(0xFFBBBBBB)))
                            ],
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF555555))))
                  ],
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz_outlined,
                      color: Color(0xFF555555),
                    ))
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Text(widget.content, style: const TextStyle(color: Color(0xFF151515), fontSize: 14)),
            ActionButtons(onTapReply: () {
              setState(() {
                isReplying = !isReplying;
              });
            })
          ],
        ),
      ),

      // When clicking reply button, show the reply text area
      if (isReplying)
        Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            child: ReplyTile(
                child: CommentTextArea(
              cancelButton: true,
              onCancel: () {
                setState(() {
                  isReplying = false;
                });
              },
              onSend: (String comment) {
                // Send Api post request reply comment using Parent Comment ID
                PostApi().replyToAComment(widget.commentId.toString(), comment).then((value) {
                  setState(() {
                    // Close the reply text area
                    isReplying = false;

                    // Append replied comment to parent comment
                    childComment.insert(
                        0,
                        ReplyTile(
                          child: CommentTile(
                              commentId: value['id'],
                              content: value['content'],
                              user: value['user']),
                        ));
                  });
                });
              },
            ))),

      // Show all replies
      ...childComment
    ]);
  }
}

class ActionButtons extends StatelessWidget {
  final Null Function() onTapReply;
  const ActionButtons({super.key, required this.onTapReply});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: IntrinsicHeight(
        child: Row(
          children: [
            const TextIcon(
              text: '12.5K',
              iconPath: 'lib/assets/images/icons/svg/like.svg',
              iconColor: Color(0xFFBBBBBB),
              iconSize: 16,
              spacing: 8,
              textStyle: TextStyle(color: Color(0xFF555555), fontSize: 12),
            ),
            const SizedBox(width: 12),
            const TextIcon(
              text: '1',
              iconPath: 'lib/assets/images/icons/svg/chat.svg',
              iconColor: Color(0xFFBBBBBB),
              iconSize: 16,
              spacing: 8,
              textStyle: TextStyle(color: Color(0xFF555555), fontSize: 12),
            ),
            const VerticalDivider(
              color: Color(0xFFEEEEEE),
              thickness: 1,
              width: 20,
            ),
            InkWell(
              onTap: onTapReply,
              child: const Text('답글 달기'),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  final double size;
  const ProfileAvatar({super.key, this.imageUrl = '', this.size = 32.0});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: const Color(0xFFEEEEEE),
      backgroundImage: imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
      child: SvgPicture.asset('lib/assets/images/icons/svg/user.svg'),
    );
  }
}

class ReplyTile extends StatelessWidget {
  final Widget child;
  const ReplyTile({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 12, right: 8),
            child: SvgPicture.asset(
              'lib/assets/images/icons/svg/comment_reply.svg',
              width: 24,
              height: 24,
              color: const Color(0xFFBBBBBB),
            )),
        Expanded(
          child: child,
        ),
      ],
    );
  }
}
