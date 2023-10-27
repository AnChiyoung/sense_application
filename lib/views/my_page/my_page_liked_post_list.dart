import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/feed/feed_model.dart';
import 'package:sense_flutter_application/views/feed/feed_post_thumbnail.dart';
import 'package:sense_flutter_application/views/my_page/my_page_provider.dart';


/// post는 feed 입니다.
class MyPageLikedPostList extends StatefulWidget {
  const MyPageLikedPostList({super.key});

  @override
  State<MyPageLikedPostList> createState() => _MyPageLikedPostListState();
}

class _MyPageLikedPostListState extends State<MyPageLikedPostList> {

  @override
  void initState() {
    super.initState();
  }

  // @todo 무한스크롤 붙이기
  @override
  Widget build(BuildContext context) {
    final safeAreaBottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      margin: EdgeInsets.only(bottom: safeAreaBottomPadding),
      child: FutureBuilder(
        future: FeedRequest().likedPostListRequest(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox.shrink();
            // return const CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const SizedBox.shrink();
            } else if (snapshot.hasData) {
              List<FeedPreviewModel> loadPostList = snapshot.data ?? [];
              context.read<MyPageProvider>().setPostList(loadPostList, false);
    
              return Consumer<MyPageProvider>(
                builder: (context, data, child) {
                  if (data.postList!.isNotEmpty) {
    
                    return GridView.builder(
                      padding: EdgeInsets.fromLTRB(20.0.w, 16.0.h, 20.0.w, 80.0.h),
                      // controller: _scrollController,
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: (MediaQuery.of(context).size.width) / 2,
                        childAspectRatio: 0.7 / 1,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: data.postList!.length,
                      itemBuilder: (context, index) {
                        FeedPreviewModel post = data.postList![index];
                        return FeedPostGridCard(id: post.id!, imageUrl: post.thumbnailUrl ?? '', title: post.title ?? '', like: true);
                      },
                    );
                  } else {
                    return Container(
                      child: Center(child: Text('아직 게시글이 없습니다', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey50099, fontWeight: FontWeight.w400)))
                    );
                  }
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          } else {
            return const SizedBox.shrink();
          }        
        }, 
      ),
    );
    
  }
}