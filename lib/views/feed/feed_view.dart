import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/models/feed/feed_model.dart';
import 'package:sense_flutter_application/screens/feed/feed_search_screen.dart';
import 'package:sense_flutter_application/views/feed/feed_post_thumbnail.dart';
import 'package:sense_flutter_application/views/feed/feed_provider.dart';
import 'package:sense_flutter_application/views/feed/feed_search_provider.dart';

class FeedHeader extends StatefulWidget {
  const FeedHeader({Key? key}) : super(key: key);

  @override
  State<FeedHeader> createState() => _FeedHeaderState();
}

class _FeedHeaderState extends State<FeedHeader> {
  TextEditingController searchController = TextEditingController();

  void search(String value) {
    context.read<FeedSearchProvider>().initialize(value);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FeedSearchScreen(),
      ),
    );
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
                      controller: searchController,
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
                        search(searchController.text);
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
          const SizedBox(width: 12),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () {
                // Handle button press
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.notifications_none_rounded,
                  size: 24,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FeedTagList extends StatefulWidget {
  const FeedTagList({Key? key}) : super(key: key);

  @override
  State<FeedTagList> createState() => _FeedTagListState();
}

class _FeedTagListState extends State<FeedTagList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: SizedBox(
        height: 36,
        child: FutureBuilder(
          future: context.read<FeedProvider>().initializeFeed(),
          // Provider.of<FeedProvider>(context, listen: false).initializeFeed(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error fetching posts'));
            } else {
              return Consumer<FeedProvider>(
                builder: (context, feedProvider, child) {
                  List<FeedTagModel> feedTags = feedProvider.feedTags;
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: feedTags.length,
                    itemBuilder: (BuildContext context, int index) {
                      final tagId = feedTags[index].id;
                      final isSelected = context.read<FeedProvider>().selectedTagId == tagId;
                      return Material(
                        borderRadius: BorderRadius.circular(18),
                        color: isSelected ? Colors.grey.shade800 : Colors.grey.shade200,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            context.read<FeedProvider>().changeTagId(tagId);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 7,
                            ),
                            child: Center(
                              child: Text(
                                feedTags[index].title,
                                style: TextStyle(
                                  color: isSelected ? Colors.white : Colors.grey.shade700,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(width: 6);
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class FeedPostList extends StatefulWidget {
  const FeedPostList({Key? key}) : super(key: key);

  @override
  State<FeedPostList> createState() => _FeedPostListState();
}

class _FeedPostListState extends State<FeedPostList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: context.read<FeedProvider>().getFeedPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // return const Center(child: CircularProgressIndicator());
            return Container();
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching posts'));
          } else {
            return Consumer<FeedProvider>(
              builder: (context, feedProvider, child) {
                final feedPosts = feedProvider.feedPosts;
                if (feedPosts.isEmpty) {
                  return Center(
                    child: Text(
                      '검색 결과가 없습니다.',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                      ),
                    ),
                  );
                } else {
                  return FeedPostListPresenter(
                    feedPosts: context.read<FeedProvider>().feedPosts,
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
