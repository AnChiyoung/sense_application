import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/feed/feed_model.dart';
import 'package:sense_flutter_application/models/feed/feed_tag_model.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/public_widget/logout_dialog.dart';
import 'package:sense_flutter_application/public_widget/service_guide_dialog.dart';
import 'package:sense_flutter_application/screens/add_event/add_event_screen.dart';
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                /// 검색 필드
                TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    hintText: "'생일선물'을 검색해보세요",
                    hintStyle: TextStyle(fontSize: 14, color: StaticColor.grey400BB, fontWeight: FontWeight.w400),
                    filled: true,
                    fillColor: StaticColor.grey100F6,
                    // fillColor: Colors.black,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 0, color: Colors.transparent),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 0, color: Colors.transparent),
                    )
                  ),
                  // onSubmitted: search,
                ),
                /// 우측 검색 버튼
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () {
                        // search(searchController.text);
                      },
                      child: Image.asset('assets/feed/search_button.png', width: 24, height: 24),
                    ),
                  ),
                ),
              ]
            ),
          ),
          const SizedBox(width: 12),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () {
                /// logout
                showDialog(
                    context: context,
                    //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return LogoutDialog(action: logoutAction);
                    });
              },
              child: Image.asset('assets/feed/logout_button.png', width: 24, height: 24),
            ),
          ),
        ],
      )
    );
    // return Padding(
    //   padding: const EdgeInsets.only( // 추후, 잉크웰 범위를 재조정하는 과정 필요
    //     left: 20, right: 8, top: 12, bottom: 12,
    //   ),
    //   child: Row(
    //     children: [
    //       Expanded(
    //         child: Container(
    //           padding: const EdgeInsets.symmetric(
    //             horizontal: 16,
    //           ),
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(4),
    //             color: const Color(0xFFF6F6F6),
    //           ),
    //           child: Row(
    //             children: [
    //               Expanded(
    //                 child: TextField(
    //                   controller: searchController,
    //                   decoration: const InputDecoration(
    //                     hintText: "'생일선물'을 검색해 보세요",
    //                     border: InputBorder.none,
    //                   ),
    //                   onSubmitted: search,
    //                 ),
    //               ),
    //               Material(
    //                 color: Colors.transparent,
    //                 child: InkWell(
    //                   borderRadius: BorderRadius.circular(24),
    //                   onTap: () {
    //                     search(searchController.text);
    //                   },
    //                   // onTap: onPressSearchIcon,
    //                   child: const Padding(
    //                     padding: EdgeInsets.all(8.0),
    //                     child: Icon(
    //                       Icons.search,
    //                       size: 24,
    //                       color: Colors.black54,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       const SizedBox(width: 12),
    //       Material(
    //         color: Colors.transparent,
    //         child: InkWell(
    //           borderRadius: BorderRadius.circular(24),
    //           onTap: () {
    //             // Handle button press
    //           },
    //           child: const Padding(
    //             padding: EdgeInsets.all(8.0),
    //             child: Icon(
    //               Icons.notifications_none_rounded,
    //               size: 24,
    //               color: Colors.black54,
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  void logoutAction() {
    LoginRequest.storage.delete(key: 'id');
    LoginRequest.storage.delete(key: 'username');
    LoginRequest.storage.delete(key: 'profileImage');
    PresentUserInfo.id = -1;
    PresentUserInfo.username = '';
    PresentUserInfo.profileImage = '';
    Navigator.popUntil(context, (route) => route.isFirst);
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
          // future: context.read<FeedProvider>().initializeFeed(),
          future: FeedTagLoad().tagRequest(),
          // Provider.of<FeedProvider>(context, listen: false).initializeFeed(),
          builder: (context, snapshot) {
            List<TagModel>? tagModels = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error fetching posts'));
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: tagModels!.length,
                  itemBuilder: (context, index) {

                    final selectTagNumber = context.watch<FeedProvider>().selectTagNumber;

                    return Row(
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(18),
                          color: index == selectTagNumber ? Colors.grey.shade800 : Colors.grey.shade200,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              context.read<FeedProvider>().selectTagNumberChange(index);
                              },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 7,
                              ),
                              child: Center(
                                child: Text(
                                  tagModels.elementAt(index).title!,
                                  style: TextStyle(
                                    color: index == selectTagNumber ? Colors.white : Colors.grey.shade700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(width: 6);
                  }
                ),
              );
              // return Consumer<FeedProvider>(
              //   builder: (context, feedProvider, child) {
              //     List<TagModel> tags =
              //     // List<FeedTagModel> feedTags = feedProvider.feedTags;
              //     return ListView.separated(
              //       padding: const EdgeInsets.symmetric(
              //         horizontal: 30,
              //       ),
              //       scrollDirection: Axis.horizontal,
              //       itemCount: feedTags.length,
              //       itemBuilder: (BuildContext context, int index) {
              //         final tagId = feedTags[index].id;
              //         final isSelected = context.read<FeedProvider>().selectedTagId == tagId;
              //         return Material(
              //           borderRadius: BorderRadius.circular(18),
              //           color: isSelected ? Colors.grey.shade800 : Colors.grey.shade200,
              //           child: InkWell(
              //             borderRadius: BorderRadius.circular(16),
              //             onTap: () {
              //               context.read<FeedProvider>().changeTagId(tagId);
              //             },
              //             child: Padding(
              //               padding: const EdgeInsets.symmetric(
              //                 horizontal: 12,
              //                 vertical: 7,
              //               ),
              //               child: Center(
              //                 child: Text(
              //                   feedTags[index].title,
              //                   style: TextStyle(
              //                     color: isSelected ? Colors.white : Colors.grey.shade700,
              //                     fontSize: 14,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         );
              //       },
              //       separatorBuilder: (BuildContext context, int index) {
              //         return const SizedBox(width: 6);
              //       },
              //     );
              //   },
              // );
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
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          FutureBuilder(
            // future: context.read<FeedProvider>().getFeedPosts(),
            future: FeedRequest().feedPreviewRequestByLabelId(-1),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // return const Center(child: CircularProgressIndicator());
                return Container();
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error fetching posts'));
              } else {
                List<FeedPreviewModel>? model = snapshot.data;
                // return Container();
                return FeedPostListPresenter( // 피드 뿌리는 곳
                  feedPosts: model!,
                  // feedPosts: context.read<FeedProvider>().feedPosts,
                );
                // return Consumer<FeedProvider>(
                //   builder: (context, feedProvider, child) {
                //     final feedPosts = feedProvider.feedPosts;
                //     if (feedPosts.isEmpty) {
                //       return Center(
                //         child: Text(
                //           '검색 결과가 없습니다.',
                //           style: TextStyle(
                //             color: Colors.grey.shade600,
                //             fontSize: 16,
                //           ),
                //         ),
                //       );
                //     } else {
                //       return FeedPostListPresenter( // 피드 뿌리는 곳
                //         feedPosts: model!,
                //         // feedPosts: context.read<FeedProvider>().feedPosts,
                //       );
                //     }
                //   },
                // );
              }
            },
          ),
          /// add event button
          IconButton(
            icon: Image.asset('assets/home/add_event_button.png', width: 56, height: 56),
            iconSize: 56,
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (_) => AddEventScreen()));
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const ServiceGuideDialog();
                  });
            },
          ),
        ],
      ),
    );
  }
}
