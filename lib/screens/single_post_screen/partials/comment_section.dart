import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sense_flutter_application/apis/post/post_api.dart';
import 'package:sense_flutter_application/models/comment.dart';
import 'package:sense_flutter_application/screens/widgets/common/comment_text_area.dart';
import 'package:sense_flutter_application/store/providers/Post/post_collection_provider.dart';

class CommentSection extends ConsumerWidget {
  final int post_id;
  final int commentCount;

  const CommentSection({super.key, required this.post_id, this.commentCount = 0});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          const CommentTextArea(),
          const SizedBox(
            height: 16,
          ),
          FutureBuilder(
              future: ref.read(commentProvider.notifier).fetchComments(post_id.toString()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container();
              })
        ],
      ),
    );
  }
}

class CommentTile extends StatelessWidget {
  final Comment comment;

  const CommentTile({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                const ProfileAvatar(
                  size: 32,
                ),
                const SizedBox(
                  width: 8,
                ),
                RichText(
                    text: const TextSpan(
                        text: '김영하',
                        children: [
                          TextSpan(text: ' • 5시간', style: TextStyle(color: Color(0xFFBBBBBB)))
                        ],
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF555555))))
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
        Text(comment.text, style: const TextStyle(color: Color(0xFF151515), fontSize: 14))
      ],
    );
  }
}

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
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
  final Comment reply;

  const ReplyTile({super.key, required this.reply});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(reply.text),
      leading: const Icon(Icons.reply),
    );
  }
}
