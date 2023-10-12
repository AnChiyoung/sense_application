import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage_2/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/feed/feed_model.dart';
import 'package:sense_flutter_application/public_widget/icon_ripple_button.dart';
import 'package:sense_flutter_application/views/feed/feed_post_detail_view.dart';
import 'package:sense_flutter_application/views/feed/feed_provider.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

abstract class _BasePostCard extends StatelessWidget { // 여기가 카드관련 기능, ui랑 분리가 되어있다.
  final int id;
  final String imageUrl;
  final String title;
  String? subTitle;
  final bool like;

  _BasePostCard({
    Key? key,
    required this.id,
    required this.imageUrl,
    required this.title,
    this.subTitle,
    required this.like
  }) : super(key: key);

  @protected
  Widget buildImage(BuildContext context);

  @protected
  Widget buildTitle(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildImage(context),
        buildTitle(context),
        Positioned.fill(
          left: 0,
          right: 0,
          child: Material(
            color: Colors.transparent,
            shadowColor: Colors.transparent,
            child: InkWell(
              onTap: () {
                /// post detail load, 포스트 상세 불러오기
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FeedPostDetail(postId: id),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class FeedPostCarouselCard extends _BasePostCard {
  FeedPostCarouselCard({
    Key? key,
    required int id,
    required String imageUrl,
    required String title,
    String? subTitle,
    required bool like,

  }) : super(key: key, id: id, imageUrl: imageUrl, title: title, subTitle: subTitle, like: like);

  @override
  Widget buildImage(BuildContext context) {
    double halfScreenWidth = MediaQuery.of(context).size.width - 60;
    return Container(
      width: halfScreenWidth,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black.withOpacity(0.1),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            offset: const Offset(0, 1),
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: AspectRatio(
        aspectRatio: 0.7,
        child: Opacity(
          opacity: 0.8,
          child: CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover))
      ),
    );
  }

  @override
  Widget buildTitle(BuildContext context) {
    double halfScreenWidth = MediaQuery.of(context).size.width - 60;
    return Positioned.fill(
      left: 20.0.w,
      bottom: 20.0.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 24.0.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: 16.0.h),
          Padding(
            padding: EdgeInsets.only(right: 5.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    subTitle!,
                    style: TextStyle(
                      fontSize: 14.0.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                like == true ? IconRippleButton(
                  icon: Icons.favorite,
                  color: Colors.red,
                  size: 26,
                  padding: 8,
                  onPressed: null,
                ) : IconRippleButton(
                  icon: Icons.favorite_border,
                  color: Colors.white,
                  size: 26,
                  padding: 8,
                  onPressed: null,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FeedPostGridCard extends _BasePostCard {
  FeedPostGridCard({
    Key? key,
    required int id,
    required String imageUrl,
    required String title,
    String? subTitle,
    required bool like,
  }) : super(key: key, id: id, imageUrl: imageUrl, title: title, subTitle: subTitle, like: like);

  @override
  Widget buildImage(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black.withOpacity(0.1),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            offset: const Offset(0, 1),
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: AspectRatio(
        aspectRatio: 0.7,
        child: CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover),
        // child: Image.network(
        //   imageUrl,
        //   loadingBuilder: (context, child, loadingProgress) {
        //     if(loadingProgress == null) {
        //       // return FastCachedImage(url: imageUrl, fit: BoxFit.fitHeight);
        //       return CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.fitHeight, );
        //     } else {
        //       return Container(
        //         padding: EdgeInsets.symmetric(horizontal: 35.0.w,),
        //         decoration: BoxDecoration(
        //           color: StaticColor.grey200EE,
        //           borderRadius: BorderRadius.circular(16.0),
        //         ),
        //         child: Image.asset('assets/public/loading_logo_image.png', width: 30.0.w,),
        //       );
        //     }
        //   },
        //   fit: BoxFit.cover,
        // ),
      ),
      // child: Image.network(
      //   imageUrl,
      //   fit: BoxFit.cover,
      //   width: double.infinity,
      //   height: double.infinity,
      // ),
    );
  }

  @override
  Widget buildTitle(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      decoration: const BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: 16.0.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16.0.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            // Text(
            //   subTitle!,
            //   style: const TextStyle(
            //     fontSize: 16,
            //     fontWeight: FontWeight.w400,
            //     color: Colors.white,
            //   ),
            //   maxLines: 2,
            //   overflow: TextOverflow.ellipsis,
            // ),
          ],
        ),
      ),
      // child: Center(
      //   child: Text(
      //     title,
      //     style: const TextStyle(
      //       fontSize: 16,
      //       fontWeight: FontWeight.w700,
      //       color: Colors.white,
      //     ),
      //     maxLines: 2,
      //     overflow: TextOverflow.ellipsis,
      //   ),
      // ),
    );
  }
}

/// 피드에서 포스트 리스트를 보여주는 위젯
class FeedPostListPresenter extends StatefulWidget {
  final List<FeedPreviewModel> feedPosts;
  const FeedPostListPresenter({Key? key, required this.feedPosts}) : super(key: key);

  @override
  State<FeedPostListPresenter> createState() => _FeedPostListPresenterState();
}

class _FeedPostListPresenterState extends State<FeedPostListPresenter> {
  // late final feedPosts = context.read<FeedProvider>().feedPosts;
  bool isCarousel = true;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void toggleCarousel() {
    setState(() {
      isCarousel = !isCarousel;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    Widget feedPostsWidget;
    IconData switchButtonIcon;
    String switchButtonText;

    if (isCarousel) {
      final spaceBetweenItems = ((MediaQuery.of(context).size.width - 60) / 7 * 10) + 40;
      for (var feedPost in widget.feedPosts) {
        items.add(FeedPostCarouselCard(
          id: feedPost.id!,
          title: feedPost.title!,
          subTitle: feedPost.subTitle!,
          imageUrl: feedPost.thumbnailUrl!,
          like: feedPost.isLiked ?? false,
        ));
      }
      feedPostsWidget = StackedCardCarousel(
        pageController: _pageController,
        items: items,
        type: StackedCardCarouselType.fadeOutStack,
        initialOffset: 0,
        spaceBetweenItems: spaceBetweenItems,
      );

      switchButtonIcon = Icons.grid_view_rounded;
      switchButtonText = '모아보기';
    } else {
      for (var feedPost in widget.feedPosts) {
        /// when imageUrl is empty, non add. 20230607
        feedPost.thumbnailUrl == '' ? {} : items.add(FeedPostGridCard(
          id: feedPost.id!,
          title: feedPost.title!,
          subTitle: feedPost.subTitle!,
          imageUrl: feedPost.thumbnailUrl!,
          like: feedPost.isLiked!,
        ));
      }

      double gridCardWidth = (MediaQuery.of(context).size.width) / 2;
      feedPostsWidget = GridView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 80),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: gridCardWidth,
          childAspectRatio: 0.7 / 1,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        children: items,
      );

      switchButtonIcon = Icons.view_agenda_rounded;
      switchButtonText = '크게보기';
    }

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: feedPostsWidget,
        ),
        Consumer<FeedProvider>(
          builder: (context, data, child) {

            bool buttonState = data.viewChangeButton;

            return buttonState == false ? const SizedBox.shrink()
            : Positioned(
              left: 0,
              right: 0,
              bottom: 16,
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: toggleCarousel,
                  icon: Icon(
                    switchButtonIcon,
                    size: 24,
                  ),
                  label: Text(switchButtonText),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF333333),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            );
          }
        ),
      ],
    );
  }
}
