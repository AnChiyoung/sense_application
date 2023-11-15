import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/models/preference/preference_model.dart';
import 'package:sense_flutter_application/models/preference/preference_repository.dart';
import 'package:sense_flutter_application/views/preference/preference_provider.dart';
import 'package:sense_flutter_application/views/preference/travel_preference_screen.dart';
import 'package:sense_flutter_application/views/preference/widgets/preference_element_card.dart';
import 'package:sense_flutter_application/views/preference/widgets/preference_result_bottom_button.dart';
import 'package:sense_flutter_application/views/preference/widgets/preference_result_header.dart';

class TravelPreferenceResultScreen extends StatefulWidget {
  const TravelPreferenceResultScreen({super.key});

  @override
  State<TravelPreferenceResultScreen> createState() => _TravelPreferenceResultScreenState();
}

class _TravelPreferenceResultScreenState extends State<TravelPreferenceResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            const PreferenceResultHeader(title: '여행 취향'),
            const TravelResultView(),
            PreferenceResultBottomButton(
              title: '다시하기',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TravelPreferenceScreen(),
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

class TravelResultView extends StatefulWidget {
  const TravelResultView({super.key});

  @override
  State<TravelResultView> createState() => _TravelResultViewState();
}

class _TravelResultViewState extends State<TravelResultView> {
  late Future<UserTravelPreferenceResultModel?> loadTravelPreference;

  @override
  void initState() {
    super.initState();

    loadTravelPreference =
        PreferenceRepository().getUserTravelPreferenceByUserId(id: PresentUserInfo.id);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: loadTravelPreference,
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
                .initTravelPreferenceResult(preferenceResult: snapshot.data!);
            final travelPreferenceResult =
                context.read<PreferenceProvider>().travelPreferenceResult!;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 24.0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${PresentUserInfo.username}님의 여행 취향',
                      style: TextStyle(
                        fontSize: 18.0.sp,
                        fontWeight: FontWeight.w700,
                        height: 28 / 18,
                        color: StaticColor.grey80033,
                      ),
                    ),
                    SizedBox(height: 8.0.h),
                    Text(
                      travelPreferenceResult.title,
                      style: TextStyle(
                        fontSize: 14.0.sp,
                        height: 20 / 14,
                        color: StaticColor.grey70055,
                      ),
                    ),
                    SizedBox(height: 8.0.h),
                    Text(
                      travelPreferenceResult.content,
                      style: TextStyle(
                        fontSize: 14.0.sp,
                        height: 20 / 14,
                        color: StaticColor.grey70055,
                      ),
                    ),
                    SizedBox(height: 24.0.h),
                    PreferenceElementSection(
                      title: '선호하는 여행 거리',
                      list: travelPreferenceResult.distances,
                    ),
                    PreferenceElementSection(
                      title: '함께하고 싶은 지인 순위',
                      list: travelPreferenceResult.mates,
                    ),
                    PreferenceElementSection(
                      title: '선호하는 여행지 유형 순위',
                      list: travelPreferenceResult.environments,
                    ),
                    if (travelPreferenceResult.likeMemo != '') ...[
                      Text(
                        '좋아하는 여행지',
                        style: TextStyle(
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.w700,
                          height: 24 / 16,
                          color: StaticColor.grey80033,
                        ),
                      ),
                      SizedBox(height: 8.0.h),
                      Text(travelPreferenceResult.likeMemo),
                      SizedBox(height: 24.0.h),
                    ],
                    if (travelPreferenceResult.dislikeMemo != '') ...[
                      Text(
                        '싫어하는 여행지',
                        style: TextStyle(
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.w700,
                          height: 24 / 16,
                          color: StaticColor.grey80033,
                        ),
                      ),
                      SizedBox(height: 8.0.h),
                      Text(travelPreferenceResult.dislikeMemo),
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
}
