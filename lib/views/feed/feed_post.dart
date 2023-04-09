import 'package:flutter/material.dart';
import 'package:sense_flutter_application/models/feed/feed_model.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

abstract class _BasePostCard extends StatelessWidget {
  final int id;
  final String imageUrl;
  final String title;

  const _BasePostCard({
    Key? key,
    required this.id,
    required this.imageUrl,
    required this.title,
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
                debugPrint('tab $id');
              },
            ),
          ),
        ),
      ],
    );
  }
}

class FeedPostCarouselCard extends _BasePostCard {
  const FeedPostCarouselCard({
    Key? key,
    required int id,
    required String imageUrl,
    required String title,
  }) : super(key: key, id: id, imageUrl: imageUrl, title: title);

  @override
  Widget buildImage(BuildContext context) {
    double halfScreenWidth = MediaQuery.of(context).size.width - 60;
    return Container(
      width: halfScreenWidth,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            offset: const Offset(0, 8),
            color: Colors.black.withOpacity(0.4),
          ),
        ],
      ),
      child: AspectRatio(
        aspectRatio: 0.7,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget buildTitle(BuildContext context) {
    double halfScreenWidth = MediaQuery.of(context).size.width - 60;
    return Positioned.fill(
      top: halfScreenWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class FeedPostGridCard extends _BasePostCard {
  const FeedPostGridCard({
    Key? key,
    required int id,
    required String imageUrl,
    required String title,
  }) : super(key: key, id: id, imageUrl: imageUrl, title: title);

  @override
  Widget buildImage(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            offset: const Offset(0, 2),
            color: Colors.black.withOpacity(0.2),
          ),
        ],
      ),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  @override
  Widget buildTitle(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      decoration: const BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

///
///
/// 피드에서 포스트 리스트를 보여주는 위젯
class FeedPostListPresenter extends StatefulWidget {
  final List<FeedPostModel> feedPosts;
  const FeedPostListPresenter({Key? key, required this.feedPosts}) : super(key: key);

  @override
  State<FeedPostListPresenter> createState() => _FeedPostListPresenterState();
}

class _FeedPostListPresenterState extends State<FeedPostListPresenter> {
  // late final feedPosts = context.read<FeedProvider>().feedPosts;
  bool isCarousel = true;

  void toggleCarousel() {
    setState(() {
      isCarousel = !isCarousel;
    });
  }

  @override
  Widget build(BuildContext context) {
    final temp = [...widget.feedPosts, ...widget.feedPosts, ...widget.feedPosts];
    List<Widget> items = [];
    Widget feedPostsWidget;
    IconData switchButtonIcon;
    String switchButtonText;

    if (isCarousel) {
      final spaceBetweenItems = ((MediaQuery.of(context).size.width - 60) / 7 * 10) + 40;
      for (var feedPost in temp) {
        items.add(FeedPostCarouselCard(
          id: feedPost.id,
          title: feedPost.title,
          imageUrl: feedPost.imageUrl,
        ));
      }
      feedPostsWidget = StackedCardCarousel(
        items: items,
        type: StackedCardCarouselType.fadeOutStack,
        initialOffset: 0,
        spaceBetweenItems: spaceBetweenItems,
      );

      switchButtonIcon = Icons.grid_view_rounded;
      switchButtonText = '모아보기';
    } else {
      for (var feedPost in temp) {
        items.add(FeedPostGridCard(
          id: feedPost.id,
          title: feedPost.title,
          imageUrl: feedPost.imageUrl,
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
        Positioned(
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
        ),
      ],
    );
  }
}
