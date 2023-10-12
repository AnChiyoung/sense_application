import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/feed/feed_detail_model.dart';
import 'package:sense_flutter_application/models/feed/feed_model.dart';
import 'package:sense_flutter_application/public_widget/icon_ripple_button.dart';
import 'package:sense_flutter_application/public_widget/service_guide_dialog.dart';
import 'package:sense_flutter_application/public_widget/show_loading.dart';
import 'package:sense_flutter_application/views/feed/feed_comment_view.dart';
import 'package:sense_flutter_application/views/feed/feed_flexible.dart';
import 'package:sense_flutter_application/views/feed/feed_provider.dart';
import 'package:sense_flutter_application/views/feed_improve/feed_bottom_field.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FeedPostDetail extends StatefulWidget {
  final int postId;
  const FeedPostDetail({Key? key, required this.postId}) : super(key: key);

  @override
  State<FeedPostDetail> createState() => _FeedPostDetailState();
}

class _FeedPostDetailState extends State<FeedPostDetail> {
  late Future<FeedPostDetailModel> postDetail;
  Future? activeFuture;
  FeedDetailModel? model;

  /// 댓글 때문에 재로드 되는 경우를 방지하기 위함
  Future<FeedDetailModel> fetchData() async {
    return await FeedContentModel().feedDetailLoad(widget.postId);
  }

  @override
  void initState() {
    activeFuture = fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    print('get post id : ${widget.postId.toString()}');

    final safeAreaTopPadding = MediaQuery.of(context).padding.top;
    final safeAreaBottomPadding = MediaQuery.of(context).padding.bottom;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: FutureBuilder(
            future: activeFuture,
            builder: (context, snapshot) {
              if(snapshot.hasError) {
                return const SizedBox.shrink();
              } else if(snapshot.hasData) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if(snapshot.connectionState == ConnectionState.done) {

                  FeedDetailModel feedDetailModel = snapshot.data!;
                  return PostDetail(postModel: feedDetailModel, topPadding: safeAreaTopPadding, bottomPadding: safeAreaBottomPadding);

                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              } else {
                // return const Center(child: Text('data loading..'));
                return const Center(child: CircularProgressIndicator());
              }
            }
          )
        )
      ),
    );
  }
}

class PostDetail extends StatefulWidget {
  FeedDetailModel? postModel;
  double? topPadding;
  double? bottomPadding;
  PostDetail({Key? key, this.postModel, this.topPadding, this.bottomPadding}) : super(key: key);

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {

  FeedDetailModel? model;
  List<Widget> contentsWidget = [];
  List<Widget> tagsWidget = [];
  Widget detailWidget = const SizedBox.shrink();
  String? created;

  bool stringToBoolean(String value) {
    bool convertResult = false;
    if(value.toLowerCase() == 'true') {
      convertResult = true;
    } else if(value.toLowerCase() == 'false') {
      convertResult = false;
    }
    return convertResult;
  }

  void makeContentsWidget(FeedDetailModel model) {
    // model.content!.map((e) {
    //   if(e.type == 'TEXT') {
    //     // contentsWidget.add(ContentTextTypeParagraph(text: e.contentUrl.toString()));
    //     contentsWidget.add(ContentTextTypeParagraph(text: ''.toString()));
    //   } else if(e.type == 'IMAGE') {
    //     // contentsWidget.add(ContentImageTypeParagraph(imageUrl: e.contentUrl.toString()));
    //     // contentsWidget.add(ContentImageTypeParagraph(imageUrl: ''.toString()));
    //     contentsWidget.add(Container());
    //   } else if(e.type == 'URL') {
    //     // contentsWidget.add(ContentURLTypeParagraph(text: e.contentUrl.toString()));
    //     contentsWidget.add(ContentTextTypeParagraph(text: ''.toString()));
    //   }
    // }).toList();
  }

  @override
  void initState() {
    model = widget.postModel;
    // makeContentsWidget(model!);
    List<String> tags = [];
    for(var e in model!.tags!) {
      tags.add(e.title!);
    }
    makeLabels(tags);
    if(model!.createdTime == null) {
      created = '';
    } else {
      created = '작성일 ${model!.createdTime!.toString().substring(0, 10).replaceAll('-', '.')}';
    }
    // contentEncoding(model!.content.toString());

    if(model!.id == 22) {
      detailWidget = const FeedFlexibleID22();
    } else if(model!.id == 21) {
      detailWidget = const FeedFlexibleID21();
    } else if(model!.id == 20) {
      detailWidget = const FeedFlexibleID20();
    } else if(model!.id == 19) {
      detailWidget = const FeedFlexibleID19();
    } else if(model!.id == 18) {
      detailWidget = const FeedFlexibleID18();
    } else if(model!.id == 17) {
      detailWidget = const FeedFlexibleID17();
    } else if(model!.id == 16) {
      detailWidget = const FeedFlexibleID16();
    } else if(model!.id == 15) {
      detailWidget = const FeedFlexibleID15();
    } else if(model!.id == 14) {
      detailWidget = const FeedFlexibleID14();
    } else if(model!.id == 13) {
      detailWidget = const FeedFlexibleID13();
    } else if(model!.id == 12) {
      detailWidget = const FeedFlexibleID12();
    } else if(model!.id == 11) {
      detailWidget = const FeedFlexibleID11();
    } else if(model!.id == 10) {
      detailWidget = const FeedFlexibleID10();
    } else if(model!.id == 9) {
      detailWidget = const FeedFlexibleID09();
    } else if(model!.id == 8) {
      detailWidget = const FeedFlexibleID08();
    } else if(model!.id == 7) {
      detailWidget = const FeedFlexibleID07();
    } else if(model!.id == 6) {
      detailWidget = const FeedFlexibleID06();
    }

    super.initState();
  }

  void makeLabels(List<String> labels) {
    for(var e in labels) {
      tagsWidget.add(tagWidgets(e));
    }
  }

  void contentEncoding(String jsonString) {
    Map<String,dynamic> jsonData = jsonDecode(jsonString);
    print(jsonData);
  }

  Widget tagWidgets(String labelName) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 4.0.h),
          decoration: BoxDecoration(
            color: StaticColor.grey100F6,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Center(
            child: Text('#$labelName', style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey60077, fontWeight: FontWeight.w600)),
          )
        ),
        SizedBox(width: 4.0.w),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    /// 디테일 화면 구성 변경 2023 06 23
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<FeedProvider>(
                  builder: (context, data, child) {
                    int likeCount = 0;
                    if(data.commentCount == -1) {
                      likeCount = model!.likeCount!;
                    } else if(data.commentCount != -1) {
                      likeCount = data.likeCount;
                    }
                    return PostDetailBanner(
                        imageUrl: model!.thumbnail!,
                        title: model!.title!,
                        desc: model!.subTitle!,
                        // created: model!.createdTime!.substring(0, 10).replaceAll('-', '.'),
                        startDate: model!.startDate!,
                        endDate: model!.endDate!,
                        likeCount: likeCount.toString(),
                        isLiked: model!.isLiked!
                    );
                  }
              ),
              model!.contentTitle == '' ? const SizedBox.shrink()
                  : PostDetailTitle(
                title: model!.contentTitle!,
                eventPeriodLabel: '',
                eventPeriod: '',),
              model!.content!.isEmpty ? const SizedBox.shrink()
                  : Column(
                      // children: contentsWidget
                      children: [
                        // Text(model!.content.toString()),
                      ]
                    ),
              SizedBox(height: 16.0.h),
              detailWidget,
              Padding(
                padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 36.0.h),
                child: Wrap(
                  runSpacing: 8.0,
                  children: tagsWidget,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 20.0.h),
                child: Text(created!, style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
              ),
              const SizedBox(height: 80.0),
              // ContentTextTypeParagraph(text: model.contents!.elementAt(0).contentUrl.toString()),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 38.0, left: 20.0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(25.0),
              onTap: () {
                context.read<FeedProvider>().feedInfoInit();
                Navigator.of(context).pop();
              },
              child: Image.asset('assets/feed/back_button.png', width: 40, height: 40),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: FeedBottomField(feedModel: model, bottomPadding: widget.bottomPadding),
        ),
      ],
    );

    /// old version
    // return Stack(
    //   children: [
    //     /// post area
    //     SingleChildScrollView(
    //       physics: const ClampingScrollPhysics(),
    //       child: Expanded(
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             Consumer<FeedProvider>(
    //               builder: (context, data, child) {
    //                 int likeCount = 0;
    //                 if(data.commentCount == -1) {
    //                   likeCount = model!.likeCount!;
    //                 } else if(data.commentCount != -1) {
    //                   likeCount = data.likeCount;
    //                 }
    //                 return PostDetailBanner(
    //                     imageUrl: model!.thumbnail!,
    //                     title: model!.title!,
    //                     desc: model!.subTitle!,
    //                     created: model!.createdTime!.substring(0, 10).replaceAll('-', '.'),
    //                     likeCount: likeCount.toString(),
    //                     isLiked: model!.isLiked!
    //                 );
    //               }
    //             ),
    //             model!.contentTitle == '' ? const SizedBox.shrink()
    //             : PostDetailTitle(
    //               title: model!.contentTitle!,
    //               eventPeriodLabel: '',
    //               eventPeriod: '',),
    //             model!.content!.isEmpty ? const SizedBox.shrink()
    //             : ListView.builder(
    //                 shrinkWrap: true,
    //                 physics: const ClampingScrollPhysics(),
    //                 itemCount: model!.content!.length,
    //                 itemBuilder: (context, index) {
    //                   if(model!.content!.elementAt(index).type == 'TEXT') {
    //                     return ContentTextTypeParagraph(text: model!.content!.elementAt(index).contentUrl.toString());
    //                   } else if(model!.content!.elementAt(index).type == 'IMAGE') {
    //                     return ContentImageTypeParagraph(imageUrl: model!.content!.elementAt(index).contentUrl.toString());
    //                   } else if(model!.content!.elementAt(index).type == 'URL') {
    //                     return ContentURLTypeParagraph(text: model!.content!.elementAt(index).contentUrl.toString());
    //                   }
    //                 }
    //             ),
    //             const SizedBox(height: 80.0),
    //             // ContentTextTypeParagraph(text: model.contents!.elementAt(0).contentUrl.toString()),
    //           ],
    //         ),
    //       ),
    //     ),
    //     /// back button area
    //     Padding(
    //       padding: const EdgeInsets.only(top: 38.0, left: 20.0),
    //       child: Material(
    //         color: Colors.transparent,
    //         child: InkWell(
    //           borderRadius: BorderRadius.circular(25.0),
    //           onTap: () {
    //             // context.read<FeedProvider>().feedBottomFieldInitialize();
    //             // context.read<FeedProvider>().feedCommentCountUpdate(-1);
    //             context.read<FeedProvider>().feedInfoInit();
    //             Navigator.of(context).pop();
    //           },
    //           child: Image.asset('assets/feed/back_button.png', width: 40, height: 40),
    //         ),
    //       ),
    //     ),
    //     /// comment area
    //     Align(
    //       alignment: Alignment.bottomCenter,
    //       child: FeedBottomField(feedModel: model, bottomPadding: widget.bottomPadding),
    //     )
    //   ],
    // );
  }


}

class ContentTextTypeParagraph extends StatelessWidget {
  String text;
  ContentTextTypeParagraph({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    const lineHeight = 26.0 / 16.0;

    return Padding(
      padding: const EdgeInsets.only(top: 24.0, left: 20.0, right: 20.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16, color: StaticColor.grey80033, fontWeight: FontWeight.w400, height: lineHeight,
        )
      ),
    );
  }
}

class ContentImageTypeParagraph extends StatelessWidget {
  String imageUrl;
  ContentImageTypeParagraph({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 20.0, right: 20.0),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
        ),
      ),
    );
  }
}

class ContentURLTypeParagraph extends StatelessWidget {
  String text;
  ContentURLTypeParagraph({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    const lineHeight = 26.0 / 16.0;

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: GestureDetector(
        onTap: () async {_launchUrl(text);},
        child: Text(
          '위 상품 보러가기',
          // text,
          style: TextStyle(
            fontSize: 16, color: StaticColor.mainSoft, fontWeight: FontWeight.w400, height: lineHeight,
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch ${Uri.parse(url)}');
    }
  }
}

/// original class
class Notice extends StatelessWidget {
  const Notice({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> notices = [
      '로그인 상태에서 구매를 진행하셔야 구매가 가능합니다.',
      '기한 내 사용하지 않은 이용권은 자동 소멸됩니다.',
      '본 이벤트는 당사 사정에 따라 사전예고 없이 변경 되거나 취소 될 수 있습니다.',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: const Color(0xFFEEEEEE),
          height: 8,
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 24, 20, 4),
          child: Text(
            '유의사항',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF555555),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: notices
                .map(
                  (noticeText) => Text(
                    '  •  $noticeText',
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF777777),
                    ),
                  ),
                )
                .toList(),
          ),
        )
      ],
    );
  }
}

class RelatedPostItem extends StatelessWidget {
  final FeedRelatedPostThumbnailModel post;

  const RelatedPostItem({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          // onTap: () {  },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 20,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    post.imageUrl,
                    width: 86,
                    height: 86,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 14, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          post.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF333333),
                          ),
                        ),
                        Text(
                          post.storeName,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF777777),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEEEEE),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 5,
                        ),
                        child: Text(
                          '보기',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF555555),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RelatedPosts extends StatefulWidget {
  const RelatedPosts({
    super.key,
  });

  @override
  State<RelatedPosts> createState() => _RelatedPostsState();
}

class _RelatedPostsState extends State<RelatedPosts> {
  List<FeedRelatedPostThumbnailModel> relatedPosts = [];

  @override
  void initState() {
    final post1 = FeedRelatedPostThumbnailModel(
      title: '북유럽풍 카페 여기에 다 있다',
      storeName: '홍대,이태원 근처 이색카페 모음',
      imageUrl: 'https://picsum.photos/id/25/400',
    );
    final post2 = FeedRelatedPostThumbnailModel(
      title: '철이 없었죠..이런 커피를 좋아하게 될줄은..',
      storeName: '에티오피아 유학파 사장님의 카페',
      imageUrl: 'https://picsum.photos/id/171/400',
    );
    final post3 = FeedRelatedPostThumbnailModel(
      title: '카공족을 환영하는 카페? 판교 Elly’s카페로 오세요!',
      storeName: '소심한 극 ’i’ 사장님의 수줍은 배려',
      imageUrl: 'https://picsum.photos/id/147/400',
    );
    relatedPosts = [
      post1,
      post2,
      post3,
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: const Color(0xFFEEEEEE),
          height: 8,
        ),
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            '관련 게시글',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF151515)),
          ),
        ),
        Column(
          children: List.generate(
            relatedPosts.length * 2 - 1,
            (index) => index % 2 == 0
                ? RelatedPostItem(post: relatedPosts[index ~/ 2])
                : const Divider(
                    color: Color(0xFFEEEEEE),
                    thickness: 1,
                    height: 9,
                  ),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

class PostDetailTags extends StatelessWidget {
  const PostDetailTags({
    super.key,
    required this.tags,
  });

  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
        child: Wrap(
          spacing: 4,
          runSpacing: 8,
          children: tags
              .map(
                (tagItem) => Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        child: Text(
                          '#$tagItem',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF777777),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ));
  }
}

class FeedPostDetailStoreContent extends StatefulWidget {
  final FeedPostDetailStoreContentData content;

  const FeedPostDetailStoreContent({
    super.key,
    required this.content,
  });

  @override
  State<FeedPostDetailStoreContent> createState() => _FeedPostDetailStoreContentState();
}

class _FeedPostDetailStoreContentState extends State<FeedPostDetailStoreContent> {
  void toggleLike() {
    setState(() {
      widget.content.toggleLike();
    });
  }

  @override
  Widget build(BuildContext context) {
    final content = widget.content;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: SizedBox(
          height: 110,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 20,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    content.imageUrl,
                    width: 86,
                    height: 86,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 4, 8, 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          content.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF333333),
                          ),
                        ),
                        Text(
                          content.storeName,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF777777),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconRippleButton(
                        icon: content.isLiked
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        size: 24,
                        color: content.isLiked ? const Color(0xFF2288FF) : const Color(0xFFBBBBBB),
                        onPressed: toggleLike,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          content.price,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF777777),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PostDetailImageParagraph extends StatelessWidget {
  const PostDetailImageParagraph({
    super.key,
    required this.title,
    this.subtitle,
    required this.imageUrl,
    required this.desc,
    this.tmi,
  });

  final String title;
  final String? subtitle;
  final String imageUrl;
  final String desc;
  final String? tmi;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color(0xFF333333),
            ),
          ),
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                subtitle!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF555555),
                ),
              ),
            ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black45,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            desc,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 1.4,
              color: Color(0xFF555555),
            ),
          ),
          if (tmi != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  const Text(
                    'TMI',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF555555),
                    ),
                  ),
                  const SizedBox(width: 2),
                  Text(
                    tmi!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF555555),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class PostDetailTitleParagraph extends StatelessWidget {
  const PostDetailTitleParagraph({
    super.key,
    required this.title,
    required this.desc,
  });

  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            desc,
            style: const TextStyle(
              fontSize: 16,
              height: 1.4,
              fontWeight: FontWeight.w400,
              color: Color(0xFF555555),
            ),
          ),
        ],
      ),
    );
  }
}

class PostDetailParagraph extends StatelessWidget {
  const PostDetailParagraph({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          height: 1.4,
          fontWeight: FontWeight.w400,
          color: Color(0xFF555555),
        ),
      ),
    );
  }
}

class PostDetailTitle extends StatelessWidget {
  const PostDetailTitle({
    super.key,
    required this.title,
    required this.eventPeriodLabel,
    required this.eventPeriod,
  });

  final String title;
  final String eventPeriodLabel;
  final String eventPeriod;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0, left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF333333),
              )),
          eventPeriodLabel == '' ? const SizedBox.shrink() : const SizedBox(height: 32),
          eventPeriodLabel == '' ? const SizedBox.shrink() : Text(eventPeriodLabel,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF555555),
              )),
          eventPeriodLabel == '' ? const SizedBox.shrink() : const SizedBox(height: 4),
          eventPeriod == '' ? const SizedBox.shrink() : Text(
            eventPeriod,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF777777),
            ),
          ),
          const SizedBox(height: 24),
          Container(height: 1, color: StaticColor.grey200EE),
        ],
      ),
    );
  }
}

class PostDetailBackButton extends StatelessWidget {
  const PostDetailBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 40,
        left: 20,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.35),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LikeButton extends StatefulWidget {
  final bool isLiked;
  final int likeCount;
  final int feedId;

  const LikeButton({Key? key, required this.isLiked, required this.likeCount, required this.feedId}) : super(key: key);

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLiked = false;

  @override
  void initState() {
    isLiked = widget.isLiked;
    super.initState();
  }

  void toggleLike() async {
    setState(() {
      isLiked = !isLiked;
    });

    if(isLiked == true) {
      FeedDetailModel responseModel = await FeedRequest().postDetailLiked(widget.feedId);
      context.read<FeedProvider>().feedDetailModelInitialize(responseModel.isCommented, responseModel.commentCount, responseModel.isLiked, responseModel.likeCount);
    } else if(isLiked == false) {
      FeedDetailModel responseModel = await FeedRequest().postDetailUnliked(widget.feedId);
      context.read<FeedProvider>().feedDetailModelInitialize(responseModel.isCommented, responseModel.commentCount, responseModel.isLiked, responseModel.likeCount);
    }

  }

  @override
  Widget build(BuildContext context) {
    return IconRippleButton(
      icon: isLiked ? Icons.favorite : Icons.favorite_border,
      color: isLiked ? StaticColor.mainSoft : StaticColor.grey400BB,
      size: 26,
      padding: 8,
      onPressed: toggleLike,
    );
  }
}

class PostDetailBanner extends StatelessWidget {
  const PostDetailBanner({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.desc,
    required this.startDate,
    required this.endDate,
    required this.likeCount,
    required this.isLiked,
  });

  final String imageUrl;
  final String title;
  final String desc;
  final String startDate;
  final String endDate;
  final String likeCount;
  final bool isLiked;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 375 / 448,
          child: Image.network(
            imageUrl,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black45,
              );
            },
          ),
        ),
        // const PostDetailBackButton(),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: AspectRatio(
            aspectRatio: 375 / 308,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 24,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0),
                    Colors.black.withOpacity(0.6),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    desc,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${startDate.replaceAll('-', '.')}~${endDate.replaceAll('-', '.')}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 12,
                            color: Colors.white,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                          ),
                          const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            likeCount,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     LikeButton(isLiked: isLiked),
                      //     const SizedBox(width: 4),
                      //     IconRippleButton(
                      //       icon: Icons.share_rounded,
                      //       color: Colors.white,
                      //       size: 24,
                      //       padding: 8,
                      //       onPressed: () => {},
                      //     )
                      //   ],
                      // ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
