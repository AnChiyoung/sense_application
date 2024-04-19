import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sense_flutter_application/apis/post/post_api.dart';
import 'package:sense_flutter_application/screens/layouts/post_page_layout.dart';
import 'package:sense_flutter_application/screens/single_post_screen/partials/comment_section.dart';
import 'package:sense_flutter_application/screens/single_post_screen/partials/content_body.dart';
import 'package:sense_flutter_application/screens/single_post_screen/partials/content_header.dart';
import 'package:sense_flutter_application/screens/single_post_screen/partials/notice.dart';
import 'package:sense_flutter_application/screens/single_post_screen/partials/post_thumbnail.dart';
import 'package:sense_flutter_application/screens/single_post_screen/partials/related_post.dart';
import 'package:sense_flutter_application/screens/single_post_screen/partials/store_products.dart';
import 'package:sense_flutter_application/screens/single_post_screen/partials/tags.dart';
import 'package:sense_flutter_application/screens/widgets/common/TextIcon.dart';
import 'package:sense_flutter_application/store/providers/Post/single_post_collection_provider.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';

class SinglePostScreen extends StatefulWidget {
  final int id;

  const SinglePostScreen({super.key, required this.id});
  @override
  State<SinglePostScreen> createState() => _SinglePostScreenState();
}

class _SinglePostScreenState extends State<SinglePostScreen> with WidgetsBindingObserver {
  Future<Map<String, dynamic>> getPost(String id) async {
    return await PostApi().getPost(id);
  }

  final commentCountProvider = StateProvider<int>((ref) {
    return 0;
  });
  final likeCountProvider = StateProvider<int>((ref) => 0);
  ScrollController scrollController = ScrollController();
  bool isSticky = false;

  void scrollListener() {
    // if (scrollController.offset > 300) {
    //   setState(() {
    //     isSticky = true;
    //   });
    // } else {
    //   setState(() {
    //     isSticky = false;
    //   });
    // }
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Pretendard',
        colorScheme: ColorScheme.light(
          primary: primaryColor[50] ?? Colors.white,
          secondary: secondary1Color[50] ?? Colors.white,
          onPrimary: primaryColor[50] ?? Colors.white,
        ),
      ),
      home: Consumer(
        builder: ((context, ref, child) {
          final fetcher = ref.watch(postFutureProvider(widget.id.toString()));
          final post = ref.watch(singlePostProvider);
          final isPostLoading = ref.watch(postLoadingProvider);
          Future.delayed(const Duration(milliseconds: 800), () {
            if (mounted) {
              ref.read(postLoadingProvider.notifier).state = false;
            }
          });

          if (fetcher.isLoading || post.isEmpty || isPostLoading) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor[50] ?? Colors.white),
                  ),
                ),
              ),
            );
          }

          List<dynamic> tagDynamics = post['data']['tags'];
          List<String> tags = tagDynamics.map((e) => e['title'] as String).toList();
          final int commentsCount = post['data']['comment_count'] as int;
          final int likesCount = post['data']['like_count'] as int;

          return PostPageLayout(
            title: post['data']['title'].replaceAll('\n', ' '),
            body: RefreshIndicator(
                onRefresh: () async {
                  //
                },
                child: SingleChildScrollView(
                    controller: scrollController,
                    padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PostThumbnail(
                          imageUrl: post['data']['thumbnail_media_url'],
                          title: post['data']['title'],
                          subTitle: post['data']['sub_title'],
                          date: DateTime.parse(post['data']['created'])
                              .toString()
                              .substring(0, 10)
                              .replaceAll('-', '.'),
                          likeCount: post['data']['like_count'].toString(),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ContentHeader(
                                title: post['data']['content_title'] ?? '',
                                startDate: post['data']['start_date'],
                                endDate: post['data']['end_date'],
                              ),
                              ContentBody(body: post['data']['content'] ?? []),
                              StoreProducts(
                                  storeProducts: post['data']['store_products'],
                                  likedProduct: (int productId, bool value) {
                                    if (value) {
                                      ref.read(singlePostProvider.notifier).likeProduct(productId);
                                    } else {
                                      ref
                                          .read(singlePostProvider.notifier)
                                          .dislikeProduct(productId);
                                    }
                                  }),
                              const SizedBox(height: 40),
                              const Notice(
                                bulletList: [
                                  '로그인 상태에서 구매를 진행하셔야 구매가 가능합니다.',
                                  '기한 내 사용하지 않은 이용권은 자동 소멸됩니다',
                                  '본 이벤트는 당사 사정에 따라 사전예고 없이 변경 되거나 취소 될 수 있습니다.'
                                ],
                              ),
                              const SizedBox(height: 40),
                              Tags(tags: tags),
                              const SizedBox(height: 40),
                              CommentSection(postId: post['data']['id'] as int),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        RelatedPost(
                            relatedPosts: post['data']['related_posts'] ?? [],
                            onNavigate: () {
                              ref.read(postNavigationHistoryProvider.notifier).state = [
                                ...ref.watch(postNavigationHistoryProvider.notifier).state,
                                '${widget.id}'
                              ];
                            }),
                      ],
                    ))),
            bottomNavigationBar: SafeArea(
                child: Container(
              height: 56,
              decoration: const BoxDecoration(
                  border: Border(top: BorderSide(width: 1, color: Color(0xFFE0E0E0)))),
              padding: const EdgeInsets.only(left: 12, top: 14, bottom: 14, right: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextIcon(
                    iconSize: 20,
                    iconPath: 'lib/assets/images/icons/svg/chat.svg',
                    text: '$commentsCount',
                    spacing: 4,
                    textStyle: const TextStyle(
                        color: Color(0xFF555555),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Pretendard'),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          ref.read(singlePostProvider.notifier).likeApost(
                                widget.id.toString(),
                              );
                          PostApi().likeApost(widget.id.toString(),
                              !post['data']['is_liked'] ? LikeStatus.like : LikeStatus.unlike);
                        },
                        child: TextIcon(
                          iconSize: 20,
                          iconPath: post['data']['is_liked'] ?? false
                              ? 'lib/assets/images/icons/svg/heart_fill.svg'
                              : 'lib/assets/images/icons/svg/heart.svg',
                          text: '$likesCount',
                          iconColor: post['data']['is_liked'] ?? false
                              ? const Color(0xFFF23B3B)
                              : const Color(0xFF555555),
                          spacing: 4,
                          textStyle: const TextStyle(
                              color: Color(0xFF555555),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Pretendard'),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      InkWell(
                        onTap: () => {},
                        child: SvgPicture.asset(
                          'lib/assets/images/icons/svg/share.svg',
                          width: 20,
                          height: 20,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )),
            floating: isSticky
                ? FloatingActionButton(
                    onPressed: () {
                      scrollController.animateTo(0,
                          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                    },
                    backgroundColor: const Color(0xFFEEEEEE),
                    shape: const CircleBorder(),
                    elevation: 0,
                    child: SvgPicture.asset('lib/assets/images/icons/svg/caret_up.svg',
                        width: 24, height: 24),
                  )
                : null,
          );
        }),
      ),
    );
  }
}
