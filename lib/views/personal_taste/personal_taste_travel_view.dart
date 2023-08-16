import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';
import 'package:sense_flutter_application/views/personal_taste/taste_provider.dart';
import 'package:sense_flutter_application/views/personal_taste/travel/travel_step01.dart';
import 'package:sense_flutter_application/views/personal_taste/travel/travel_step02.dart';
import 'package:sense_flutter_application/views/personal_taste/travel/travel_step03.dart';
import 'package:sense_flutter_application/views/personal_taste/travel/travel_step04.dart';
import 'package:sense_flutter_application/views/personal_taste/travel/travel_step05.dart';
import 'package:sense_flutter_application/views/personal_taste/travel/travel_step06.dart';

class TravelHeader extends StatefulWidget {
  const TravelHeader({super.key});

  @override
  State<TravelHeader> createState() => _TravelHeaderState();
}

class _TravelHeaderState extends State<TravelHeader> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TasteProvider>(
        builder: (context, data, child) {

          List<bool> stepGuide = [false, false, false, false, false, false];
          for(int i = 0; i < data.travelPresentStep; i++) {
            stepGuide[i] = true;
          }

          return Column(
            children: [
              HeaderMenu(backCallback: stepController, title: '여행 취향'),
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
    int step = context.read<TasteProvider>().travelPresentStep;
    if(step == 1) {
      Navigator.of(context).pop();
    } else {
      context.read<TasteProvider>().travelPresentStepChange(step - 1);
    }
  }
}

class TravelContent extends StatefulWidget {
  double deviceWidth;
  TravelContent({super.key, required this.deviceWidth});

  @override
  State<TravelContent> createState() => _TravelContentState();
}

class _TravelContentState extends State<TravelContent> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TasteProvider>(
        builder: (context, data, child) {

          int step = data.travelPresentStep;

          if(step == 1) {
            return TravelStep01();
          } else if(step == 2) {
            return TravelStep02();
          } else if(step == 3) {
            return TravelStep03(deviceWidth: widget.deviceWidth);
          } else if(step == 4) {
            return TravelStep04();
          } else if(step == 5) {
            return TravelStep05();
          } else if(step == 6) {
            return TravelStep06();
          } else {
            return const SizedBox.shrink();
          }
        }
    );
  }
}


class TravelButton extends StatefulWidget {
  const TravelButton({super.key});

  @override
  State<TravelButton> createState() => _TravelButtonState();
}

class _TravelButtonState extends State<TravelButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TasteProvider>(
        builder: (context, data, child) {

          int priceState = data.travelPrice;
          List<bool> distanceSelector = data.distanceSelector;
          List<bool> themeSelector = data.themeSelector;
          List<bool> peopleSelector = data.peopleSelector;
          String travelStep05 = data.travelStep05;
          String travelStep06 = data.travelStep06;
          int step = data.travelPresentStep;
          bool buttonState = false;

          if(step == 1) {
            priceState == 0 ? buttonState = false : buttonState = true;
          } else if(step == 2) {
            distanceSelector.contains(true) ? buttonState = true : buttonState = false;
          } else if(step == 3) {
            themeSelector.contains(true) ? buttonState = true : buttonState = false;
          } else if(step == 4) {
            peopleSelector.contains(true) ? buttonState = true : buttonState = false;
          } else if(step == 5) {
            travelStep05.isEmpty ? buttonState = false : buttonState = true;
          } else if(step == 6) {
            travelStep06.isEmpty ? buttonState = false : buttonState = true;
          }

          return SizedBox(
            width: double.infinity,
            height: 76,
            child: ElevatedButton(
                onPressed: () {
                  if(buttonState == true) {
                    if(step == 6) {
                      // Navigator.push(context, MaterialPageRoute(builder: (_) => PersonalTasteLodgingScreen()));
                    } else {
                      context.read<TasteProvider>().travelPresentStepChange(step + 1);
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
