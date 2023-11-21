import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/models/preference/preference_model.dart';
import 'package:sense_flutter_application/models/preference/preference_repository.dart';
import 'package:sense_flutter_application/views/preference/food_preference_screen.dart';
import 'package:sense_flutter_application/views/preference/preference_provider.dart';
import 'package:sense_flutter_application/views/preference/widgets/preference_element_card.dart';
import 'package:sense_flutter_application/views/preference/widgets/preference_result_bottom_button.dart';
import 'package:sense_flutter_application/views/preference/widgets/preference_result_header.dart';

class FoodPreferenceResultScreen extends StatefulWidget {
  const FoodPreferenceResultScreen({super.key});

  @override
  State<FoodPreferenceResultScreen> createState() => _FoodPreferenceResultScreenState();
}

class _FoodPreferenceResultScreenState extends State<FoodPreferenceResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            const PreferenceResultHeader(title: '음식 취향'),
            const FoodResultView(),
            PreferenceResultBottomButton(
              title: '다시하기',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FoodPreferenceScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FoodResultView extends StatefulWidget {
  const FoodResultView({super.key});

  @override
  State<FoodResultView> createState() => _FoodResultViewState();
}

class _FoodResultViewState extends State<FoodResultView> {
  late Future<UserFoodPreferenceResultModel?> loadFoodPreference;

  @override
  void initState() {
    super.initState();

    loadFoodPreference =
        PreferenceRepository().getUserFoodPreferenceByUserId(id: PresentUserInfo.id);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: loadFoodPreference,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              padding: EdgeInsets.only(bottom: 200.0.h),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.hasError) {
            return const SizedBox.shrink();
          }

          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            context
                .read<PreferenceProvider>()
                .initFoodPreferenceResult(preferenceResult: snapshot.data!);
            final foodPreferenceResult = context.read<PreferenceProvider>().foodPreferenceResult!;

            int getMaxLevel({required List<UserFoodPreferenceTaste> list}) {
              final v1 = list.map((item) => (item.id - 1) % 5);

              if (v1.isNotEmpty) {
                return v1.reduce((a, b) => a < b ? a : b);
              }
              return 0;
            }

            int spicyMaxLevel = getMaxLevel(list: foodPreferenceResult.spicyTastes);
            int sweetMaxLevel = getMaxLevel(list: foodPreferenceResult.sweetTastes);
            int saltyMaxLevel = getMaxLevel(list: foodPreferenceResult.saltyTastes);

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 24.0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // head
                    Text(
                      '${PresentUserInfo.username}님의 음식 취향',
                      style: TextStyle(
                        fontSize: 18.0.sp,
                        fontWeight: FontWeight.w700,
                        height: 28 / 18,
                        color: StaticColor.grey80033,
                      ),
                    ),
                    SizedBox(height: 8.0.h),

                    // title
                    Text(
                      foodPreferenceResult.title,
                      style: TextStyle(
                        fontSize: 14.0.sp,
                        height: 20 / 14,
                        color: StaticColor.grey70055,
                      ),
                    ),
                    SizedBox(height: 8.0.h),

                    // content
                    Text(
                      foodPreferenceResult.content,
                      style: TextStyle(
                        fontSize: 14.0.sp,
                        height: 20 / 14,
                        color: StaticColor.grey70055,
                      ),
                    ),

                    SizedBox(height: 24.0.h),

                    _tasteLevel(
                      context: context,
                      title: '매운맛',
                      maxLevel: spicyMaxLevel,
                      onImage: 'assets/preference/spicy_on.png',
                      offImage: 'assets/preference/spicy_off.png',
                    ),
                    SizedBox(height: 8.0.h),
                    _tasteLevel(
                      context: context,
                      title: '단맛',
                      maxLevel: sweetMaxLevel,
                      onImage: 'assets/preference/sweet_on.png',
                      offImage: 'assets/preference/sweet_off.png',
                    ),
                    SizedBox(height: 8.0.h),
                    _tasteLevel(
                      context: context,
                      title: '짠만',
                      maxLevel: saltyMaxLevel,
                      onImage: 'assets/preference/salty_on.png',
                      offImage: 'assets/preference/salty_off.png',
                    ),

                    SizedBox(height: 24.0.h),
                    PreferenceElementSection(
                      title: '선호하는 음식 순위',
                      list: foodPreferenceResult.foods,
                    ),
                    if (foodPreferenceResult.likeMemo != '') ...[
                      Text(
                        '좋아하는 음식',
                        style: TextStyle(
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.w700,
                          height: 24 / 16,
                          color: StaticColor.grey80033,
                        ),
                      ),
                      SizedBox(height: 8.0.h),
                      Text(foodPreferenceResult.likeMemo),
                      SizedBox(height: 24.0.h),
                    ],
                    if (foodPreferenceResult.dislikeMemo != '') ...[
                      Text(
                        '싫어하는 음식',
                        style: TextStyle(
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.w700,
                          height: 24 / 16,
                          color: StaticColor.grey80033,
                        ),
                      ),
                      SizedBox(height: 8.0.h),
                      Text(foodPreferenceResult.dislikeMemo),
                      SizedBox(height: 24.0.h),
                    ],
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _tasteLevel({
    required BuildContext context,
    required String title,
    required int maxLevel,
    required String onImage,
    required String offImage,
  }) {
    final fiveLengthList = List.generate(5, (index) => index);

    return Container(
      width: 200.0.w,
      height: 32.0.h,
      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
      decoration: BoxDecoration(
        color: StaticColor.grey100F6,
        borderRadius: BorderRadius.circular(4.0.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.0.sp,
              fontWeight: FontWeight.w700,
              height: 18 / 12,
              color: StaticColor.grey70055,
            ),
          ),
          Row(
            children: [
              ...fiveLengthList.expand(
                (step) {
                  List<Widget> ret = [];

                  String imageSource = step < maxLevel ? offImage : onImage;
                  ret.add(
                    Image.asset(
                      imageSource,
                      width: 20.0.h,
                      height: 20.0.h,
                    ),
                  );

                  if (step < fiveLengthList.length - 1) ret.add(SizedBox(width: 8.0.w));

                  return ret;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
