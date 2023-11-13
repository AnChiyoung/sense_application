import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/models/preference/preference_model.dart';
import 'package:sense_flutter_application/models/preference/preference_repository.dart';
import 'package:sense_flutter_application/models/taste/taste_model.dart';
import 'package:sense_flutter_application/screens/personal_taste/personal_taste_food_result_screen.dart';
import 'package:sense_flutter_application/screens/personal_taste/personal_taste_food_screen.dart';
import 'package:sense_flutter_application/views/my_page/my_page_liked_post_list.dart';
import 'package:shimmer/shimmer.dart';

class MyPageTab extends StatefulWidget {
  const MyPageTab({super.key});

  @override
  State<MyPageTab> createState() => _MyPageTabState();
}

class _MyPageTabState extends State<MyPageTab> with TickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: TabBar(
            controller: controller,
            labelColor: StaticColor.mainSoft,
            labelStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
            unselectedLabelColor: StaticColor.grey70055,
            unselectedLabelStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            indicatorWeight: 3.0.h,
            indicatorColor: StaticColor.mainSoft,
            automaticIndicatorColorAdjustment: false,
            tabs: [
              SizedBox(
                height: 40.0.h,
                child: const Tab(text: '게시글'),
              ),
              // SizedBox(
              //   height: 40.0.h,
              //   child: const Tab(
              //       text: '상품'
              //   ),
              // ),
              SizedBox(
                height: 40.0.h,
                child: const Tab(text: '취향'),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 1,
          decoration: BoxDecoration(
            color: StaticColor.grey200EE,
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: const [
              MyPageLikedPostList(),
              // Container(
              //     child: Center(child: Text('아직 상품이 없습니다', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey50099, fontWeight: FontWeight.w400)))
              // ),
              PreferenceList(),
              // SingleChildScrollView(child: Container(height: 400, child: Center(child: Text('아직 게시글이 없습니다', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey50099, fontWeight: FontWeight.w400))))),
              // SingleChildScrollView(child: Container(height: 400, child: Center(child: Text('아직 등록된 상품이 없습니다', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey50099, fontWeight: FontWeight.w400))))),
              // Expanded(child: PersonalTasteFoodBanner()),
              // Padding(
              //   padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
              //   child: SizedBox(
              //     width: double.infinity,
              //     child: Column(
              //       children: [
              //
              //         // PersonalTasteLodgingBanner(),
              //         // PersonalTasteTravelBanner(),
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ],
    );
  }
}

class PreferenceList extends StatefulWidget {
  const PreferenceList({super.key});

  @override
  State<PreferenceList> createState() => PreferenceListState();
}

class PreferenceListState extends State<PreferenceList> {
  late Future<List<UserPreferenceListItemModel>> loadPreferenceList;

  @override
  void initState() {
    super.initState();
    loadPreferenceList =
        PreferenceRepository().getUserPreferenceListByUserId(id: PresentUserInfo.id);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0.w,
          vertical: 16.0.h,
        ),
        child: FutureBuilder(
          future: loadPreferenceList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  _skeletonPreferenceCard(),
                  SizedBox(height: 16.0.h),
                  _skeletonPreferenceCard(),
                  SizedBox(height: 16.0.h),
                  _skeletonPreferenceCard(),
                  SizedBox(height: 16.0.h),
                ],
              );
            }

            if (snapshot.hasError) {
              return const SizedBox.shrink();
            }

            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
              List<UserPreferenceListItemModel> list = snapshot.data!;

              return Column(
                children: [
                  _generatePreferenceCard(preferenceList: list, type: EnumPreferenceType.food),
                  SizedBox(height: 16.0.h),
                  _generatePreferenceCard(preferenceList: list, type: EnumPreferenceType.lodging),
                  SizedBox(height: 16.0.h),
                  _generatePreferenceCard(preferenceList: list, type: EnumPreferenceType.travel),
                  SizedBox(height: 16.0.h),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _generatePreferenceCard({
    required List<UserPreferenceListItemModel> preferenceList,
    required EnumPreferenceType type,
  }) {
    UserPreferenceListItemModel? item =
        preferenceList.where((item) => item.type == type).firstOrNull;
    return item == null ? _emptyPreferenceCard(preferenceType: type) : _preferenceCard(item: item);
    // return _emptyPreferenceCard(preferenceType: type);
  }

  Container _preferenceCardContainer({required Widget child, Clip clipBehavior = Clip.none}) {
    return Container(
      width: double.infinity,
      height: 80.0.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0.r),
        color: StaticColor.grey100F6,
      ),
      clipBehavior: clipBehavior,
      child: child,
    );
  }

  Widget _emptyPreferenceCard({required EnumPreferenceType preferenceType}) {
    void onTapEmptyCard(EnumPreferenceType preferenceType) {
      print(preferenceType.value);
    }

    return _preferenceCardContainer(
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 2.0.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Text(
                      preferenceType.value,
                      style: TextStyle(
                        fontSize: 12.0.sp,
                        color: StaticColor.grey70055,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '여행 취향이 아직 없습니다.',
                        style: TextStyle(
                          fontSize: 12.0.sp,
                          color: StaticColor.grey400BB,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '설정하기',
                            style: TextStyle(
                              fontSize: 12.0.sp,
                              color: StaticColor.grey80033,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                            ),
                          ),
                          SizedBox(width: 4.0.w),
                          Image.asset(
                            'assets/taste/right_arrow.png',
                            width: 16.0.w,
                            height: 16.0.h,
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onTapEmptyCard(preferenceType),
                child: const SizedBox.shrink(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _preferenceCard({required UserPreferenceListItemModel item}) {
    void onTapCard(EnumPreferenceType preferenceType) {
      print(preferenceType.value);
    }

    return _preferenceCardContainer(
      clipBehavior: Clip.hardEdge,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned.fill(
            child: Image(
              image: NetworkImage('${item.imageUrl}?'),
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0.0, 64 / 80],
                  colors: [
                    StaticColor.black90015.withOpacity(1),
                    StaticColor.black90015.withOpacity(0),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0.w,
                vertical: 16.0.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 2.0.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Text(
                      item.type.value,
                      style: TextStyle(
                        fontSize: 12.0.sp,
                        color: StaticColor.grey70055,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                  ),
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 12.0.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onTapCard(item.type),
                child: const SizedBox.shrink(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _skeletonPreferenceCard() {
    return _preferenceCardContainer(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
        child: Shimmer.fromColors(
          baseColor: StaticColor.grey300E0,
          highlightColor: StaticColor.grey200EE,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 45.0.w,
                height: 22.0.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22.0.r),
                  color: Colors.white,
                ),
              ),
              Container(
                width: double.infinity,
                height: 18.0.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0.r),
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PersonalTasteFoodBanner extends StatefulWidget {
  const PersonalTasteFoodBanner({super.key});

  @override
  State<PersonalTasteFoodBanner> createState() => _PersonalTasteFoodBannerState();
}

class _PersonalTasteFoodBannerState extends State<PersonalTasteFoodBanner> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: TasteRequest().loadFoodPreference(PresentUserInfo.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox.shrink();
            } else if (snapshot.connectionState == ConnectionState.done) {
              FoodTasteModel bannerModels = snapshot.data ?? FoodTasteModel();

              if (bannerModels == null) {
                return const EmptyFoodBanner();
              } else {
                /// 선택한 음식 취향이 있을 때
                return Column(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => FoodResultScreen(
                                    resultModel: bannerModels,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              // height: 100,
                              padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: const DecorationImage(
                                  image: AssetImage('assets/my_page/food_background.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 4.0.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Text('음식',
                                        style: TextStyle(
                                            fontSize: 12.0.sp,
                                            color: StaticColor.grey70055,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                  SizedBox(height: 10.0.h),
                                  Text(bannerModels.title!,
                                      style: TextStyle(
                                          fontSize: 12.0.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // PersonalTasteLodgingBanner(),
                    // PersonalTasteTravelBanner(),
                  ],
                );
              }
            } else {
              return const SizedBox.shrink();
            }
          } else if (snapshot.hasError) {
            return const SizedBox.shrink();
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}

class PersonalTasteLodgingBanner extends StatelessWidget {
  const PersonalTasteLodgingBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: TasteRequest().loadLodgingPreference(PresentUserInfo.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox.shrink();
            } else if (snapshot.connectionState == ConnectionState.done) {
              // FoodTasteModel bannerModels = snapshot.data ?? FoodTasteModel();

              if (snapshot.data == null) {
                return const EmptyLodgingBanner();
              } else {
                // 선택한 숙소 취향이 있을 때
                return Column(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (_) => FoodResultScreen(resultModel: bannerModels,)));
                            },
                            child: Container(
                              width: double.infinity,
                              // height: 100,
                              padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: const DecorationImage(
                                  image: AssetImage('assets/my_page/lodging_background.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 4.0.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Text('숙소',
                                        style: TextStyle(
                                            fontSize: 12.0.sp,
                                            color: StaticColor.grey70055,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                  SizedBox(height: 10.0.h),
                                  Text('도심속 힐링공간 마스터',
                                      style: TextStyle(
                                          fontSize: 12.0.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // PersonalTasteLodgingBanner(),
                    // PersonalTasteTravelBanner(),
                  ],
                );
              }
            } else {
              return const SizedBox.shrink();
            }
          } else if (snapshot.hasError) {
            return const SizedBox.shrink();
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}

class PersonalTasteTravelBanner extends StatelessWidget {
  const PersonalTasteTravelBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: TasteRequest().loadTravelPreference(PresentUserInfo.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox.shrink();
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null) {
                return const EmptyTravelBanner();
              } else {
                /// 선택한 여행 취향이 있을 때
                return Column(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (_) => FoodResultScreen(resultModel: bannerModels,)));
                            },
                            child: Container(
                              width: double.infinity,
                              // height: 100,
                              padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: const DecorationImage(
                                  image: AssetImage('assets/my_page/travel_background.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 4.0.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Text('여행',
                                        style: TextStyle(
                                            fontSize: 12.0.sp,
                                            color: StaticColor.grey70055,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                  SizedBox(height: 10.0.h),
                                  Text('소중한 이들과 떠나요',
                                      style: TextStyle(
                                          fontSize: 12.0.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // PersonalTasteLodgingBanner(),
                    // PersonalTasteTravelBanner(),
                  ],
                );
              }
            } else {
              return const SizedBox.shrink();
            }
          } else if (snapshot.hasError) {
            return const SizedBox.shrink();
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}

class EmptyFoodBanner extends StatefulWidget {
  const EmptyFoodBanner({super.key});

  @override
  State<EmptyFoodBanner> createState() => _EmptyFoodBannerState();
}

class _EmptyFoodBannerState extends State<EmptyFoodBanner> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const PersonalTasteFoodScreen()));
        },
        child: Container(
          width: double.infinity,
          // height: 100,
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: StaticColor.grey100F6,
            // color: Colors.green,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 4.0.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Text('음식',
                    style: TextStyle(
                        fontSize: 12.0.sp,
                        color: StaticColor.grey70055,
                        fontWeight: FontWeight.w400)),
              ),
              SizedBox(height: 10.0.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('음식 취향이 아직 없습니다.',
                      style: TextStyle(
                          fontSize: 12.0.sp,
                          color: StaticColor.grey400BB,
                          fontWeight: FontWeight.w400)),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('설정하기',
                          style: TextStyle(
                              fontSize: 12.0.sp,
                              color: StaticColor.black90015,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center),
                      Image.asset('assets/taste/right_arrow.png', width: 16.0.w, height: 16.0.h),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyLodgingBanner extends StatefulWidget {
  const EmptyLodgingBanner({super.key});

  @override
  State<EmptyLodgingBanner> createState() => _EmptyLodgingBannerState();
}

class _EmptyLodgingBannerState extends State<EmptyLodgingBanner> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
      child: GestureDetector(
        onTap: () {
          // Navigator.push(context, MaterialPageRoute(builder: (_) => FoodResultScreen(resultModel: bannerModels,)));
        },
        child: Container(
          width: double.infinity,
          // height: 100,
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: StaticColor.grey100F6,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 4.0.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Text('숙소',
                    style: TextStyle(
                        fontSize: 12.0.sp,
                        color: StaticColor.grey70055,
                        fontWeight: FontWeight.w400)),
              ),
              SizedBox(height: 10.0.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('숙소 취향이 아직 없습니다.',
                      style: TextStyle(
                          fontSize: 12.0.sp,
                          color: StaticColor.grey400BB,
                          fontWeight: FontWeight.w400)),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('설정하기',
                          style: TextStyle(
                              fontSize: 12.0.sp,
                              color: StaticColor.black90015,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center),
                      Image.asset('assets/taste/right_arrow.png', width: 16.0.w, height: 16.0.h),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyTravelBanner extends StatefulWidget {
  const EmptyTravelBanner({super.key});

  @override
  State<EmptyTravelBanner> createState() => _EmptyTravelBannerState();
}

class _EmptyTravelBannerState extends State<EmptyTravelBanner> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
      child: GestureDetector(
        onTap: () {
          // Navigator.push(context, MaterialPageRoute(builder: (_) => FoodResultScreen(resultModel: bannerModels,)));
        },
        child: Container(
          width: double.infinity,
          // height: 100,
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: StaticColor.grey100F6,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 4.0.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Text('여행',
                    style: TextStyle(
                        fontSize: 12.0.sp,
                        color: StaticColor.grey70055,
                        fontWeight: FontWeight.w400)),
              ),
              SizedBox(height: 10.0.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('여행 취향이 아직 없습니다.',
                      style: TextStyle(
                          fontSize: 12.0.sp,
                          color: StaticColor.grey400BB,
                          fontWeight: FontWeight.w400)),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('설정하기',
                          style: TextStyle(
                              fontSize: 12.0.sp,
                              color: StaticColor.black90015,
                              fontWeight: FontWeight.w400)),
                      Image.asset('assets/taste/right_arrow.png', width: 16.0.w, height: 16.0.h),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
