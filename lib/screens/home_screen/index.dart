import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sense_flutter_application/screens/home_screen/partials/chip_list_tab.dart';
import 'package:sense_flutter_application/screens/home_screen/partials/grid_cards.dart';
import 'package:sense_flutter_application/screens/home_screen/partials/single_cards.dart';
import 'package:sense_flutter_application/screens/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sense_flutter_application/screens/widgets/banner_area.dart';
import 'package:sense_flutter_application/screens/widgets/scroll/infinite_scroll.dart';
import 'package:sense_flutter_application/store/providers/Post/post_collection_provider.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';
import 'package:sense_flutter_application/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  bool toggleView = false;
  bool isLoad = false;
  bool isShowSticky = true;
  final showFormatButton = StateProvider((ref) => true);

  void toggleViewAction() {
    setState(() {
      toggleView = !toggleView;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {}
  }

  @override
  dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
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
          bool isLoading = ref.watch(isLoadingProvider);

          var nextPost = debounce((String e) {
            var notifier = ref.read(postCollectionProvider.notifier);
            notifier.nextPost(url: notifier.posts['next']);
          }, const Duration(milliseconds: 500));

          var sticky = debounce((String e) {
            print(e);
            ref.read(showFormatButton.notifier).state = true;
            print('sticky');
          }, const Duration(milliseconds: 100));

          return MainLayout(
            title: '',
            body: RefreshIndicator(
                onRefresh: () async {
                  ref.read(postCollectionProvider.notifier).refreshPosts();
                },
                child: Stack(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: InfiniteScroll(
                            onFetchData: () async {
                              ref.read(isLoadingProvider.notifier).state = true;
                              var notifier = ref.read(postCollectionProvider.notifier);
                              notifier.nextPost(url: notifier.posts['next']).then((value) {
                                ref.read(isLoadingProvider.notifier).state = false;
                              });
                            },
                            onScroll: (e) {
                              setState(() {
                                isShowSticky = e;
                              });
                            },
                            isLoading: isLoading,
                            // controller: scrollController,
                            // padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                BannerArea(children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration:
                                        BoxDecoration(color: Colors.amber[200]?.withOpacity(0.7)),
                                    child: Image.asset(
                                      'lib/assets/images/banner_1.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration:
                                        BoxDecoration(color: Colors.amber[200]?.withOpacity(0.7)),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 240,
                                    decoration:
                                        BoxDecoration(color: Colors.red[200]?.withOpacity(0.7)),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 240,
                                    decoration:
                                        BoxDecoration(color: Colors.green[200]?.withOpacity(0.7)),
                                  )
                                ]),
                                const Padding(
                                  padding: EdgeInsets.only(top: 16, left: 20),
                                  child: ChipListTab(chipList: [
                                    '추천',
                                    '디저트',
                                    '케이크',
                                    '비빔밥',
                                    '내가 찜한 콘텐츠',
                                    '맛집',
                                    '추천',
                                    '디저트',
                                    '케이크',
                                    '비빔밥',
                                    '내가 찜한 콘텐츠',
                                    '맛집'
                                  ]),
                                ),
                                FutureBuilder(
                                    future: ref.read(postCollectionProvider.notifier).fetchPosts(),
                                    builder: (context, snapshot) {
                                      return toggleView
                                          ? const Padding(
                                              padding:
                                                  EdgeInsets.only(top: 20, left: 20, right: 20),
                                              child: GridCards())
                                          // Content
                                          : const SingleCards();
                                    }),
                                // if (isLoading) const CircularProgressIndicator()
                              ],
                            ))),
                    Positioned(
                        right: 0,
                        left: 0,
                        bottom: 16,
                        child: Center(
                          child: Visibility(
                              visible: isShowSticky,
                              child: ElevatedButton.icon(
                                  onPressed: toggleViewAction,
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(
                                        const Color.fromRGBO(85, 85, 85, 1)),
                                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                        const EdgeInsets.only(
                                            left: 20, right: 20, top: 10, bottom: 10)),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                  icon: SvgPicture.asset(
                                      toggleView
                                          ? 'lib/assets/images/icons/svg/single_view.svg'
                                          : 'lib/assets/images/icons/svg/grid_view.svg',
                                      width: 20,
                                      height: 20,
                                      color: Colors.white),
                                  label: Text(toggleView ? '크게보기' : '모아보기',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white)))),
                        ))
                  ],
                )),
          );
        }),
      ),
    );
  }
}
