import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/models/preference/preference_repository.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';
import 'package:sense_flutter_application/views/my_page/my_page_provider.dart';
import 'package:sense_flutter_application/views/preference/preference_provider.dart';
import 'package:sense_flutter_application/views/preference/travel/travel_step01.dart';
import 'package:sense_flutter_application/views/preference/travel/travel_step02.dart';
import 'package:sense_flutter_application/views/preference/travel/travel_step03.dart';
import 'package:sense_flutter_application/views/preference/travel/travel_step04.dart';
import 'package:sense_flutter_application/views/preference/travel/travel_step05.dart';
import 'package:sense_flutter_application/views/preference/travel/travel_step06.dart';

class TravelPreferenceScreen extends StatefulWidget {
  const TravelPreferenceScreen({super.key});

  @override
  State<TravelPreferenceScreen> createState() => _TravelPreferenceScreenState();
}

class _TravelPreferenceScreenState extends State<TravelPreferenceScreen> {
  @override
  void initState() {
    super.initState();

    context.read<PreferenceProvider>().resetTravelPreference();
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
            TravelPreferenceHeader(),
            TravelPreferenceContent(),
            TravelPreferenceBottomButton(),
          ],
        ),
      ),
    );
  }
}

class TravelPreferenceHeader extends StatefulWidget {
  const TravelPreferenceHeader({super.key});

  @override
  State<TravelPreferenceHeader> createState() => _TravelPreferenceHeader();
}

class _TravelPreferenceHeader extends State<TravelPreferenceHeader> {
  @override
  Widget build(BuildContext context) {
    List<bool> stepGuide = List.generate(6, (index) => false);

    int step = context.select<PreferenceProvider, int>((value) => value.step);
    for (int i = 0; i < step; i++) {
      stepGuide[i] = true;
    }

    return Column(
      children: [
        HeaderMenu(
          backCallback: stepController,
          title: '여행 취향',
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
      context.read<PreferenceProvider>().resetTravelPreference();
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

class TravelPreferenceContent extends StatefulWidget {
  const TravelPreferenceContent({super.key});

  @override
  State<TravelPreferenceContent> createState() => _TravelPreferenceContent();
}

class _TravelPreferenceContent extends State<TravelPreferenceContent> {
  @override
  Widget build(BuildContext context) {
    int step = context.select<PreferenceProvider, int>((value) => value.step);

    return Expanded(
      child: switch (step) {
        1 => const TravelStep01(),
        2 => const TravelStep02(),
        3 => const TravelStep03(),
        4 => const TravelStep04(),
        5 => const TravelStep05(),
        6 => const TravelStep06(),
        _ => const SizedBox.shrink(),
      },
    );
  }
}

class TravelPreferenceBottomButton extends StatefulWidget {
  const TravelPreferenceBottomButton({super.key});

  @override
  State<TravelPreferenceBottomButton> createState() => _TravelPreferenceBottomButton();
}

class _TravelPreferenceBottomButton extends State<TravelPreferenceBottomButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double safeBottomPadding = MediaQuery.of(context).padding.bottom;

    return Consumer<PreferenceProvider>(
      builder: (context, data, child) {
        int step = data.step;
        int price = data.travelPrice;
        bool limitTravelPrice = data.limitTravelPrice;
        List<int> travelDistanceList = data.travelDistanceList;
        List<int> travelEnvironmentList = data.travelEnvironmentList;
        List<int> travelMateList = data.travelMateList;
        String travelLikeMemo = data.travelLikeMemo;

        bool buttonDisabled = false;

        switch (step) {
          case 1:
            (!limitTravelPrice && price == 0) ? buttonDisabled = true : buttonDisabled = false;
            break;
          case 2:
            travelDistanceList.isEmpty ? buttonDisabled = true : buttonDisabled = false;
            break;
          case 3:
            travelEnvironmentList.isEmpty ? buttonDisabled = true : buttonDisabled = false;
            break;
          case 4:
            travelMateList.isEmpty ? buttonDisabled = true : buttonDisabled = false;
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

            context.read<PreferenceProvider>().saveTravelPreference().then((_) {
              PreferenceRepository()
                  .getUserPreferenceListByUserId(id: PresentUserInfo.id)
                  .then((preferenceList) {
                context
                    .read<MyPageProvider>()
                    .initUserPreferenceList(preferenceList: preferenceList);
                context.read<PreferenceProvider>().resetTravelPreference();
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
          if (step == 5 && travelLikeMemo == '') return '건너뛰기';
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
