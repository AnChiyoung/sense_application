import 'package:flutter/material.dart';

class CommentButton extends StatefulWidget {
  bool? state;
  CommentButton({Key? key, this.state}) : super(key: key);

  @override
  State<CommentButton> createState() => _CommentButton();
}

class _CommentButton extends State<CommentButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: widget.state == false
          ? Image.asset('assets/feed/subcomment_empty_icon.png', width: 16, height: 16)
          : Image.asset('assets/feed/subcomment_fill_icon.png', width: 16, height: 16),
    );
  }
}
