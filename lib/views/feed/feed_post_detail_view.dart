import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/feed/comment_model.dart';
import 'package:sense_flutter_application/models/feed/feed_model.dart';
import 'package:sense_flutter_application/public_widget/icon_ripple_button.dart';
import 'package:sense_flutter_application/views/feed/feed_comment_view.dart';
import 'package:sense_flutter_application/views/feed/feed_provider.dart';

class FeedPostDetail extends StatefulWidget {
  final int postId;
  const FeedPostDetail({Key? key, required this.postId}) : super(key: key);

  @override
  State<FeedPostDetail> createState() => _FeedPostDetailState();
}

class _FeedPostDetailState extends State<FeedPostDetail> {
  late Future<FeedPostDetailModel> postDetail;

  @override
  Widget build(BuildContext context) {

    final safeAreaTopPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: FutureBuilder(
            future: ApiService.getPostById(widget.postId),
            builder: (BuildContext context, AsyncSnapshot<FeedPostDetailModel> snapshot) {
              if (snapshot.hasData) {
                final post = snapshot.data as FeedPostDetailModel;
                debugPrint(post.toString());
                final isLiked = post.isLiked ?? false;

                const bannerTitle = "이번 여름은 \n'카캉스'어때요?";
                const bannerDesc = '카페에서 보내는 바캉스 스팟 5곳';
                const created = "2023.02.01";
                const likeCount = "4.8 M";

                const title = '연남동 카페 투어 패스';
                const eventPeriodLabel = '이벤트 기간';
                const eventPeriod = '2023. 02. 10 ~ 03. 01';

                // paragraph
                const p1 =
                    '바야흐로 여름, 무더위의 계절이 도래했다. 사람들은 각자 떠나고 미리 떠나고 싶었던 휴가를 떠올리며 즐거운 상상을 하기도 하고, 아직 계획이 없던 이들도 여름휴가를 계획하며 다시 힘차게 하루를 이어간다.';
                const p2 =
                    '하지만 그저 여름 휴가만을 기다리기에 우리의 일상에는 터프한 사건사고들이 많은 것도 사실. 1년에 한 두 번 정도의 휴가로 이 모든 스트레스들을 날려버리기란 사실 쉬운 일이 아니지 않은가?';

                // title paragraph
                const tpTitle1 = '“가까운데 분위기 좋은곳\n어디 없나?”';
                const tpDecs1 =
                    '그럴 때 눈을 돌려보면, 이제 공간의 개념을 넘어선 카페들이 보이기 시작한다. 다양하면서도 독특한 컨셉으로 무장한 카페들은 가볍게 쉬기 위한 휴식처이자 피난처로는 제격. 게다가 마실 수 있는 음료와 디저트들도 가득하니 그야말로 딱이다.';

                // image paragraph
                const ipTitle1 = '#1. 연남동 디저트 앤 타르트';
                const ipDecs1 =
                    '깔끔한 인테리어와 어디서나 전망좋은 자리 그리고 잔잔한 음악과 여유,자연을 좋아하는 사람이라면 이 곳 연남동 디저트 앤 타르트 잠깐 와보는것도 시원한 카캉스를 보낼 수 있을 것이다.';
                const ipTmi = '사실 사장님이 화분을 너무 좋아하신다.';
                const ipSrc1 = 'https://picsum.photos/id/642/1024';

                const p3 =
                    '이 곳 디저트 앤 타르트는 이름 그대로 타르트가 유명하다 여러 타르트중 에그타르트와 시나몬 땅콩 타르트가 대표 메뉴이고 스페셜 메뉴는 당근케이크다. 깔끔하면서 적당히 달달한 디저트를 원하는 사람은 한번쯤 가봐도 좋은 장소이다.';

                final product1 = FeedPostDetailStoreContentData(
                  title: '프리미엄 에그타르트(5개입)',
                  storeName: '연남동 디저트 앤 타르트',
                  price: '12,000원',
                  imageUrl:
                      'https://cdn.pixabay.com/photo/2017/08/30/01/05/milky-way-2695569__480.jpg',
                );

                final product2 = FeedPostDetailStoreContentData(
                  title: '슈가파우더 올라간 시나몬 땅콩타르트(5개입)',
                  storeName: '연남동 디저트 앤 타르트',
                  price: '12,000원',
                  imageUrl: 'https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072823__480.jpg',
                );

                const ipTitle2 = '#2. 모카천국 커피 (연남점)';
                const ipSubtitle2 = '분위기, 시원함, 디저트, 여유로움을 모두 갖춘 완벽한 카캉스는 바로 여기!';
                const ipDecs2 =
                    '대부분 카페에서 파는 모카커피는 대부분 초콜릿소스가 모카로 둔갑한 가짜 커피에 불과하다. 그렇지만 진짜 모카를 재료로 쓴 커피의 맛은 과연 어떨까?';
                const ipSrc2 = 'https://picsum.photos/id/3/1024';

                final product3 = FeedPostDetailStoreContentData(
                  title: '진한 모카가 들어간 진정한 모카커피',
                  storeName: '모카천국 커피 (연남점)',
                  price: '12,000원',
                  imageUrl: 'https://picsum.photos/id/102/400',
                );

                final product4 = FeedPostDetailStoreContentData(
                  title: '마카다미아 쿠기& 딥 다크 초콜릿 쿠키',
                  storeName: '모카천국 커피 (연남점)',
                  price: '12,000원',
                  imageUrl: 'https://picsum.photos/id/110/400',
                );

                const p4 =
                    '커피가 가는 곳에 쿠키가 빠질 수 없다. 모카천국 커피(연남점)에서는 다양한 쿠키를 맛 볼 수 있다. 라즈베리쿠키,마카다미아 쿠키, 미친 초코 쿠키,오트밀 쿠키,치즈쿠키,로즈마리쿠키 등 다양하다. 커피와 잘 어울리는 쿠키들은 빠르게 매진이 되니 아침에 미리 선주문을 하는것을 추천한다.';

                const tags = ['힐링스팟', '카페', '투어', '한정판', '클래스', '데이트 코스'];

                final commentCount = context.watch<FeedProvider>().commentCount;

                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PostDetailBanner(
                            imageUrl: post.bannerImageUrl ?? '',
                            title: bannerTitle,
                            desc: bannerDesc,
                            created: created,
                            likeCount: likeCount,
                            isLiked: isLiked,
                          ),
                          const PostDetailTitle(
                            title: title,
                            eventPeriodLabel: eventPeriodLabel,
                            eventPeriod: eventPeriod,
                          ),
                          const Divider(
                            indent: 20,
                            endIndent: 20,
                            height: 1,
                            thickness: 1,
                            color: Color(0xFFEEEEEE),
                          ),
                          const PostDetailParagraph(text: p1),
                          const PostDetailParagraph(text: p2),
                          const PostDetailTitleParagraph(
                            title: tpTitle1,
                            desc: tpDecs1,
                          ),
                          const PostDetailImageParagraph(
                            title: ipTitle1,
                            imageUrl: ipSrc1,
                            desc: ipDecs1,
                            tmi: ipTmi,
                          ),
                          const PostDetailParagraph(text: p3),
                          const SizedBox(height: 24),
                          Column(
                            children: [
                              FeedPostDetailStoreContent(content: product1),
                              FeedPostDetailStoreContent(content: product2),
                            ],
                          ),
                          const PostDetailImageParagraph(
                            title: ipTitle2,
                            subtitle: ipSubtitle2,
                            imageUrl: ipSrc2,
                            desc: ipDecs2,
                          ),
                          Column(
                            children: [
                              FeedPostDetailStoreContent(content: product3),
                              FeedPostDetailStoreContent(content: product4),
                            ],
                          ),
                          const PostDetailParagraph(text: p4),
                          const PostDetailTags(tags: tags),
                          const SizedBox(height: 40),
                          const RelatedPosts(),
                          const Notice(),
                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
                    Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: StaticColor.grey400BB,
                            blurRadius: 1,
                            offset: const Offset(0, -1),
                          )
                        ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) {
                                    return CommentView(topPadding: safeAreaTopPadding);
                                  }
                                );
                              },
                              child: Row(
                                children: [
                                  Image.asset('assets/feed/comment_icon.png', width: 24, height: 24, color: StaticColor.grey400BB),
                                  const SizedBox(width: 4),
                                  Text(commentCount.toString(), style: TextStyle(fontSize: 16, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                                ]
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                LikeButton(isLiked: isLiked),
                                Text('4.8M', style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                                const SizedBox(width: 4),
                                IconRippleButton(
                                  icon: Icons.share_rounded,
                                  color: StaticColor.grey400BB,
                                  size: 24,
                                  padding: 8,
                                  onPressed: () => {},
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}

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
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF333333),
              )),
          const SizedBox(height: 32),
          Text(eventPeriodLabel,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF555555),
              )),
          const SizedBox(height: 4),
          Text(
            eventPeriod,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF777777),
            ),
          ),
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

  const LikeButton({Key? key, required this.isLiked}) : super(key: key);

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

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconRippleButton(
      icon: isLiked ? Icons.favorite : Icons.favorite_border,
      color: isLiked ? Colors.red : StaticColor.grey400BB,
      size: 24,
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
    required this.created,
    required this.likeCount,
    required this.isLiked,
  });

  final String imageUrl;
  final String title;
  final String desc;
  final String created;
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
        const PostDetailBackButton(),
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
                            created,
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
