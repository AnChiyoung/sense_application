import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sense_flutter_application/apis/post/post_api.dart';
import 'package:sense_flutter_application/screens/widgets/common/TextIcon.dart';
import 'package:sense_flutter_application/screens/widgets/common/comment_text_area.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_button.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_modal.dart';
import 'package:sense_flutter_application/screens/widgets/modals/report_modal.dart';
import 'package:sense_flutter_application/service/auth_service.dart';
import 'package:sense_flutter_application/store/providers/Post/comment_collection_provider.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';

class CommentSection extends ConsumerWidget {
  final int postId;

  const CommentSection({super.key, required this.postId});

  Widget loading(BuildContext context) {
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue fetcher = ref.watch(futureCommentProvider(postId.toString()));
    final commentProviders = ref.watch(commentProvider);
    if (fetcher.isLoading || commentProviders.isEmpty) {
      return loading(context);
    }

    List<dynamic> comments = commentProviders['data'].toList();

    final commentCount = ref.watch(commentCountProvider);

    return FutureBuilder(
        future: AuthService().getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loading(context);
          }

          Map<String, dynamic> currentUser = snapshot.data ?? {};

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
                                currentUser: currentUser,
                                isParent: true,
                                isLiked: comment['is_liked'] ?? false,
                                commentId: comment['id'],
                                content: comment['content'],
                                user: comment['user'],
                                replies: comment['child_comments'],
                                likesCount: comment['like_count'],
                                onReplied: (int parentId, String comment) {
                                  PostApi()
                                      .replyToAComment(parentId.toString(), comment)
                                      .then((value) {
                                    ref
                                        .read(commentProvider.notifier)
                                        .addChildComment(value['data']);
                                  });
                                  // ref.read(commentProvider.notifier).addChildComment();
                                },
                                onDelete: (int commentId) {
                                  ref.read(commentProvider.notifier).removeComment(commentId);
                                },
                                onLiked: (value) {
                                  ref.read(commentProvider.notifier).likeAcomment(value['data']);
                                },
                              ))
                          .toList(),
                    );
                  },
                  loading: () => const CircularProgressIndicator(),
                  error: (error, stack) => Text('Error: $error'),
                ),
                if (commentProviders['next'] != null) ...[
                  const SizedBox(height: 32),
                  CustomButton(
                    onPressed: () {
                      ref.read(commentProvider.notifier).loadMoreComments();
                    },
                    height: 40,
                    backgroundColor: const Color(0xFFF6F6F6),
                    textColor: const Color(0xFF555555),
                    labelText: '이전 댓글 보기',
                    suffixIcon: SvgPicture.asset('lib/assets/images/icons/svg/caret_down.svg',
                        width: 18, height: 18),
                  )
                ]
              ],
            ),
          );
        });
  }
}

class CommentTile extends StatefulWidget {
  final Map<String, dynamic> user;
  final String content;
  final List<dynamic> replies;
  final int commentId;
  final bool isParent;
  final bool isLiked;
  final int likesCount;
  final Null Function(int parentId, String content)? onReplied;
  final Function(Map<String, dynamic>)? onLiked;
  final Map<String, dynamic> currentUser;
  final Null Function(int commentId) onDelete;

  const CommentTile(
      {super.key,
      required this.currentUser,
      required this.commentId,
      required this.content,
      required this.user,
      this.isLiked = false,
      this.replies = const [],
      this.onReplied,
      this.onLiked,
      this.likesCount = 0,
      required this.isParent,
      required this.onDelete});

  @override
  State<CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  bool isReplying = false;
  bool isShowAll = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> childComment = widget.replies
        .map((e) => ReplyTile(
              child: CommentTile(
                  onDelete: widget.onDelete,
                  currentUser: widget.currentUser,
                  onLiked: widget.onLiked,
                  isLiked: e['is_liked'] ?? false,
                  likesCount: e['like_count'],
                  isParent: false,
                  commentId: e['id'],
                  content: e['content'],
                  user: e['user']),
            ))
        .toList();
    List<Widget> filtiredComments = [];

    // Filter child replies
    filtiredComments = childComment.take(1).toList();
    if (childComment.length > 1) {
      filtiredComments = [
        ...filtiredComments,
        TextButton(
          onPressed: () {
            // Handle button click
            setState(() {
              isShowAll = true;
            });
          },
          child: Text(
            '답글 ${childComment.length - 1}개',
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ];
    }

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
                            text: '${widget.user['username'] ?? widget.user['email']}',
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
                    onPressed: () {
                      CustomModal.showBottomSheet(context, (Function callback) {
                        return [
                          Expanded(
                              child: SizedBox(
                                  width: double.infinity,
                                  child: CustomButton(
                                    onPressed: () {
                                      callback();
                                      if (widget.currentUser['id'] == widget.user['id']) {
                                        CustomModal.showConfirmModal(
                                          context,
                                          title: '댓글을 삭제하시겠습니까?',
                                          buttonLabel: 'Ok',
                                          callback: (isConfirm) {
                                            if (isConfirm) {
                                              PostApi()
                                                  .deleteComment(widget.commentId.toString())
                                                  .then((value) {
                                                widget.onDelete(widget.commentId);
                                              });
                                            }
                                          },
                                        );
                                      } else {
                                        CustomModal.showWidgetModal(
                                          context,
                                          title: '댓글을 삭제하시겠습니까?',
                                          buttonLabel: 'Ok',
                                          child: ReportModal(
                                            commentId: widget.commentId.toString(),
                                            callback: (bool isReported) {
                                              CustomModal.closeModal();
                                              if (isReported) {
                                                CustomModal.showModal(
                                                  context,
                                                  title: '신고해 주셔서 감사합니다',
                                                  message: '빠르게 검토한 후 조치하도록 하겠습니다.',
                                                  buttonLabel: '확인',
                                                );
                                              }
                                            },
                                          ),
                                        );
                                      }
                                    },
                                    textColor: errorColor[0] ?? Colors.red,
                                    backgroundColor: Colors.transparent,
                                    labelText: widget.currentUser['id'] == widget.user['id']
                                        ? 'Delete'
                                        : 'Report',
                                  ))),
                          const SizedBox(height: 16),
                          Expanded(
                              child: SizedBox(
                            width: double.infinity,
                            child: CustomButton(
                              onPressed: () {
                                callback();
                              },
                              labelText: 'Cancel',
                              backgroundColor: Colors.white,
                              textColor: const Color(0xFF555555),
                            ),
                          ))
                        ];
                      });
                    },
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
            ActionButtons(
                isLike: widget.isLiked,
                isReply: widget.isParent,
                likeCount: widget.likesCount,
                commentCount: widget.replies.length,
                onTapLike: () {
                  if (!widget.isLiked) {
                    PostApi().likeToAComment(widget.commentId.toString()).then((value) {
                      widget.onLiked?.call(value);
                    });
                  } else {
                    PostApi().dislikeToAComment(widget.commentId.toString()).then((value) {
                      widget.onLiked?.call(value);
                    });
                  }
                },
                onTapReply: () {
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
                widget.onReplied?.call(widget.commentId, comment);

                // Close the reply text area after sending the comment
                setState(() {
                  isReplying = false;
                });
              },
            ))),

      // Show all replies
      Column(
        children: isShowAll ? childComment : filtiredComments,
      )
    ]);
  }
}

class ActionButtons extends StatelessWidget {
  final Null Function() onTapReply;
  final Null Function() onTapLike;
  final bool isReply;
  final bool isLike;
  final int likeCount;
  final int commentCount;

  const ActionButtons(
      {super.key,
      required this.onTapReply,
      this.isReply = true,
      this.isLike = false,
      this.likeCount = 0,
      this.commentCount = 0,
      required this.onTapLike});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: IntrinsicHeight(
        child: Row(
          children: [
            InkWell(
                onTap: onTapLike,
                child: TextIcon(
                  text: '$likeCount',
                  iconPath: isLike
                      ? 'lib/assets/images/icons/svg/like_fill.svg'
                      : 'lib/assets/images/icons/svg/like.svg',
                  iconColor: isLike ? primaryColor[50] : const Color(0xFFBBBBBB),
                  iconSize: 16,
                  spacing: 8,
                  textStyle: const TextStyle(color: Color(0xFF555555), fontSize: 12),
                )),
            if (isReply) ...[
              const SizedBox(width: 12),
              TextIcon(
                text: '$commentCount',
                iconPath: 'lib/assets/images/icons/svg/chat.svg',
                iconColor: const Color(0xFFBBBBBB),
                iconSize: 16,
                spacing: 8,
                textStyle: const TextStyle(color: Color(0xFF555555), fontSize: 12),
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
            ]
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
      backgroundImage: imageUrl.isNotEmpty ? CachedNetworkImageProvider(imageUrl) : null,
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
