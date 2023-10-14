import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/models/taste/taste_model.dart';
import 'package:sense_flutter_application/screens/personal_taste/personal_taste_food_result_screen.dart';
import 'package:sense_flutter_application/screens/personal_taste/personal_taste_food_screen.dart';

class MyPageTab extends StatefulWidget {
  const MyPageTab({super.key});

  @override
  State<MyPageTab> createState() => _MyPageTabState();
}

class _MyPageTabState extends State<MyPageTab> with TickerProviderStateMixin{

  late TabController controller;

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  controller: controller,
                  labelColor: StaticColor.mainSoft,
                  labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
                  unselectedLabelColor: StaticColor.grey70055,
                  indicatorWeight: 2,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(color: StaticColor.mainSoft, width: 3.0),
                  ),
                  unselectedLabelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                  tabs: [
                    SizedBox(
                      height: 37.0.h,
                      child: const Tab(
                          text: '게시글'
                      ),
                    ),
                    // SizedBox(
                    //   height: 37.0.h,
                    //   child: const Tab(
                    //       text: '상품'
                    //   ),
                    // ),
                    SizedBox(
                      height: 37.0.h,
                      child: const Tab(
                          text: '취향'
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 1.0.h,
          decoration: BoxDecoration(
            color: StaticColor.grey200EE,
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: [
              Container(
                child: Center(child: Text('아직 게시글이 없습니다', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey50099, fontWeight: FontWeight.w400)))
              ),
              // Container(
              //     child: Center(child: Text('아직 상품이 없습니다', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey50099, fontWeight: FontWeight.w400)))
              // ),
              Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 16.0.h),
                      PersonalTasteFoodBanner(),
                      // SizedBox(height: 16.0.h),
                      // PersonalTasteLodgingBanner(),
                      // SizedBox(height: 16.0.h),
                      // PersonalTasteTravelBanner(),
                    ],
                  ),
              ),
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
        if(snapshot.hasData) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox.shrink();
          } else if(snapshot.connectionState == ConnectionState.done) {

            FoodTasteModel bannerModels = snapshot.data ?? FoodTasteModel();

            if(bannerModels == null) {
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
                            Navigator.push(context, MaterialPageRoute(builder: (_) => FoodResultScreen(resultModel: bannerModels,)));
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
                                  padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 4.0.h),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Text('음식', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                                ),
                                SizedBox(height: 10.0.h),
                                Text(bannerModels.title!, style: TextStyle(fontSize: 12.0.sp, color: Colors.white, fontWeight: FontWeight.w400)),
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
        } else if(snapshot.hasError) {
          return const SizedBox.shrink();
        } else {
          return const SizedBox.shrink();
        }
      }
    );
  }
}

class PersonalTasteLodgingBanner extends StatelessWidget {
  const PersonalTasteLodgingBanner({super.key});

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: TasteRequest().loadLodgingPreference(PresentUserInfo.id),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox.shrink();
            } else if(snapshot.connectionState == ConnectionState.done) {

              // FoodTasteModel bannerModels = snapshot.data ?? FoodTasteModel();

              if(snapshot.data == null) {
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
                                    padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 4.0.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Text('숙소', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                                  ),
                                  SizedBox(height: 10.0.h),
                                  Text('도심속 힐링공간 마스터', style: TextStyle(fontSize: 12.0.sp, color: Colors.white, fontWeight: FontWeight.w400)),
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
          } else if(snapshot.hasError) {
            return const SizedBox.shrink();
          } else {
            return const SizedBox.shrink();
          }
        }
    );
  }
}

class PersonalTasteTravelBanner extends StatelessWidget {
  const PersonalTasteTravelBanner({super.key});

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: TasteRequest().loadTravelPreference(PresentUserInfo.id),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox.shrink();
            } else if(snapshot.connectionState == ConnectionState.done) {

              if(snapshot.data == null) {
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
                                    padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 4.0.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Text('여행', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                                  ),
                                  SizedBox(height: 10.0.h),
                                  Text('소중한 이들과 떠나요', style: TextStyle(fontSize: 12.0.sp, color: Colors.white, fontWeight: FontWeight.w400)),
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
          } else if(snapshot.hasError) {
            return const SizedBox.shrink();
          } else {
            return const SizedBox.shrink();
          }
        }
    );
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
          // Navigator.push(context, MaterialPageRoute(builder: (_) => FoodResultScreen(resultModel: bannerModels,)));
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
                child: Text('음식', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
              ),
              SizedBox(height: 10.0.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('음식 취향이 아직 없습니다.', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey400BB, fontWeight: FontWeight.w400)),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('설정하기', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w400), textAlign: TextAlign.center),
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
                child: Text('숙소', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
              ),
              SizedBox(height: 10.0.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('숙소 취향이 아직 없습니다.', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey400BB, fontWeight: FontWeight.w400)),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('설정하기', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w400), textAlign: TextAlign.center),
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
                child: Text('여행', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
              ),
              SizedBox(height: 10.0.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('여행 취향이 아직 없습니다.', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey400BB, fontWeight: FontWeight.w400)),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('설정하기', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w400)),
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
