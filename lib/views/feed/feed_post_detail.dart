import 'package:flutter/material.dart';
import 'package:sense_flutter_application/models/feed/feed_model.dart';

class FeedPostDetail extends StatefulWidget {
  final int postId;
  const FeedPostDetail({Key? key, required this.postId}) : super(key: key);

  @override
  State<FeedPostDetail> createState() => _FeedPostDetailState();
}

class _FeedPostDetailState extends State<FeedPostDetail> {
  late Future<FeedPostDetailModel> postDetail;

  @override
  initState() {
    postDetail = ApiService.getPostById(widget.postId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(double.infinity.toString());
    return Scaffold(
      body: Container(
        color: Colors.amber,
        child: FutureBuilder(
          future: postDetail,
          builder: (BuildContext context, AsyncSnapshot<FeedPostDetailModel> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Image.asset(
                    'assets/feed/temp_post_detail_top.png',
                    width: double.infinity,
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
