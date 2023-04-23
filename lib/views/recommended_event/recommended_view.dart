import 'package:async/async.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/add_event/add_event_model.dart';
import 'package:sense_flutter_application/models/recommended_event/recommended_model.dart';
import 'package:sense_flutter_application/public_widget/alert_dialog_miss_content.dart';
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
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const CustomDialog();
              });
        },
        child: Image.asset('assets/recommended_event/menu.png', width: 24, height: 24)
    );
  }
}

class RecommendedItemSection extends StatefulWidget {
  const RecommendedItemSection({Key? key}) : super(key: key);

  @override
  State<RecommendedItemSection> createState() => _RecommendedItemSectionState();
}

class _RecommendedItemSectionState extends State<RecommendedItemSection> {

  final AsyncMemoizer futureMemoizer = AsyncMemoizer();

  /// server response model
  List<RecommendedModel> serverRecommendModels = [];

  /// server response model tag에 맞게 분리
  List<List<RecommendedModel>> recommendModels = [];

  /// tag state
  List<bool> tagState = [];

  /// like state
  List<List<bool>> likeState = [];

  /// select state
  List<List<bool>> selectState = [];

  /// tag widget
  List<Widget> tagWidgets = [];

  /// model widget
  List<Widget> modelWidgets = [];

  /// select widget
  List<List<RecommendedModel>> selectModels = [];

  Widget itemSection() {
    recommendModels.clear();

    /// 태그 별로 모델 삽입할 빈 리스트 생성
    AddEventModel.recommendedModel.map((e) {
      recommendModels.length == AddEventModel.recommendedModel.length ? {} :
          {
            recommendModels.add([]),
            likeState.add([]),
            selectState.add([]),
            selectModels.add([]),
          };
    }).toList();

    /// 모델, 관련 리스트 분리
    serverRecommendModels.map((e) {
      for(String element in AddEventModel.recommendedModel) {
        e.recommendType == element ? {
          recommendModels[AddEventModel.recommendedModel.indexOf(element)].add(e),
          likeState[AddEventModel.recommendedModel.indexOf(element)].add(false),
          selectState[AddEventModel.recommendedModel.indexOf(element)].add(false),
        } : {};
      }
    }).toList();

    /// 태그 위젯 생성
    tagWidgets = AddEventModel.recommendedModel.map((e) {
      AddEventModel.recommendedModel.length == tagState.length ? {} : tagState.add(false);
      String tabName = '';
      if(e == 'GIFT') {
        tabName = '선물';
      } else if(e == 'HOTEL') {
        tabName = '호텔';
      } else if(e == 'LUNCH') {
        tabName = '점심';
      } else if(e == 'DINNER') {
        tabName = '저녁';
      } else if(e == 'ACTIVITY') {
        tabName = '액티비티';
      } else if(e == 'BAR') {
        tabName = '술집';
      }
      int a = 0;
      for(int i = 0; i < serverRecommendModels.length; i++) {
        serverRecommendModels[i].recommendType == e ? a++ : {};
      }

      return Consumer<RecommendedEventProvider>(
        builder: (context, product, child) => Row(
          children: [
            GestureDetector(
              onTap: () {
                for(int i = 0; i < tagState.length; i++) {
                  tagState[i] = false;
                }
                tagState[AddEventModel.recommendedModel.indexOf(e)] = true;
                print('tap index?? : ${AddEventModel.recommendedModel.indexOf(e)}');
                context.read<RecommendedEventProvider>().tagSelect(recommendModels[AddEventModel.recommendedModel.indexOf(e)], AddEventModel.recommendedModel.indexOf(e));
                // setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                height: 36,
                decoration: BoxDecoration(
                  color: tagState[AddEventModel.recommendedModel.indexOf(e)] == true ? StaticColor.recommendedCategorySelectColor : StaticColor.recommendedCategoryNonSelectColor,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Center(
                  child: Text('$tabName(${a})',
                    style: TextStyle(fontSize: 14, color: tagState[AddEventModel.recommendedModel.indexOf(e)] == true ? Colors.white : StaticColor.recommendedCategoryNonSelectTextColor, fontWeight: FontWeight.w500))),
              ),
            ),
            AddEventModel.recommendedModel.length - 1 == AddEventModel.recommendedModel.indexOf(e) ? const SizedBox() : const SizedBox(width: 4),
          ],
        ),
      );
    }).toList();

    /// 화면 진입 시, 태그 하나 활성화
    tagState[0] = true;

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 12),
      child: Column(
        children: [
          /// 태그 위젯
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: tagWidgets,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          Consumer<RecommendedEventProvider>(
            builder: (context, product, child) => modelListSection(selectModels[product.index], product.index, 'mine')),
          /// 하위 추천
          Consumer<RecommendedEventProvider>(
            builder: (context, product, child) => modelListSection(product.selectCategory, product.index, 'recommend')),
          // recommendItemSection!,
        ],
      ),
    );
  }

  /// 나중에 아이템 모델 새로 만들 것, like, remove, select, data 관련 모델 생성
  Widget modelListSection(List<RecommendedModel> models, [int? index, String? listType]) {
    /// make model panel list
    modelWidgets = models.map((e) {
      return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: CachedNetworkImage(
                      progressIndicatorBuilder: (context, url, progress) => Center(
                        child: CircularProgressIndicator(
                          value: progress.progress,
                        ),
                      ),
                      imageUrl: e.product!.imageUrl!,
                      width: 92,
                      height: 112,
                      fit: BoxFit.cover
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 112,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(e.product!.vendor.toString(),
                                style: TextStyle(fontSize: 12, color: StaticColor.recommendedTextColor01, fontWeight: FontWeight.w400)),
                            const SizedBox(height: 6),
                            Text(e.product!.discountRate.toString() == '' ? '해당 상품에 대한 설명이 없습니다' : e.product!.discountRate.toString(),
                                style: TextStyle(fontSize: 18, color: StaticColor.recommendedTextColor, fontWeight: FontWeight.w700),
                                overflow: TextOverflow.ellipsis),
                            /// 반올림 처리, 천의자리 쉼표 구분, 추후 변경
                            Text(NumberFormat('###,###,###,###').format(double.parse(e.product!.originPrice!).round()) + '원',
                                style: TextStyle(fontSize: 16, color: StaticColor.recommendedTextColor01, fontWeight: FontWeight.w400)),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset('assets/recommended_event/empty_image_planner.png', width: 20, height: 20),
                            const SizedBox(width: 4),
                            Text(e.planner.toString() == '' || e.planner == null ? '플래너 미상' : e.planner.toString(), style: TextStyle(fontSize: 12, color: StaticColor.recommendedTextColor01, fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    width: 24.01,
                    height: 23.99,
                    child: GestureDetector(
                      onTap: () {
                        likeState[index!][models.indexOf(e)] = !likeState[index][models.indexOf(e)];
                        context.read<RecommendedEventProvider>().tagSelect(recommendModels[index], index);
                      },
                      child: SizedBox(
                          width: 24.01,
                          height: 23.99,
                          child: Icon(
                            likeState[index!][models.indexOf(e)] ? Icons.favorite : Icons.favorite_border,
                            color: likeState[index][models.indexOf(e)] ? Colors.red : StaticColor.recommendedLikeBorderColor,
                            size: 18.01,
                          ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            selectState[index][models.indexOf(e)] == false ?
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
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(color: StaticColor.recommendedBoxColor, width: 1),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      shadowColor: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          selectState[index][models.indexOf(e)] = !selectState[index][models.indexOf(e)];
                          selectModels[index].contains(e) == false ? {
                            selectModels[index].add(e),
                            recommendModels[index].remove(e),
                            // selectState[index].removeAt(models.indexOf(e)),
                            // likeState[index].removeAt(models.indexOf(e)),
                          } : {};
                          context.read<RecommendedEventProvider>().tagSelect(recommendModels[index], index);
                          },
                        child: Center(child: Text('선택하기', style: TextStyle(fontSize: 12, color: StaticColor.recommendedBoxColor, fontWeight: FontWeight.w500))),
                      ),
                    ),
                  ),
                ),
              ],
            ) :
            Material(
              color: Colors.transparent,
              shadowColor: Colors.transparent,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: StaticColor.errorBackgroundColor,
                  borderRadius: BorderRadius.circular(4.0),
                  // border: Border.all(color: StaticColor.recommendedBoxColor, width: 0),
                ),
                child: Material(
                  color: Colors.transparent,
                  shadowColor: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      selectState[index][models.indexOf(e)] = !selectState[index][models.indexOf(e)];
                      selectModels[index].contains(e) == true ? selectModels[index].remove(e) : {};
                      context.read<RecommendedEventProvider>().tagSelect(recommendModels[index], index);
                    },
                    child: Center(child: Text('취소하기', style: TextStyle(fontSize: 12, color: StaticColor.errorColor, fontWeight: FontWeight.w400))),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
      );
    }).toList();

    return Column(
      children: [
        listType == 'mine' && selectModels[index!].isNotEmpty ? Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                Text('나의 선택', style: TextStyle(fontSize: 16, color: StaticColor.recommendedTextColor, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
              ],
            ),
        ) : const SizedBox.shrink(),
        listType == 'recommend' && recommendModels[index!].isNotEmpty ? Align(
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              Text('받은 추천', style: TextStyle(fontSize: 16, color: StaticColor.recommendedTextColor, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
            ],
          ),
        ) : const SizedBox.shrink(),
        Column(
          children: modelWidgets,
        ),
      ],
    );
  }

  Widget Loading() {
    return SizedBox(
        width: double.infinity,
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(height: 250),
              Image.asset('assets/recommended_event/searching.png', width: 40, height: 40),
              const SizedBox(height: 24),
              Text('플래너가 추천 할 상품을 찾는 중이예요.', style: TextStyle(fontSize: 14, color: StaticColor.recommendedSearchingTextColor, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: oneBuildFuture(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        } else if(snapshot.connectionState == ConnectionState.done) {
          print('rebuild!!');
          /// init view
          return itemSection();
        } else {
          return Loading();
        }
      },
    );
  }

  Future oneBuildFuture() => futureMemoizer.runOnce(() async => {
    serverRecommendModels = await RecommendedApi().getRecommendList(''),
    await Future.delayed(const Duration(milliseconds: 1500))
  });
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

  /// 기존 like button -> ripple effect wipe & tap range change
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleLike,
      child: Container(
        width: 24.01,
        height: 23.99,
        child: Icon(
          isLiked ? Icons.favorite : Icons.favorite_border,
          color: isLiked ? Colors.red : StaticColor.recommendedLikeBorderColor,
          size: 18.01,
        ),
      ),
    );
  }
}