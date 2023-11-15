import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/models/preference/preference_repository.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';
import 'package:sense_flutter_application/views/my_page/my_page_provider.dart';
import 'package:sense_flutter_application/views/preference/lodging/lodging_step01.dart';
import 'package:sense_flutter_application/views/preference/lodging/lodging_step02.dart';
import 'package:sense_flutter_application/views/preference/lodging/lodging_step03.dart';
import 'package:sense_flutter_application/views/preference/lodging/lodging_step04.dart';
import 'package:sense_flutter_application/views/preference/lodging/lodging_step05.dart';
import 'package:sense_flutter_application/views/preference/lodging/lodging_step06.dart';
import 'package:sense_flutter_application/views/preference/preference_provider.dart';

class LodgingPreferenceScreen extends StatefulWidget {
  const LodgingPreferenceScreen({super.key});

  @override
  State<LodgingPreferenceScreen> createState() => _LodgingPreferenceScreenState();
}

class _LodgingPreferenceScreenState extends State<LodgingPreferenceScreen> {
  @override
  void initState() {
    super.initState();

    context.read<PreferenceProvider>().resetLodgingPreference();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LodgingPreferenceHeader(),
            LodgingPreferenceContent(),
            LodgingPreferenceBottomButton(),
          ],
        ),
      ),
    );
  }
}

class LodgingPreferenceHeader extends StatefulWidget {
  const LodgingPreferenceHeader({super.key});

  @override
  State<LodgingPreferenceHeader> createState() => _LodgingPreferenceHeader();
}

class _LodgingPreferenceHeader extends State<LodgingPreferenceHeader> {
  @override
  Widget build(BuildContext context) {
    List<bool> stepGuide = [false, false, false, false, false, false, false];

    int step = context.select<PreferenceProvider, int>((value) => value.step);
    for (int i = 0; i < step; i++) {
      stepGuide[i] = true;
    }

    return Column(
      children: [
        HeaderMenu(
          backCallback: stepController,
          title: '숙소 취향',
          rightMenu: temperatureSave(),
        ),
        Container(
          width: double.infinity,
          height: 1.0.h,
          color: StaticColor.grey300E0,
        ),
        Row(
          children: [
            ...stepGuide.map(
              (isActive) => Flexible(
                flex: 1,
                child: Container(
                  height: 3.0.h,
                  color: isActive == true ? StaticColor.mainSoft : Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void stepController() {
    int step = context.read<PreferenceProvider>().step;
    if (step == 1) {
      context.read<PreferenceProvider>().resetLodgingPreference();
      Navigator.of(context).pop();
    } else {
      context.read<PreferenceProvider>().prevStep(notify: true);
    }
  }

  Widget temperatureSave() {
    return SizedBox(
      width: 40.0.h,
      height: 40.0.h,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(25.0.r),
          child: Center(
            child: Text(
              '저장',
              style: TextStyle(
                fontSize: 16.0.sp,
                color: StaticColor.mainSoft,
                fontWeight: FontWeight.w700,
                height: 28 / 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LodgingPreferenceContent extends StatefulWidget {
  const LodgingPreferenceContent({super.key});

  @override
  State<LodgingPreferenceContent> createState() => _LodgingPreferenceContent();
}

class _LodgingPreferenceContent extends State<LodgingPreferenceContent> {
  @override
  Widget build(BuildContext context) {
    int step = context.select<PreferenceProvider, int>((value) => value.step);

    return Expanded(
      child: switch (step) {
        1 => const LodgingStep01(),
        2 => const LodgingStep02(),
        3 => const LodgingStep03(),
        4 => const LodgingStep04(),
        5 => const LodgingStep05(),
        6 => const LodgingStep06(),
        _ => const SizedBox.shrink(),
      },
    );
  }
}

class LodgingPreferenceBottomButton extends StatefulWidget {
  const LodgingPreferenceBottomButton({super.key});

  @override
  State<LodgingPreferenceBottomButton> createState() => _LodgingPreferenceBottomButton();
}

class _LodgingPreferenceBottomButton extends State<LodgingPreferenceBottomButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double safeBottomPadding = MediaQuery.of(context).padding.bottom;

    return Consumer<PreferenceProvider>(
      builder: (context, data, child) {
        int step = data.step;
        int price = data.lodgingPrice;
        bool limitLodgingPrice = data.limitLodgingPrice;
        List<int> lodgingTypeList = data.lodgingTypeList;
        List<int> lodgingEnvironmentList = data.lodgingEnvironmentList;
        List<int> lodgingOptionList = data.lodgingOptionList;
        String lodgingLikeMemo = data.lodgingLikeMemo;

        bool buttonDisabled = false;

        switch (step) {
          case 1:
            (!limitLodgingPrice && price == 0) ? buttonDisabled = true : buttonDisabled = false;
            break;
          case 2:
            lodgingTypeList.isEmpty ? buttonDisabled = true : buttonDisabled = false;
            break;
          case 3:
            lodgingEnvironmentList.isEmpty ? buttonDisabled = true : buttonDisabled = false;
            break;
          case 4:
            lodgingOptionList.isEmpty ? buttonDisabled = true : buttonDisabled = false;
            break;
          case 5:
            buttonDisabled = false;
            break;
          case 6:
            buttonDisabled = false;
            break;
          default:
        }

        void onTap() {
          if (buttonDisabled) return;

          if (step == 6) {
            if (isLoading) return;

            setState(() {
              isLoading = true;
            });

            context.read<PreferenceProvider>().saveLodgingPreference().then((_) {
              PreferenceRepository()
                  .getUserPreferenceListByUserId(id: PresentUserInfo.id)
                  .then((preferenceList) {
                context
                    .read<MyPageProvider>()
                    .initUserPreferenceList(preferenceList: preferenceList);
                context.read<PreferenceProvider>().resetLodgingPreference();
                setState(() {
                  isLoading = false;
                });
                Navigator.of(context).pop();
              });
            });
          } else {
            context.read<PreferenceProvider>().nextStep(notify: true);
          }
        }

        getButtonLabel() {
          if (step == 6) return '완료';
          if (step == 5 && lodgingLikeMemo == '') return '건너뛰기';
          return '다음';
        }

        return SizedBox(
          width: double.infinity,
          height: 56.0.h + safeBottomPadding,
          child: Material(
            color: buttonDisabled ? StaticColor.grey400BB : StaticColor.mainSoft,
            child: InkWell(
              onTap: buttonDisabled ? null : onTap,
              child: Padding(
                padding: EdgeInsets.only(bottom: safeBottomPadding),
                child: Center(
                  child: isLoading
                      ? CircularProgressIndicator(
                          color: StaticColor.grey300E0,
                        )
                      : Text(
                          getButtonLabel(),
                          style: TextStyle(
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.w700,
                            // height: 24 / 16,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
