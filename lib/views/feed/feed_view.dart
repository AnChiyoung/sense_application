import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/feed/feed_model.dart';
import 'package:sense_flutter_application/models/feed/feed_tag_model.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/public_widget/logout_dialog.dart';
import 'package:sense_flutter_application/public_widget/service_guide_dialog.dart';
import 'package:sense_flutter_application/screens/create_event/create_event_screen.dart';
import 'package:sense_flutter_application/screens/feed/feed_search_screen.dart';
import 'package:sense_flutter_application/screens/my_page/my_page_screen.dart';
import 'package:sense_flutter_application/views/animation/animation_provider.dart';
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
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 12.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// logo
          Image.asset('assets/home/home_sense_logo.png', width: 80.0.w),
          /// right menu
          Row(
            children: [
              // Material(
              //   color: Colors.transparent,
              //   child: SizedBox(
              //     width: 40.0.w,
              //     height: 40.0.h,
              //     child: InkWell(
              //         borderRadius: BorderRadius.circular(24),
              //         onTap: () {
              //           /// sprint05
              //         },
              //         child: Center(
              //           child: Image.asset('assets/home/home_search.png', width: 24.0.w, height: 24.0.h)),
              //     ),
              //   ),
              // ),
              // SizedBox(width: 4.0.w),
              // Material(
              //   color: Colors.transparent,
              //   child: SizedBox(
              //     width: 40.0.w,
              //     height: 40.0.h,
              //     child: InkWell(
              //       borderRadius: BorderRadius.circular(24),
              //       onTap: () {
              //         // showDialog(
              //         //     context: context,
              //         //     barrierDismissible: false,
              //         //     builder: (BuildContext context) {
              //         //       return ServiceGuideDialog();
              //         //     });
              //       },
              //       child: Center(
              //         child: Image.asset('assets/home/home_alarm.png', width: 24.0.w, height: 24.0.h)),
              //     ),
              //   ),
              // ),
              // SizedBox(width: 4.0.w),
              Material(
                color: Colors.transparent,
                child: SizedBox(
                  width: 40.0.w,
                  height: 40.0.h,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(24),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => MyPageScreen()));
                    },
                    child: Center(
                        child: Image.asset('assets/home/home_userprofile.png', width: 24.0.w, height: 24.0.h)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      /// 홈화면 헤드
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     Expanded(
      //       child: Stack(
      //         alignment: Alignment.centerRight,
      //         children: [
      //           /// 검색 필드
      //           TextField(
      //             style: TextStyle(fontSize: 14.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w400),
      //             decoration: InputDecoration(
      //               contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      //               hintText: "'생일선물'을 검색해보세요",
      //               hintStyle: TextStyle(fontSize: 14, color: StaticColor.grey400BB, fontWeight: FontWeight.w400),
      //               filled: true,
      //               fillColor: StaticColor.grey100F6,
      //               // fillColor: Colors.black,
      //               border: OutlineInputBorder(
      //                 borderRadius: BorderRadius.circular(4.0),
      //               ),
      //               focusedBorder: const OutlineInputBorder(
      //                 borderSide: BorderSide(width: 0, color: Colors.transparent),
      //               ),
      //               enabledBorder: const OutlineInputBorder(
      //                 borderSide: BorderSide(width: 0, color: Colors.transparent),
      //               )
      //             ),
      //             // onSubmitted: search,
      //           ),
      //           /// 우측 검색 버튼
      //           Padding(
      //             padding: const EdgeInsets.only(right: 12),
      //             child: Material(
      //               color: Colors.transparent,
      //               child: InkWell(
      //                 borderRadius: BorderRadius.circular(24),
      //                 onTap: () {
      //                   search(searchController.text);
      //                 },
      //                 child: Image.asset('assets/feed/search_button.png', width: 24, height: 24),
      //               ),
      //             ),
      //           ),
      //         ]
      //       ),
      //     ),
      //     const SizedBox(width: 12),
      //     Material(
      //       color: Colors.transparent,
      //       child: InkWell(
      //         borderRadius: BorderRadius.circular(24),
      //         onTap: () {
      //           /// sprint05
      //           Navigator.push(context, MaterialPageRoute(builder: (_) => MyPageScreen()));
      //           /// logout
      //           // showDialog(
      //           //     context: context,
      //           //     barrierDismissible: false,
      //           //     builder: (BuildContext context) {
      //           //       return LogoutDialog(action: logoutAction);
      //           //     });
      //         },
      //         child: Icon(Icons.account_circle)
      //       ),
      //     ),
      //     const SizedBox(width: 12),
      //     Material(
      //       color: Colors.transparent,
      //       child: InkWell(
      //         borderRadius: BorderRadius.circular(24),
      //         onTap: () {
      //           /// sprint05
      //           // Navigator.push(context, MaterialPageRoute(builder: (_) => MyPageScreen()));
      //           /// logout
      //           showDialog(
      //               context: context,
      //               barrierDismissible: false,
      //               builder: (BuildContext context) {
      //                 return LogoutDialog(action: logoutAction);
      //               });
      //         },
      //         child: Image.asset('assets/feed/logout_button.png', width: 24.0.w, height: 24.0.h),
      //       ),
      //     ),
      //   ],
      // )
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
              return const SizedBox.shrink();
            } else if (snapshot.hasError) {
              return const SizedBox.shrink();
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// '전체' 태그
                    Consumer<FeedProvider>(
                      builder: (context, data, child) {

                        bool totalSelector = data.totalTag;

                        return Material(
                          borderRadius: BorderRadius.circular(18),
                          color: totalSelector == false ? Colors.grey.shade200 : Colors.grey.shade800,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              context.read<FeedProvider>().selectTotalTagChange();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 7,
                              ),
                              child: Center(
                                child: Text(
                                  '전체',
                                  style: TextStyle(
                                    color: totalSelector == false ? Colors.grey.shade700 : Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    ),
                    SizedBox(width: 6.0.w),
                    Expanded(
                      child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: tagModels!.length,
                        itemBuilder: (context, index) {

                          final selectTagIndex = context.watch<FeedProvider>().selectTagIndex;

                          return Row(
                            children: [
                              Material(
                                borderRadius: BorderRadius.circular(18),
                                color: index == selectTagIndex ? Colors.grey.shade800 : Colors.grey.shade200,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: () {
                                    // context.read<FeedProvider>().selectTagNumberChange(index);
                                    /// 20230827
                                    context.read<FeedProvider>().selectTagNumberChange(tagModels.elementAt(index).id!, index);
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
                                          color: index == selectTagIndex ? Colors.white : Colors.grey.shade700,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 6.0.w),
                            ],
                          );
                        },
                        // separatorBuilder: (BuildContext context, int index) {
                        //   return const SizedBox(width: 6);
                        // }
                      ),
                    ),
                  ],
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

class _FeedPostListState extends State<FeedPostList> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  bool forwardDirection = false;
  double rotationAngle = 0.0;
  double oldAngle = 0.0;

  @override
  void initState() {
    // getInitLabel();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _controller.value = 0.0;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      //초기화
      rotationAngle = 0.0;
      oldAngle = 0.0;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future getInitLabel() async {
    List<TagModel> tagModels = await FeedTagLoad().tagRequest();
    context.read<FeedProvider>().selectTagNumberChange(-1, -1);
    // final firstTagNumber = tagModels.elementAt(0).id;
    // context.read<FeedProvider>().selectTagNumberChange(firstTagNumber!  , 0);
  }

  @override
  Widget build(BuildContext context) {

    final selectTagNumber = context.watch<FeedProvider>().selectTagNumber;

    return Expanded(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          FutureBuilder(
            // future: context.read<FeedProvider>().getFeedPosts(),
            future: FeedRequest().feedPreviewRequestByLabelId(selectTagNumber),
            builder: (context, snapshot) {

              if(snapshot.hasError) {
                return const SizedBox.shrink();
                // return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
              } else if(snapshot.hasData) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox.shrink();
                  // return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
                } else if(snapshot.connectionState == ConnectionState.done) {

                  List<FeedPreviewModel>? model = snapshot.data;

                  if(model!.isEmpty) {
                    return Center(child: Text('곧, 새로운 피드로 찾아뵐게요!', style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey60077, fontWeight: FontWeight.w400)));
                  } else {
                    return FeedPostListPresenter( // 피드 뿌리는 곳
                      feedPosts: model!,
                    );
                  }


                } else {
                  return const SizedBox.shrink();
                  // return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
                }
              } else {
                return const SizedBox.shrink();
                // return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
              }


              // if (snapshot.connectionState == ConnectionState.waiting) {
              //   // return const Center(child: CircularProgressIndicator());
              //   return Container();
              // } else if (snapshot.hasError) {
              //   return const Center(child: Text('Error fetching posts'));
              // } else {
              //   List<FeedPreviewModel>? model = snapshot.data;
              //   // return Container();
              //   return FeedPostListPresenter( // 피드 뿌리는 곳
              //     feedPosts: model!,
              //     // feedPosts: context.read<FeedProvider>().feedPosts,
              //   );
              //   // return Consumer<FeedProvider>(
              //   //   builder: (context, feedProvider, child) {
              //   //     final feedPosts = feedProvider.feedPosts;
              //   //     if (feedPosts.isEmpty) {
              //   //       return Center(
              //   //         child: Text(
              //   //           '검색 결과가 없습니다.',
              //   //           style: TextStyle(
              //   //             color: Colors.grey.shade600,
              //   //             fontSize: 16,
              //   //           ),
              //   //         ),
              //   //       );
              //   //     } else {
              //   //       return FeedPostListPresenter( // 피드 뿌리는 곳
              //   //         feedPosts: model!,
              //   //         // feedPosts: context.read<FeedProvider>().feedPosts,
              //   //       );
              //   //     }
              //   //   },
              //   // );
              // }
            },
          ),

          /// create event button
          Consumer<AnimationProvider>(
            builder: (context, data, child) {

              bool functionPlusButtonState = data.homeAddButton;

              return AnimatedOpacity(
                opacity: functionPlusButtonState ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: Padding(
                  padding: EdgeInsets.only(right: 24.0.w, bottom: 100.0.h),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => CreateEventScreen()));
                        },
                        style: ElevatedButton.styleFrom(elevation: 5.0, backgroundColor: StaticColor.mainSoft, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 1.0.w, vertical: 16.0.h),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset('assets/create_event/create_event_icon.png', width: 24.0.w, height: 24.0.h,),
                              SizedBox(width: 4.0.w),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 4.0.h),
                                  child: Text('이벤트 만들기', style: TextStyle(fontSize: 14.0.sp, color: Colors.white, fontWeight: FontWeight.w500, height: 1.5))),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          ),

          /// function plus button
          Consumer<AnimationProvider>(
            builder: (context, data, child) {

              bool buttonState = data.homeAddButton;

              return AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget? child) {
                  final value = _controller.value;
                  double step = 0.0;
                  if (oldAngle > value) {
                    step = (1.0 - oldAngle) + value;
                  } else {
                    step = value - oldAngle;
                  }
                  oldAngle = value;
                  if (forwardDirection) {
                    rotationAngle += step;
                  } else {
                    rotationAngle -= step;
                  }
                  final angle = rotationAngle * (pi * 2);
                  return Transform.rotate(
                    angle: angle * 1, // 속도
                    child: Padding(
                      padding: EdgeInsets.only(right: 12.0.w, bottom: 12.0.h),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          icon: Image.asset('assets/home/add_event_button.png'),
                          iconSize: 66.0,
                          onPressed: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (_) => CreateEventScreen()));
                            context.read<AnimationProvider>().homeAddButtonState(!buttonState);
                          },
                        ),
                      ),
                    )
                  );
                },
              );
            }
          ),
        ],
      ),
    );
  }
}
