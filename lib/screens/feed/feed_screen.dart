import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/views/feed/feed_view.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {

    print('login access token ?? : ${PresentUserInfo.loginToken}');

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              // CachedNetworkImage(
              //   imageUrl: PresentUserInfo.profileImage.toString(),
              //   imageBuilder: (context, imageProvider) {
              //     return Container(
              //       width: 250,
              //       height: 250,
              //       decoration: BoxDecoration(
              //         shape: BoxShape.circle,
              //           image: DecorationImage(
              //               image: imageProvider, fit: BoxFit.scaleDown)
              //       )
              //     );
              //   }
              // ),
            FeedHeader(),
            FeedTagList(),
            FeedPostList(),
          ],
        ),
      ),
    );
  }
}
