class Comment {
  final String text;
  final List<Comment> replies;
  final Map<String, dynamic> user;
  final int likeCount;

  Comment({required this.text, this.replies = const [], required this.user, this.likeCount = 0});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        text: json['content'],
        user: json['user'],
        likeCount: json['like_count'],
        replies: json['child_comments']);
  }
}
