import 'package:flutter/material.dart';
import 'package:sense_flutter_application/models/feed/feed_home_model.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late Future<List<FeedTagModel>> feedTags;
  late int selectedTagId;
  late Future<List<FeedProductModel>> feedProducts;
  bool isFeedTagsLoaded = false;
  bool isCarousel = true;

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

  void onPressTag(tagId) {
    setState(() {
      // print(tagId);
      selectedTagId = tagId;
      feedProducts = ApiService.getRecommendProductsByTagId(tagId);
    });
  }

  void switchViewMode() {
    setState(() {
      isCarousel = !isCarousel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // AppBar(
        //   toolbarHeight: 60,
        //   elevation: 1,
        //   backgroundColor: Colors.white,
        //   // titleTextStyle: const TextStyle(color: Colors.lightBlue),
        //   // title: const Text('Hello'),
        //   actions: [
        //     IconButton(
        //       onPressed: () {},
        //       icon: const Icon(
        //         Icons.search_outlined,
        //         color: Colors.black54,
        //       ),
        //     ),
        //     IconButton(
        //       onPressed: () {},
        //       icon: const Icon(
        //         Icons.notifications_none_rounded,
        //         color: Colors.black54,
        //       ),
        //     ),
        //   ],
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
        const SizedBox(
          height: 24,
        ),
        if (isFeedTagsLoaded)
          Expanded(
            child: FutureBuilder(
              future: feedProducts,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final feedProducts = snapshot.data!;
                  final temp = [
                    ...feedProducts,
                    ...feedProducts,
                    ...feedProducts
                  ];

                  List<Widget> items = [];
                  Widget feedProductsWidget;
                  // 캐로셀일때
                  if (isCarousel) {
                    final spaceBetweenItems =
                        ((MediaQuery.of(context).size.width - 60) / 7 * 10) +
                            40;
                    for (var feedProduct in temp) {
                      items.add(FeedProductCarouselCard(
                        id: feedProduct.id,
                        title: feedProduct.title,
                        imageUrl: feedProduct.imageUrl,
                      ));
                    }
                    feedProductsWidget = StackedCardCarousel(
                      items: items,
                      type: StackedCardCarouselType.fadeOutStack,
                      initialOffset: 0,
                      spaceBetweenItems: spaceBetweenItems,
                    );
                  } else {
                    // Grid layout 일때
                    for (var feedProduct in temp) {
                      items.add(FeedProductGridCard(
                        id: feedProduct.id,
                        title: feedProduct.title,
                        imageUrl: feedProduct.imageUrl,
                      ));
                    }

                    double gridCardWidth =
                        (MediaQuery.of(context).size.width) / 2;
                    feedProductsWidget = GridView(
                      // padding: const EdgeInsets.symmetric(
                      //   horizontal: 20,
                      // ),
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 80),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: gridCardWidth,
                        childAspectRatio: 0.7 / 1,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      children: items,
                    );
                  }

                  return Stack(
                    children: [
                      feedProductsWidget,
                      Positioned(
                        bottom: 20,
                        child: Container(
                          width: 50,
                          height: 50,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Material(
                            color: Colors.grey.shade900,
                            shadowColor: Colors.grey.shade100,
                            child: IconButton(
                              onPressed: switchViewMode,
                              icon: const Icon(
                                Icons.grid_view_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
      ],
    );
  }
}

abstract class _BaseProductCard extends StatelessWidget {
  final int id;
  final String imageUrl;
  final String title;

  const _BaseProductCard({
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
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                print('tab $id');
              },
            ),
          ),
        ),
      ],
    );
  }
}

class FeedProductCarouselCard extends _BaseProductCard {
  const FeedProductCarouselCard({
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
            blurRadius: 10,
            offset: const Offset(0, 4),
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

class FeedProductGridCard extends _BaseProductCard {
  const FeedProductGridCard({
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

// class FeedProductCarouselCard extends StatelessWidget {
//   final int id;
//   final String imageUrl;
//   final String title;

//   const FeedProductCarouselCard(
//       {super.key,
//       required this.id,
//       required this.imageUrl,
//       required this.title});

//   @override
//   Widget build(BuildContext context) {
//     // double halfScreenHeight = MediaQuery.of(context).size.height * 0.6;
//     double halfScreenWidth = MediaQuery.of(context).size.width - 60;
//     return Container(
//       width: halfScreenWidth,
//       clipBehavior: Clip.hardEdge,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//             color: Colors.black.withOpacity(0.4),
//           ),
//         ],
//       ),
//       child: Stack(
//         children: [
//           AspectRatio(
//             aspectRatio: 0.7, // 비율 대충 0.7 ..
//             child: Image.network(
//               imageUrl,
//               fit: BoxFit.cover,
//               // width: halfScreenWidth,
//               // height: halfScreenHeight,
//             ),
//           ),
//           Positioned.fill(
//             child: Container(
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.bottomCenter,
//                   end: Alignment.center,
//                   colors: [Colors.black54, Colors.transparent],
//                 ),
//               ),
//             ),
//           ),
//           Positioned.fill(
//             top: halfScreenWidth, // 포지션 대충 가로길이만큼..
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 20,
//               ),
//               child: Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 30,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.white,
//                 ),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ),
//           Positioned.fill(
//             child: Material(
//               color: Colors.transparent,
//               child: InkWell(
//                 onTap: () {
//                   print('tab $id');
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class FeedProductGridCard extends StatelessWidget {
//   final int id;
//   final String imageUrl;
//   final String title;

//   const FeedProductGridCard(
//       {super.key,
//       required this.id,
//       required this.imageUrl,
//       required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       clipBehavior: Clip.hardEdge,
//       width: double.infinity,
//       height: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//             color: Colors.black.withOpacity(0.2),
//           ),
//         ],
//       ),
//       child: Stack(
//         children: [
//           Image.network(
//             imageUrl,
//             fit: BoxFit.cover,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 12,
//             ),
//             decoration: const BoxDecoration(
//               color: Colors.black12,
//             ),
//             child: Center(
//               child: Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.white,
//                 ),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ),
//           Positioned.fill(
//             child: Material(
//               color: Colors.transparent,
//               child: InkWell(
//                 onTap: () {
//                   print('tab $id');
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


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