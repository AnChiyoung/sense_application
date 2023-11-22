import 'package:flutter/material.dart';
// import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/views/feed/feed_view.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    // SenseLogger().debug(
    //     '[login info]\naccess token : ${PresentUserInfo.loginToken}\nuser id : ${PresentUserInfo.id}\nuser name : ${PresentUserInfo.username}');

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: const Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FeedHeader(),
              FeedTagList(),
              FeedPostList(),
            ],
          ),
        ),
      ),
    );
  }
}
