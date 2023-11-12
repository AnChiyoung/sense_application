import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/feed/feed_search_view.dart';

class FeedSearchScreen extends StatefulWidget {
  const FeedSearchScreen({super.key});

  @override
  State<FeedSearchScreen> createState() => _FeedSearchScreenState();
}

class _FeedSearchScreenState extends State<FeedSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: const Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FeedSearchHeader(),
              FeedSearchTab(),
            ],
          ),
        ),
      ),
    );
  }
}
