import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/feed/feed_view.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        FeedHeader(),
        FeedTagList(),
        FeedPostList(),
      ],
    );
  }
}
