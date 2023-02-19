import 'package:flutter/material.dart';
import 'package:sense_flutter_application/models/feed/feed_home_model.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  // bool _isOpen = true;
  final String username = '김지안';
  late Future<List<FeedTagModel>> feedTags;
  late int selectedTagId;
  late Future<List<FeedProductModel>> feedProducts;
  var isFeedTagsLoaded = false;

  @override
  void initState() {
    super.initState();
    feedTags = ApiService.getRecommendTags().then((value) {
      final tagId = value[0].id;
      feedProducts = ApiService.getRecommendProductsByTagId(tagId);
      setState(() {
        selectedTagId = tagId;
        isFeedTagsLoaded = true;
      });
      return value;
    });
  }

  // void _close() {
  //   setState(() {
  //     _isOpen = false;
  //   });
  // }

  void onPressTag(tagId) {
    setState(() {
      // print(tagId);
      selectedTagId = tagId;
      feedProducts = ApiService.getRecommendProductsByTagId(tagId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppBar(
            toolbarHeight: 60,
            elevation: 1,
            backgroundColor: Colors.white,
            // titleTextStyle: const TextStyle(color: Colors.lightBlue),
            // title: const Text('Hello'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search_outlined,
                  color: Colors.black54,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_none_rounded,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          // if (_isOpen) EventRemainingDays(close: _close),
          // Container(
          //   margin: const EdgeInsets.only(
          //     left: 20,
          //     right: 20,
          //     top: 20,
          //   ),
          //   child: Row(
          //     children: const [
          //       ExpandedOutlinedButton(
          //         icon: Icons.calendar_today_outlined,
          //         text: '예약하기',
          //       ),
          //       SizedBox(
          //         width: 10,
          //       ),
          //       ExpandedOutlinedButton(
          //         icon: Icons.card_giftcard,
          //         text: '선물하기',
          //       ),
          //     ],
          //   ),
          // ),
          // const SizedBox(
          //   height: 40,
          // ),
          // // Text('$username 님만을 위한\n오늘의 센스')
          // Padding(
          //   padding: const EdgeInsets.symmetric(
          //     horizontal: 20,
          //   ),
          //   child: RichText(
          //     text: TextSpan(
          //       children: <TextSpan>[
          //         TextSpan(
          //           text: username,
          //           style: const TextStyle(
          //             fontWeight: FontWeight.w700,
          //             color: Colors.black,
          //             fontSize: 20,
          //             height: 1.4,
          //           ),
          //         ),
          //         const TextSpan(
          //           text: '님만을 위한\n오늘의 센스',
          //           style: TextStyle(
          //             fontWeight: FontWeight.w700,
          //             color: Colors.black,
          //             fontSize: 20,
          //             height: 1.4,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          Padding(
            padding: const EdgeInsets.only(
              top: 16,
            ),
            child: SizedBox(
              height: 30,
              child: FutureBuilder(
                future: feedTags,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final tagId = snapshot.data![index].id;
                        return Material(
                          borderRadius: BorderRadius.circular(16),
                          color: selectedTagId == tagId
                              ? Colors.grey.shade800
                              : Colors.grey.shade200,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              onPressTag(tagId);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              child: Center(
                                child: Text(
                                  snapshot.data![index].title,
                                  style: TextStyle(
                                    color: selectedTagId == tagId
                                        ? Colors.white
                                        : Colors.grey.shade700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(width: 4);
                      },
                    );
                  }
                  return const Text("...");
                },
              ),
            ),
          ),
          if (isFeedTagsLoaded)
            SizedBox(
              height: 600,
              child: FutureBuilder(
                future: feedProducts,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final feedProducts = snapshot.data!;
                    List<Widget> widgets = [];
                    for (var feedProduct in feedProducts) {
                      widgets.add(FeedProductCard(
                        id: feedProduct.id,
                        title: feedProduct.title,
                        imageUrl: feedProduct.imageUrl,
                      ));
                    }
                    return StackedCardCarousel(
                      items: widgets,
                      type: StackedCardCarouselType.fadeOutStack,
                      initialOffset: 100,
                      spaceBetweenItems: 300,
                    );
                  }
                  return Container();
                },
              ),
            ),
        ],
      ),
    );
  }
}

class EventRemainingDays extends StatelessWidget {
  final VoidCallback close;

  const EventRemainingDays({
    super.key,
    required this.close,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
      ),
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 241, 245, 255),
      ),
      padding: const EdgeInsets.only(
        left: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Text(
                'D-5',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 7,
              ),
              Text(
                '이재이',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('님 생일이에요!'),
            ],
          ),
          Material(
            color: const Color.fromARGB(255, 241, 245, 255),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: IconButton(
              onPressed: close,
              splashRadius: 22,
              iconSize: 22,
              icon: const Icon(
                Icons.close,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExpandedOutlinedButton extends StatelessWidget {
  final IconData icon;
  final String text;

  const ExpandedOutlinedButton({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          minimumSize: const Size(
            60,
            44,
          ),
        ),
        onPressed: () {},
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: Colors.black,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              text,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeedProductCard extends StatelessWidget {
  final int id;
  final String imageUrl;
  final String title;

  const FeedProductCard(
      {super.key,
        required this.id,
        required this.imageUrl,
        required this.title});

  @override
  Widget build(BuildContext context) {
    double halfScreenHeight = MediaQuery.of(context).size.height / 2;
    return Stack(
      children: [
        Container(
          // decoration: BoxDecoration(
          //   bor
          // ),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            height: halfScreenHeight,
          ),
        ),
      ],
    );
  }
}

// class FeedProductsSwiper extends StatefulWidget {
//   final List<Widget> feedProductWidgets;
//   const FeedProductsSwiper({super.key, required this.feedProductWidgets});

//   @override
//   State<FeedProductsSwiper> createState() => _FeedProductsSwiperState();
// }

// class _FeedProductsSwiperState extends State<FeedProductsSwiper> {
//   final pageController = PageController();
//   double _pageValue = 0.0;

//   @override
//   Widget build(BuildContext context) {
//     // pageController의 page와 _pageValue 값 맞추기
//     pageController.addListener(() {
//       if (mounted) {
//         setState(() {
//           _pageValue = pageController.page!;
//         });
//       }
//     });

//     // return PageView.builder(
//     //   scrollDirection: Axis.vertical,
//     //   itemCount: widget.feedProducts.length,
//     //   controller: pageController,
//     //   onPageChanged: ,
//     //   itemBuilder: (context, index) {
//     //     return null;
//     //   },
//     // );

//     return ClickThroughStack(
//       children: <Widget>[
//         _stackedCards(context),
//         PageView.builder(
//           scrollDirection: Axis.vertical,
//           controller: pageController,
//           itemCount: widget.feedProductWidgets.length,
//           // onPageChanged: () {},
//           itemBuilder: (BuildContext context, int index) {
//             return Container();
//           },
//         ),
//       ],
//     );
//   }

//   Widget _stackedCards(BuildContext context) {
//     const spaceBetweenItems = 100.0;
//     const initialOffset = 60.0;
//     final List<Widget> positionedCards =
//         widget.feedProductWidgets.asMap().entries.map(
//       (MapEntry<int, Widget> item) {
//         double position = -initialOffset;
//         if (_pageValue < item.key) {
//           position += (_pageValue - item.key) * spaceBetweenItems;
//         }
//         double opacity = 1.0;
//         double scale = 1.0;
//         if (item.key - _pageValue < 0) {
//           final double factor = 1 + (item.key - _pageValue);
//           opacity = factor < 0.0 ? 0.0 : pow(factor, 1.5).toDouble();
//           scale = factor < 0.0 ? 0.0 : pow(factor, 0.1).toDouble();
//         }
//         return Positioned.fill(
//           top: -position,
//           child: Align(
//             alignment: Alignment.topCenter,
//             child: Wrap(
//               children: <Widget>[
//                 Transform.scale(
//                   scale: scale,
//                   child: Opacity(
//                     opacity: opacity,
//                     child: item.value,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     ).toList();

//     return Stack(
//       alignment: Alignment.center,
//       fit: StackFit.passthrough,
//       children: positionedCards,
//     );
//   }
// }

// class ClickThroughStack extends Stack {
//   ClickThroughStack({super.key, required List<Widget> children})
//       : super(children: children);

//   @override
//   ClickThroughRenderStack createRenderObject(BuildContext context) {
//     return ClickThroughRenderStack(
//       alignment: alignment,
//       textDirection: textDirection ?? Directionality.of(context),
//       fit: fit,
//     );
//   }
// }

// class ClickThroughRenderStack extends RenderStack {
//   ClickThroughRenderStack({
//     required AlignmentGeometry alignment,
//     TextDirection? textDirection,
//     required StackFit fit,
//   }) : super(
//           alignment: alignment,
//           textDirection: textDirection,
//           fit: fit,
//         );

//   @override
//   bool hitTestChildren(BoxHitTestResult result, {Offset? position}) {
//     bool stackHit = false;

//     final List<RenderBox> children = getChildrenAsList();

//     for (final RenderBox child in children) {
//       final StackParentData childParentData =
//           child.parentData as StackParentData;

//       final bool childHit = result.addWithPaintOffset(
//         offset: childParentData.offset,
//         position: position!,
//         hitTest: (BoxHitTestResult result, Offset transformed) {
//           assert(transformed == position - childParentData.offset);
//           return child.hitTest(result, position: transformed);
//         },
//       );

//       if (childHit) {
//         stackHit = true;
//       }
//     }

//     return stackHit;
//   }
// }