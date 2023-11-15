import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/models/preference/preference_repository.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';
import 'package:sense_flutter_application/views/my_page/my_page_provider.dart';
import 'package:sense_flutter_application/views/preference/food/food_step01.dart';
import 'package:sense_flutter_application/views/preference/food/food_step02.dart';
import 'package:sense_flutter_application/views/preference/food/food_step03.dart';
import 'package:sense_flutter_application/views/preference/food/food_step04.dart';
import 'package:sense_flutter_application/views/preference/food/food_step05.dart';
import 'package:sense_flutter_application/views/preference/food/food_step06.dart';
import 'package:sense_flutter_application/views/preference/food/food_step07.dart';
import 'package:sense_flutter_application/views/preference/preference_provider.dart';

class FoodPreferenceScreen extends StatefulWidget {
  const FoodPreferenceScreen({super.key});

  @override
  State<FoodPreferenceScreen> createState() => _FoodPreferenceScreenState();
}

class _FoodPreferenceScreenState extends State<FoodPreferenceScreen> {
  @override
  void initState() {
    super.initState();

    context.read<PreferenceProvider>().resetFoodPreference();
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
            FoodPreferenceHeader(),
            FoodPreferenceContent(),
            FoodPreferenceBottomButton(),
          ],
        ),
      ),
    );
  }
}

class FoodPreferenceHeader extends StatefulWidget {
  const FoodPreferenceHeader({super.key});

  @override
  State<FoodPreferenceHeader> createState() => _FoodPreferenceHeader();
}

class _FoodPreferenceHeader extends State<FoodPreferenceHeader> {
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
          title: '음식 취향',
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
      context.read<PreferenceProvider>().resetFoodPreference();
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

class FoodPreferenceContent extends StatefulWidget {
  const FoodPreferenceContent({super.key});

  @override
  State<FoodPreferenceContent> createState() => _FoodPreferenceContent();
}

class _FoodPreferenceContent extends State<FoodPreferenceContent> {
  @override
  Widget build(BuildContext context) {
    int step = context.select<PreferenceProvider, int>((value) => value.step);

    return Expanded(
      child: switch (step) {
        1 => const FoodStep01(),
        2 => const FoodStep02(),
        3 => const FoodStep03(),
        4 => const FoodStep04(),
        5 => const FoodStep05(),
        6 => const FoodStep06(),
        7 => const FoodStep07(),
        _ => const SizedBox.shrink(),
      },
    );
  }
}

class FoodPreferenceBottomButton extends StatefulWidget {
  const FoodPreferenceBottomButton({super.key});

  @override
  State<FoodPreferenceBottomButton> createState() => _FoodPreferenceBottomButton();
}

class _FoodPreferenceBottomButton extends State<FoodPreferenceBottomButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double safeBottomPadding = MediaQuery.of(context).padding.bottom;

    return Consumer<PreferenceProvider>(
      builder: (context, data, child) {
        int step = data.step;
        int price = data.foodPrice;
        bool limitFoodPrice = data.limitFoodPrice;
        List<int> foodList = data.foodList;
        List<int> spicyList = data.spicyList;
        List<int> sweetList = data.sweetList;
        List<int> saltyList = data.saltyList;
        String foodLikeMemo = data.foodLikeMemo;

        bool buttonDisabled = false;

        switch (step) {
          case 1:
            (!limitFoodPrice && price == 0) ? buttonDisabled = true : buttonDisabled = false;
            break;
          case 2:
            foodList.isEmpty ? buttonDisabled = true : buttonDisabled = false;
            break;
          case 3:
            spicyList.isEmpty ? buttonDisabled = true : buttonDisabled = false;
            break;
          case 4:
            sweetList.isEmpty ? buttonDisabled = true : buttonDisabled = false;
            break;
          case 5:
            saltyList.isEmpty ? buttonDisabled = true : buttonDisabled = false;
            break;
          case 6:
            buttonDisabled = false;
            break;
          case 7:
            buttonDisabled = false;
            break;
          default:
        }

        void onTap() {
          if (buttonDisabled) return;

          if (step == 7) {
            if (isLoading) return;

            setState(() {
              isLoading = true;
            });

            context.read<PreferenceProvider>().saveFoodPreference().then((value1) {
              PreferenceRepository()
                  .getUserPreferenceListByUserId(id: PresentUserInfo.id)
                  .then((value2) {
                context.read<MyPageProvider>().initUserPreferenceList(preferenceList: value2);

                context.read<PreferenceProvider>().resetFoodPreference();
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
          if (step == 7) return '완료';
          if (step == 6 && foodLikeMemo == '') return '건너뛰기';
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
                            height: 24 / 16,
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
