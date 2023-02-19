import 'package:flutter/material.dart';
import 'package:sense_flutter_application/models/feed/feed_home_model.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final String username = '김지안';
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
          height: 20,
        ),
        if (isFeedTagsLoaded)
          Expanded(
            child: FutureBuilder(
              future: feedProducts,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final feedProducts = snapshot.data!;
                  List<Widget> ret = [];
                  List<Widget> widgets = [];
                  // 캐로셀일때
                  if (isCarousel) {
                    final spaceBetweenItems =
                        ((MediaQuery.of(context).size.width - 60) / 7 * 10) +
                            40;
                    for (var feedProduct in feedProducts) {
                      widgets.add(FeedProductCarouselCard(
                        id: feedProduct.id,
                        title: feedProduct.title,
                        imageUrl: feedProduct.imageUrl,
                      ));
                    }
                    for (var feedProduct in feedProducts) {
                      widgets.add(FeedProductCarouselCard(
                        id: feedProduct.id,
                        title: feedProduct.title,
                        imageUrl: feedProduct.imageUrl,
                      ));
                    }
                    ret.add(
                      StackedCardCarousel(
                        items: widgets,
                        type: StackedCardCarouselType.fadeOutStack,
                        initialOffset: 0,
                        spaceBetweenItems: spaceBetweenItems,
                      ),
                    );
                  } else {
                    // Grid layout 일때
                    for (var feedProduct in feedProducts) {
                      widgets.add(FeedProductGridCard(
                        id: feedProduct.id,
                        title: feedProduct.title,
                        imageUrl: feedProduct.imageUrl,
                      ));
                    }
                    for (var feedProduct in feedProducts) {
                      widgets.add(FeedProductGridCard(
                        id: feedProduct.id,
                        title: feedProduct.title,
                        imageUrl: feedProduct.imageUrl,
                      ));
                    }

                    double gridCardWidth =
                        (MediaQuery.of(context).size.width) / 2;
                    ret.add(
                      GridView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: gridCardWidth,
                          childAspectRatio: 0.7 / 1,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0,
                        ),
                        children: widgets,
                      ),
                    );
                  }

                  return Stack(
                    children: [
                      ...ret,
                      Positioned(
                        bottom: 20,
                        right: 20,
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
                              onPressed: () {
                                switchViewMode();
                              },
                              icon: const Icon(
                                Icons.add,
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

class FeedProductCarouselCard extends StatelessWidget {
  final int id;
  final String imageUrl;
  final String title;

  const FeedProductCarouselCard(
      {super.key,
        required this.id,
        required this.imageUrl,
        required this.title});

  @override
  Widget build(BuildContext context) {
    // double halfScreenHeight = MediaQuery.of(context).size.height * 0.6;
    double halfScreenWidth = MediaQuery.of(context).size.width - 60;
    return Stack(
      children: [
        Container(
          width: halfScreenWidth,
          // height: halfScreenHeight,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                offset: const Offset(5, 5),
                color: Colors.black.withOpacity(0.4),
              ),
            ],
          ),
          child: AspectRatio(
            aspectRatio: 0.7,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              // width: halfScreenWidth,
              // height: halfScreenHeight,
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [Colors.black54, Colors.transparent],
              ),
            ),
          ),
        ),
        Positioned.fill(
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
        ),
      ],
    );
  }
}

class FeedProductGridCard extends StatelessWidget {
  final int id;
  final String imageUrl;
  final String title;

  const FeedProductGridCard(
      {super.key,
        required this.id,
        required this.imageUrl,
        required this.title});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          color: Colors.blue,
          elevation: 2,
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.all(4),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Container(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
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
        ),
        // Container(
        //   clipBehavior: Clip.hardEdge,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(20),
        //     boxShadow: [
        //       BoxShadow(
        //         blurRadius: 10,
        //         offset: const Offset(5, 5),
        //         color: Colors.black.withOpacity(0.4),
        //       ),
        //     ],
        //     // gradient: const LinearGradient(
        //     //   begin: Alignment.bottomCenter,
        //     //   end: Alignment.center,
        //     //   colors: [Colors.red, Colors.blue],
        //     // ),
        //   ),
        //   child: AspectRatio(
        //     aspectRatio: 0.7,
        //     child: Image.network(
        //       imageUrl,
        //       fit: BoxFit.cover,
        //       // width: halfScreenWidth,
        //       // height: halfScreenHeight,
        //     ),
        //   ),
        // ),
        // Positioned.fill(
        //   child: Container(
        //     clipBehavior: Clip.hardEdge,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(20),
        //       gradient: const LinearGradient(
        //         begin: Alignment.bottomCenter,
        //         end: Alignment.center,
        //         colors: [Colors.black54, Colors.transparent],
        //       ),
        //     ),
        //   ),
        // ),
        // Positioned.fill(
        //   top: halfScreenWidth,
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(
        //       horizontal: 20,
        //     ),
        //     child: Text(
        //       title,
        //       style: const TextStyle(
        //         fontSize: 30,
        //         fontWeight: FontWeight.w700,
        //         color: Colors.white,
        //       ),
        //       maxLines: 2,
        //       overflow: TextOverflow.ellipsis,
        //     ),
        //   ),
        // ),
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