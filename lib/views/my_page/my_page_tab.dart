import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/models/preference/preference_model.dart';
import 'package:sense_flutter_application/models/preference/preference_repository.dart';
import 'package:sense_flutter_application/views/my_page/my_page_liked_post_list.dart';
import 'package:sense_flutter_application/views/my_page/my_page_provider.dart';
import 'package:sense_flutter_application/views/preference/food_preference_result_screen.dart';
import 'package:sense_flutter_application/views/preference/lodging_preference_result_screen.dart';
import 'package:sense_flutter_application/views/preference/travel_preference_result_screen.dart';
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
              MyPagePreferenceBannerList(),
            ],
          ),
        ),
      ],
    );
  }
}

class MyPagePreferenceBannerList extends StatefulWidget {
  const MyPagePreferenceBannerList({super.key});

  @override
  State<MyPagePreferenceBannerList> createState() => MyPagePreferenceBannerListState();
}

class MyPagePreferenceBannerListState extends State<MyPagePreferenceBannerList> {
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
              context.read<MyPageProvider>().initUserPreferenceList(preferenceList: snapshot.data!);

              return Column(
                children: [
                  _generatePreferenceCard(context: context, type: EnumPreferenceType.food),
                  SizedBox(height: 16.0.h),
                  _generatePreferenceCard(context: context, type: EnumPreferenceType.lodging),
                  SizedBox(height: 16.0.h),
                  _generatePreferenceCard(context: context, type: EnumPreferenceType.travel),
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
    required BuildContext context,
    required EnumPreferenceType type,
  }) {
    UserPreferenceListItemModel? Function(MyPageProvider value) selectCallback;

    switch (type) {
      case EnumPreferenceType.food:
        selectCallback = (MyPageProvider value) => value.foodPreference;
        break;

      case EnumPreferenceType.lodging:
        selectCallback = (MyPageProvider value) => value.lodgingPreference;
        break;

      case EnumPreferenceType.travel:
        selectCallback = (MyPageProvider value) => value.travelPreference;
        break;
    }

    UserPreferenceListItemModel? item =
        context.select<MyPageProvider, UserPreferenceListItemModel?>(selectCallback);
    return item == null ? _emptyPreferenceCard(preferenceType: type) : _preferenceCard(item: item);
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
    void onTapEmptyCard(EnumPreferenceType preferenceType) {}

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
      late Widget widgetToPush;

      switch (preferenceType) {
        case EnumPreferenceType.food:
          widgetToPush = const FoodPreferenceResultScreen();
          break;
        case EnumPreferenceType.lodging:
          widgetToPush = const LodgingPreferenceResultScreen();
          break;
        case EnumPreferenceType.travel:
          widgetToPush = const TravelPreferenceResultScreen();
          break;
        default:
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => widgetToPush,
        ),
      );
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
