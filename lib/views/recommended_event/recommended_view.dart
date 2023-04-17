import 'package:async/async.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/add_event/add_event_model.dart';
import 'package:sense_flutter_application/models/recommended_event/recommended_model.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';
import 'package:sense_flutter_application/views/recommended_event/recommended_event_provider.dart';

class RecommendedTitle extends StatefulWidget {
  const RecommendedTitle({Key? key}) : super(key: key);

  @override
  State<RecommendedTitle> createState() => _RecommendedTitleState();
}

class _RecommendedTitleState extends State<RecommendedTitle> {
  @override
  Widget build(BuildContext context) {
    return HeaderMenu(backCallback: backCallback, title: '추천', rightMenu: menu());
  }

  void backCallback() {
    Navigator.of(context).pop();
  }

  Widget menu() {
    return GestureDetector(
        onTap: () {
        },
        child: Image.asset('assets/recommended_event/menu.png', width: 24, height: 24)
    );
  }
}

class RecommendedTagSection extends StatefulWidget {
  const RecommendedTagSection({Key? key}) : super(key: key);

  @override
  State<RecommendedTagSection> createState() => _RecommendedTagSectionState();
}

class _RecommendedTagSectionState extends State<RecommendedTagSection> {

  final AsyncMemoizer memoizer = AsyncMemoizer();

  List<Widget> categoryWidget = [];
  List<bool> categoryState = [];
  List<List<RecommendedModel>> allRecommendedModels = [];
  List<RecommendedModel> recommendedModels = [];

  // List<Widget> dataSet() {
  //   categoryWidget = AddEventModel.recommendedModel.map((e) {
  //
  //     AddEventModel.recommendedModel.length == categoryState.length ? {} : categoryState.add(false);
  //
  //     String tabName = '';
  //     if(e == 'GIFT') {
  //       tabName = '선물';
  //     } else if(e == 'HOTEL') {
  //       tabName = '호텔';
  //     } else if(e == 'LUNCH') {
  //       tabName = '점심';
  //     } else if(e == 'DINNER') {
  //       tabName = '저녁';
  //     } else if(e == 'ACTIVITY') {
  //       tabName = '액티비티';
  //     } else if(e == 'BAR') {
  //       tabName = '술집';
  //     }
  //
  //     return FutureBuilder(
  //         future: oneBuildFuture(RecommendedApi().getRecommendList(e)),
  //         builder: (BuildContext context, AsyncSnapshot snapshot) {
  //           if(snapshot.connectionState == ConnectionState.waiting) {
  //             return Container();
  //           } else if(snapshot.connectionState == ConnectionState.done) {
  //
  //
  //
  //             return Row(
  //               children: [
  //                 GestureDetector(
  //                     onTap: () {
  //                       setState(() {
  //                         for(int i = 0; i < categoryState.length; i++) {
  //                           categoryState[i] = false;
  //                         }
  //                         categoryState[AddEventModel.recommendedModel.indexOf(e)] = true;
  //                       });
  //                       print(categoryState);
  //                       // context.read<RecommendedEventProvider>().categoryChange(e);
  //                     },
  //                     child: Container(
  //                       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
  //                       height: 36,
  //                       decoration: BoxDecoration(
  //                         color: categoryState[AddEventModel.recommendedModel.indexOf(e)] == true ? StaticColor.recommendedCategorySelectColor : StaticColor.recommendedCategoryNonSelectColor,
  //                         borderRadius: BorderRadius.circular(18.0),
  //                       ),
  //                       child: Center(child: Text('$tabName(${recommendedModels.length})', style: TextStyle(fontSize: 14, color: categoryState[AddEventModel.recommendedModel.indexOf(e)] == true ? Colors.white : StaticColor.recommendedCategoryNonSelectTextColor, fontWeight: FontWeight.w500))),
  //                     )
  //                 ),
  //                 AddEventModel.recommendedModel.indexOf(e) == e.length - 1 || AddEventModel.recommendedModel[AddEventModel.recommendedModel.indexOf(e)] == '' ? const SizedBox() : const SizedBox(width: 4),
  //               ],
  //             );
  //           } else {
  //             return Container();
  //           }
  //         }
  //     );
  //   }).toList();
  //   return categoryWidget;
  // }
  //


  // List<Widget> tabSet() {
  //   categoryWidget = List.generate(AddEventModel.recommendedModel.length, (i) {
  //     return Row(
  //       children: [
  //         GestureDetector(
  //             onTap: () {
  //               setState(() {
  //                 for(int i = 0; i < categoryState.length; i++) {
  //                   categoryState[i] = false;
  //                 }
  //                 categoryState[i] = true;
  //               });
  //               print(categoryState);
  //               // context.read<RecommendedEventProvider>().categoryChange(e);
  //             },
  //             child: Container(
  //               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
  //               height: 36,
  //               decoration: BoxDecoration(
  //                 color: categoryState[i] == true ? StaticColor.recommendedCategorySelectColor : StaticColor.recommendedCategoryNonSelectColor,
  //                 borderRadius: BorderRadius.circular(18.0),
  //               ),
  //               child: Center(child: Text('${categoryName.elementAt(i)}(${recommendedModels.length})', style: TextStyle(fontSize: 14, color: categoryState[i] == true ? Colors.white : StaticColor.recommendedCategoryNonSelectTextColor, fontWeight: FontWeight.w500))),
  //             )
  //         ),
  //         AddEventModel.recommendedModel.length == i ? const SizedBox() : const SizedBox(width: 4),
  //       ],
  //     );
  //   }).toList();
  //   return categoryWidget;
  // }



  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: oneBuildFuture(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else if(snapshot.connectionState == ConnectionState.done) {

          // List<RecommendedModel> recommendedModels = snapshot.data;
          // print(recommendedModels.elementAt(0).recommendType);
          recommendedModels.map((e) => {
            /// 모델 분리
          }).toList();

          /// 선택한 카테고리 별 모델 카운트 로직
          categoryWidget = AddEventModel.recommendedModel.map((e) {
            categoryState.add(false);
            int a = 0;
            for(int i = 0; i < recommendedModels.length; i++) {
              recommendedModels[i].recommendType == e ? a++ : {};
            }
            return Row(
              children: [
                GestureDetector(
                    onTap: () {
                      setState(() {
                        for(int i = 0; i < categoryState.length; i++) {
                          categoryState[i] = false;
                        }
                        categoryState[AddEventModel.recommendedModel.indexOf(e)] = true;
                      });
                      print(categoryState);
                      // context.read<RecommendedEventProvider>().categoryChange(e);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                      height: 36,
                      decoration: BoxDecoration(
                        color: categoryState[AddEventModel.recommendedModel.indexOf(e)] == true ? StaticColor.recommendedCategorySelectColor : StaticColor.recommendedCategoryNonSelectColor,
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Center(child: Text('$e(${a})', style: TextStyle(fontSize: 14, color: categoryState[AddEventModel.recommendedModel.indexOf(e)] == true ? Colors.white : StaticColor.recommendedCategoryNonSelectTextColor, fontWeight: FontWeight.w500))),
                    )
                ),
                AddEventModel.recommendedModel.length - 1 == AddEventModel.recommendedModel.indexOf(e) ? const SizedBox() : const SizedBox(width: 4),
              ],
            );
          }).toList();

          return Row(
            children: categoryWidget,
          );
        } else {
          return Container();
        }
      }
    );
  }
  Future oneBuildFuture() => memoizer.runOnce(() async => {
    recommendedModels = await RecommendedApi().getRecommendList(''),
    await Future.delayed(Duration(milliseconds: 1500))
  });
}

class RecommendedItemSection extends StatefulWidget {
  const RecommendedItemSection({Key? key}) : super(key: key);

  @override
  State<RecommendedItemSection> createState() => _RecommendedItemSectionState();
}

class _RecommendedItemSectionState extends State<RecommendedItemSection> with AutomaticKeepAliveClientMixin<RecommendedItemSection> {

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final selectCategory = context.watch<RecommendedEventProvider>().selectCategory;
    print(selectCategory);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 24),
        child: Column(
          children: [
            Align(alignment: Alignment.centerLeft, child: Text('받은 추천', style: TextStyle(fontSize: 16, color: StaticColor.recommendedTextColor, fontWeight: FontWeight.w700))),
            const SizedBox(height: 8),
            FutureBuilder(
              future: RecommendedApi().getRecommendList(selectCategory),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.connectionState == ConnectionState.done) {
                  List<RecommendedModel> recommendedModels = snapshot.data;
                  // print(aa.elementAt(0).product!.description);
                  // List<RecommendedModel> models = snapshot.data;s
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: recommendedModels.length,
                    itemBuilder: (BuildContext context, int index) {

                      return Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 92,
                                height: 112,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4.0),
                                  child: CachedNetworkImage(
                                    progressIndicatorBuilder: (context, url, progress) => Center(
                                      child: CircularProgressIndicator(
                                        value: progress.progress,
                                      ),
                                    ),
                                    imageUrl: recommendedModels.elementAt(index).product!.imageUrl!
                                  ),
                                ),
                              )
                            ]
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: StaticColor.categoryUnselectedColor,
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                      },
                                      style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categoryUnselectedColor, elevation: 0.0, padding: const EdgeInsets.symmetric(horizontal: 0)),
                                      child: Text('그만보기', style: TextStyle(fontSize: 12, color: StaticColor.drawerTextColor, fontWeight: FontWeight.w400), textAlign: TextAlign.center),
                                    ),
                                  ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                flex: 1,
                                child: Builder(
                                  builder: (BuildContext buttonContext) {
                                    bool presentState = false;
                                    return Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: presentState == true ? StaticColor.recommendedBoxColor : Colors.white,
                                        borderRadius: BorderRadius.circular(4.0),
                                        border: Border.all(color: StaticColor.recommendedBoxColor, width: 1),
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            presentState = !presentState;
                                            setState(() {

                                              print(presentState);
                                            });
                                          },
                                          child: Center(child: Text('선택하기', style: TextStyle(fontSize: 12, color: presentState == true ? Colors.white : StaticColor.recommendedBoxColor, fontWeight: FontWeight.w500))),
                                        ),
                                      ),
                                    );
                                  }
                                ),
                              )
                            ]
                          )
                        ]
                      );
                    }
                  );
                } else if(snapshot.connectionState == ConnectionState.waiting) {
                  // return const CircularProgressIndicator();
                  return Container();
                } else {
                  return Container(
                      width: double.infinity,
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            SizedBox(height: 250),
                            Image.asset('assets/recommended_event/searching.png', width: 40, height: 40),
                            SizedBox(height: 24),
                            Text('플래너가 추천 할 상품을 찾는 중이예요.', style: TextStyle(fontSize: 14, color: StaticColor.recommendedSearchingTextColor, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      )
                  );
                }
              }
            ),
          ],
        ),
      )
    );
  }

  @override
  bool get wantKeepAlive => true;
}
