import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/models/feed/feed_model.dart';
import 'package:sense_flutter_application/views/feed/feed_post_thumbnail.dart';
import 'package:sense_flutter_application/views/feed/feed_search_provider.dart';

///
///
/// 피드 검색 헤더
class FeedSearchHeader extends StatefulWidget {
  const FeedSearchHeader({Key? key}) : super(key: key);

  @override
  State<FeedSearchHeader> createState() => _FeedSearchHeaderState();
}

class _FeedSearchHeaderState extends State<FeedSearchHeader> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchController.text = context.read<FeedSearchProvider>().searchTerm;
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void search(String value) {
    context.read<FeedSearchProvider>().changeSearchTerm(value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 12,
      ),
      child: Row(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () {
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 24,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: const Color(0xFFF6F6F6),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: "'생일선물'을 검색해 보세요",
                        border: InputBorder.none,
                      ),
                      onSubmitted: search,
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () {
                        search(_searchController.text);
                      },
                      // onTap: onPressSearchIcon,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.search,
                          size: 24,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///
///
/// 피드 검색 탭
class FeedSearchTab extends StatefulWidget {
  const FeedSearchTab({Key? key}) : super(key: key);

  @override
  State<FeedSearchTab> createState() => _FeedSearchTabState();
}

class _FeedSearchTabState extends State<FeedSearchTab> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: [
              Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 0),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFEEEEEE),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const TabBar(
                    labelColor: Colors.black,
                    indicatorColor: Colors.black,
                    indicatorWeight: 3,
                    unselectedLabelColor: Color(0xFF555555),
                    labelStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    tabs: [
                      Tab(text: '게시글(0)'),
                      Tab(text: '상품(0)'),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Column(
                      children: const [
                        // SearchPostList(),
                      ],
                    ),
                    Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              '검색 결과가 없습니다.',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///
///
/// 피드 검색 게시글 리스트
// class SearchPostList extends StatefulWidget {
//   const SearchPostList({Key? key}) : super(key: key);
//
//   @override
//   State<SearchPostList> createState() => _SearchPostListState();
// }
//
// class _SearchPostListState extends State<SearchPostList> {
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: FutureBuilder(
//         future: context.read<FeedSearchProvider>().searchPost(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             // return const Center(child: CircularProgressIndicator());
//             return Container();
//           } else if (snapshot.hasError) {
//             return const Center(child: Text('Error fetching posts'));
//           } else {
//             return Consumer<FeedSearchProvider>(
//               builder: (context, feedSearchProvider, child) {
//                 final feedPosts = feedSearchProvider.feedPosts;
//                 if (feedPosts.isEmpty) {
//                   return Center(
//                     child: Text(
//                       '검색 결과가 없습니다.',
//                       style: TextStyle(
//                         color: Colors.grey.shade600,
//                         fontSize: 16,
//                       ),
//                     ),
//                   );
//                 } else {
//                   // todo: recommend api 없애고 posts 로 변경
//                   final hello = feedPosts
//                       .map((e) => FeedPostModel(
//                             id: e.id,
//                             title: e.title ?? '',
//                             imageUrl: e.bannerImageUrl ?? '',
//                           ))
//                       .toList();
//                   return FeedPostListPresenter(
//                     feedPosts: hello,
//                   );
//                 }
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }