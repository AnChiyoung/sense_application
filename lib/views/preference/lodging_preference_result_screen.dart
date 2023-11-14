import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/models/preference/preference_model.dart';
import 'package:sense_flutter_application/models/preference/preference_repository.dart';
import 'package:sense_flutter_application/views/preference/preference_provider.dart';
import 'package:sense_flutter_application/views/preference/widgets/preference_item_card.dart';

class LodgingPreferenceResultScreen extends StatefulWidget {
  const LodgingPreferenceResultScreen({super.key});

  @override
  State<LodgingPreferenceResultScreen> createState() => _LodgingPreferenceResultScreenState();
}

class _LodgingPreferenceResultScreenState extends State<LodgingPreferenceResultScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LodgingResultHeader(
              title: '숙소 취향',
            ),
            LodgingResultView(),
            LodgingResultBottomButton()
          ],
        ),
      ),
    );
  }
}

class LodgingResultHeader extends StatelessWidget {
  final String title;
  const LodgingResultHeader({
    super.key,
    this.title = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0.h,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: StaticColor.grey200EE,
            width: 1.0,
          ),
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.0.sp,
                  fontWeight: FontWeight.w500,
                  height: 24 / 16,
                  color: StaticColor.black90015,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12.0.w,
                vertical: 10.0.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _backButton(context: context),
                  _shareButton(context: context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _shareButton({required BuildContext context}) {
    void onTap() {}

    return SizedBox(
      width: 40.0.h,
      height: 40.0.h,
      child: IconButton(
        splashRadius: 20.0.r,
        padding: EdgeInsets.zero,
        onPressed: onTap,
        icon: Image.asset(
          'assets/icons/share.png',
          width: 24.0.h,
          height: 24.0.h,
        ),
      ),
    );
  }

  Widget _backButton({required BuildContext context}) {
    void onTap() {
      Navigator.pop(context);
    }

    return SizedBox(
      width: 40.0.h,
      height: 40.0.h,
      child: IconButton(
        splashRadius: 20.0.r,
        padding: EdgeInsets.zero,
        onPressed: onTap,
        icon: Image.asset(
          'assets/store/back_arrow_thin.png',
          width: 24.0.h,
          height: 24.0.h,
        ),
      ),
    );
  }

  // Material(
  //   borderRadius: BorderRadius.circular(25.0),
  //   clipBehavior: Clip.hardEdge,
  //   color: Colors.transparent,
  //   child: InkWell(
  //     onTap: onTap,
  //     child: Center(
  //       child: Image.asset(
  //         'assets/store/back_arrow_thin.png',
  //         width: 24.w,
  //         height: 24.h,
  //       ),
  //     ),
  //   ),
  // ),
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
            context.read<PreferenceProvider>().initLodgingPreference(preference: snapshot.data!);
            final lodgingPreference = context.read<PreferenceProvider>().lodgingPreference!;

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
                      lodgingPreference.title,
                      style: TextStyle(
                        fontSize: 14.0.sp,
                        height: 20 / 14,
                        color: StaticColor.grey70055,
                      ),
                    ),
                    SizedBox(height: 8.0.h),
                    Text(
                      lodgingPreference.content,
                      style: TextStyle(
                        fontSize: 14.0.sp,
                        height: 20 / 14,
                        color: StaticColor.grey70055,
                      ),
                    ),
                    SizedBox(height: 24.0.h),
                    PreferenceElementSection(
                      title: '선호하는 숙소 종류 순위',
                      list: lodgingPreference.types,
                    ),
                    PreferenceElementSection(
                      title: '선호하는 숙소 취향 순위',
                      list: lodgingPreference.environments,
                    ),
                    PreferenceElementSection(
                      title: '선호하는 숙소 편의 순위',
                      list: lodgingPreference.options,
                    ),
                    if (lodgingPreference.likeMemo != '') ...[
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
                      Text(lodgingPreference.likeMemo),
                      SizedBox(height: 24.0.h),
                    ],
                    if (lodgingPreference.dislikeMemo != '') ...[
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
                      Text(lodgingPreference.dislikeMemo),
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

class LodgingResultBottomButton extends StatelessWidget {
  const LodgingResultBottomButton({super.key});

  @override
  Widget build(BuildContext context) {
    double safeBottomPadding = MediaQuery.of(context).padding.bottom;

    void onTap() {}

    return SizedBox(
      width: double.infinity,
      height: 56.0.h + safeBottomPadding,
      child: Material(
        color: StaticColor.mainSoft,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.only(bottom: safeBottomPadding),
            child: Center(
              child: Text(
                '다시하기',
                style: TextStyle(
                  fontSize: 16.0.sp,
                  fontWeight: FontWeight.w700,
                  height: 24 / 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
