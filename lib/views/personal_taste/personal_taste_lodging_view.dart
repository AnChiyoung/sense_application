import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';
import 'package:sense_flutter_application/screens/personal_taste/personal_taste_travel_screen.dart';
import 'package:sense_flutter_application/views/personal_taste/lodging/lodging_step01.dart';
import 'package:sense_flutter_application/views/personal_taste/lodging/lodging_step02.dart';
import 'package:sense_flutter_application/views/personal_taste/lodging/lodging_step03.dart';
import 'package:sense_flutter_application/views/personal_taste/lodging/lodging_step04.dart';
import 'package:sense_flutter_application/views/personal_taste/lodging/lodging_step05.dart';
import 'package:sense_flutter_application/views/personal_taste/lodging/lodging_step06.dart';
import 'package:sense_flutter_application/views/personal_taste/taste_provider.dart';

class LodgingHeader extends StatefulWidget {
  const LodgingHeader({super.key});

  @override
  State<LodgingHeader> createState() => _LodgingHeaderState();
}

class _LodgingHeaderState extends State<LodgingHeader> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TasteProvider>(
        builder: (context, data, child) {

          List<bool> stepGuide = [false, false, false, false, false, false];
          for(int i = 0; i < data.lodgingPresentStep; i++) {
            stepGuide[i] = true;
          }

          return Column(
            children: [
              HeaderMenu(backCallback: stepController, title: '숙소 취향'),
              Container(
                width: double.infinity,
                height: 1.0.h,
                color: StaticColor. grey300E0,
              ),
              Row(
                children: [
                  Flexible(
                      flex: 1,
                      child: Container(
                        height: 3.0.h,
                        color: stepGuide[0] == true ? StaticColor.mainSoft : Colors.transparent,
                      )
                  ),
                  Flexible(
                      flex: 1,
                      child: Container(
                        height: 3.0.h,
                        color: stepGuide[1] == true ? StaticColor.mainSoft : Colors.transparent,
                      )
                  ),
                  Flexible(
                      flex: 1,
                      child: Container(
                        height: 3.0.h,
                        color: stepGuide[2] == true ? StaticColor.mainSoft : Colors.transparent,
                      )
                  ),
                  Flexible(
                      flex: 1,
                      child: Container(
                        height: 3.0.h,
                        color: stepGuide[3] == true ? StaticColor.mainSoft : Colors.transparent,
                      )
                  ),
                  Flexible(
                      flex: 1,
                      child: Container(
                        height: 3.0.h,
                        color: stepGuide[4] == true ? StaticColor.mainSoft : Colors.transparent,
                      )
                  ),
                  Flexible(
                      flex: 1,
                      child: Container(
                        height: 3.0.h,
                        color: stepGuide[5] == true ? StaticColor.mainSoft : Colors.transparent,
                      )
                  ),
                ],
              ),
            ],
          );
        }
    );
  }

  void stepController() {
    int step = context.read<TasteProvider>().lodgingPresentStep;
    if(step == 1) {
      Navigator.of(context).pop();
    } else {
      context.read<TasteProvider>().lodgingPresentStepChange(step - 1);
    }
  }
}

class LodgingContent extends StatefulWidget {
  double deviceWidth;
  LodgingContent({super.key, required this.deviceWidth});

  @override
  State<LodgingContent> createState() => _LodgingContentState();
}

class _LodgingContentState extends State<LodgingContent> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TasteProvider>(
        builder: (context, data, child) {

          int step = data.lodgingPresentStep;

          if(step == 1) {
            return LodgingStep01();
          } else if(step == 2) {
            return LodgingStep02(deviceWidth: widget.deviceWidth);
          } else if(step == 3) {
            return LodgingStep03(deviceWidth: widget.deviceWidth);
          } else if(step == 4) {
            return LodgingStep04(deviceWidth: widget.deviceWidth);
          } else if(step == 5) {
            return LodgingStep05();
          } else if(step == 6) {
            return LodgingStep06();
          } else {
            return const SizedBox.shrink();
          }
        }
    );
  }
}


class LodgingButton extends StatefulWidget {
  const LodgingButton({super.key});

  @override
  State<LodgingButton> createState() => _LodgingButtonState();
}

class _LodgingButtonState extends State<LodgingButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TasteProvider>(
        builder: (context, data, child) {

          int priceState = data.lodgingPrice;
          List<bool> lodgingSelector = data.lodgingSelector;
          List<bool> lodgingEnvSelector = data.lodgingEnvSelector;
          List<bool> lodgingToolSelector = data.lodgingToolSelector;
          String lodgingStep05 = data.lodgingStep05;
          String lodgingStep06 = data.lodgingStep06;
          int step = data.lodgingPresentStep;
          bool buttonState = false;

          if(step == 1) {
            priceState == 0 ? buttonState = false : buttonState = true;
          } else if(step == 2) {
            lodgingSelector.contains(true) ? buttonState = true : buttonState = false;
          } else if(step == 3) {
            lodgingEnvSelector.contains(true) ? buttonState = true : buttonState = false;
          } else if(step == 4) {
            lodgingToolSelector.contains(true) ? buttonState = true : buttonState = false;
          } else if(step == 5) {
            lodgingStep05.isEmpty ? buttonState = false : buttonState = true;
          } else if(step == 6) {
            lodgingStep06.isEmpty ? buttonState = false : buttonState = true;
          }

          return SizedBox(
            width: double.infinity,
            height: 76,
            child: ElevatedButton(
                onPressed: () {
                  if(buttonState == true) {
                    if(step == 6) {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => PersonalTasteTravelScreen()));
                    } else {
                      context.read<TasteProvider>().lodgingPresentStepChange(step + 1);
                    }
                  } else {}
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: buttonState == false
                        ? StaticColor.unSelectedColor
                        : StaticColor.categorySelectedColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
                child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SizedBox(
                      height: 56,
                      child: Center(
                          child: Text(step == 6 ? '완료' : '다음',
                              style: TextStyle(
                                  fontSize: 16.0.sp, color: Colors.white, fontWeight: FontWeight.w700)))),
                ])),
          );
        }
    );
  }
}
