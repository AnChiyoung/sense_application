import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/models/preference/preference_model.dart';
import 'package:sense_flutter_application/models/preference/preference_repository.dart';
import 'package:sense_flutter_application/views/preference/preference_provider.dart';
import 'package:sense_flutter_application/views/preference/widgets/preference_element_card.dart';
import 'package:sense_flutter_application/views/preference/widgets/preference_result_bottom_button.dart';
import 'package:sense_flutter_application/views/preference/widgets/preference_result_header.dart';

class LodgingPreferenceResultScreen extends StatefulWidget {
  const LodgingPreferenceResultScreen({super.key});

  @override
  State<LodgingPreferenceResultScreen> createState() => _LodgingPreferenceResultScreenState();
}

class _LodgingPreferenceResultScreenState extends State<LodgingPreferenceResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            const PreferenceResultHeader(title: '숙소 취향'),
            const LodgingResultView(),
            PreferenceResultBottomButton(
              title: '다시하기',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class LodgingResultView extends StatefulWidget {
  const LodgingResultView({super.key});

  @override
  State<LodgingResultView> createState() => _LodgingResultViewState();
}

class _LodgingResultViewState extends State<LodgingResultView> {
  late Future<UserLodgingPreferenceResultModel?> loadLodgingPreference;

  @override
  void initState() {
    super.initState();

    loadLodgingPreference =
        PreferenceRepository().getUserLodgingPreferenceByUserId(id: PresentUserInfo.id);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: loadLodgingPreference,
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
                .initLodgingPreferenceResult(preferenceResult: snapshot.data!);
            final lodgingPreferenceResult =
                context.read<PreferenceProvider>().lodgingPreferenceResult!;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 24.0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${PresentUserInfo.username}님의 숙소 취향',
                      style: TextStyle(
                        fontSize: 18.0.sp,
                        fontWeight: FontWeight.w700,
                        height: 28 / 18,
                        color: StaticColor.grey80033,
                      ),
                    ),
                    SizedBox(height: 8.0.h),
                    Text(
                      lodgingPreferenceResult.title,
                      style: TextStyle(
                        fontSize: 14.0.sp,
                        height: 20 / 14,
                        color: StaticColor.grey70055,
                      ),
                    ),
                    SizedBox(height: 8.0.h),
                    Text(
                      lodgingPreferenceResult.content,
                      style: TextStyle(
                        fontSize: 14.0.sp,
                        height: 20 / 14,
                        color: StaticColor.grey70055,
                      ),
                    ),
                    SizedBox(height: 24.0.h),
                    PreferenceElementSection(
                      title: '선호하는 숙소 종류 순위',
                      list: lodgingPreferenceResult.types,
                    ),
                    PreferenceElementSection(
                      title: '선호하는 숙소 취향 순위',
                      list: lodgingPreferenceResult.environments,
                    ),
                    PreferenceElementSection(
                      title: '선호하는 숙소 편의 순위',
                      list: lodgingPreferenceResult.options,
                    ),
                    if (lodgingPreferenceResult.likeMemo != '') ...[
                      Text(
                        '좋아하는 숙소',
                        style: TextStyle(
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.w700,
                          height: 24 / 16,
                          color: StaticColor.grey80033,
                        ),
                      ),
                      SizedBox(height: 8.0.h),
                      Text(lodgingPreferenceResult.likeMemo),
                      SizedBox(height: 24.0.h),
                    ],
                    if (lodgingPreferenceResult.dislikeMemo != '') ...[
                      Text(
                        '싫어하는 숙소',
                        style: TextStyle(
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.w700,
                          height: 24 / 16,
                          color: StaticColor.grey80033,
                        ),
                      ),
                      SizedBox(height: 8.0.h),
                      Text(lodgingPreferenceResult.dislikeMemo),
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
