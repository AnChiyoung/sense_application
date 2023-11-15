import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/taste/taste_model.dart';
import 'package:sense_flutter_application/screens/my_page/my_page_screen.dart';
import 'package:sense_flutter_application/views/personal_taste/food/food_step01.dart';
import 'package:sense_flutter_application/views/personal_taste/food/food_step02.dart';
import 'package:sense_flutter_application/views/personal_taste/food/food_step03.dart';
import 'package:sense_flutter_application/views/personal_taste/food/food_step04.dart';
import 'package:sense_flutter_application/views/personal_taste/food/food_step05.dart';
import 'package:sense_flutter_application/views/personal_taste/food/food_step06.dart';
import 'package:sense_flutter_application/views/personal_taste/food/food_step07.dart';
import 'package:sense_flutter_application/views/personal_taste/taste_provider.dart';

class FoodContent extends StatefulWidget {
  const FoodContent({super.key});

  @override
  State<FoodContent> createState() => _FoodContentState();
}

class _FoodContentState extends State<FoodContent> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TasteProvider>(builder: (context, data, child) {
      int step = data.presentStep;

      if (step == 1) {
        return const FoodStep01();
      } else if (step == 2) {
        return const FoodStep02();
      } else if (step == 3) {
        return const FoodStep03();
      } else if (step == 4) {
        return const FoodStep04();
      } else if (step == 5) {
        return const FoodStep05();
      } else if (step == 6) {
        return const FoodStep06();
      } else if (step == 7) {
        return const FoodStep07();
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}

class FoodButton extends StatefulWidget {
  const FoodButton({super.key});

  @override
  State<FoodButton> createState() => _FoodButtonState();
}

class _FoodButtonState extends State<FoodButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TasteProvider>(builder: (context, data, child) {
      int priceState = data.foodPrice;
      List<bool> foodSelector = data.foodSelector;
      List<bool> spicySelector = data.spicySelector;
      List<bool> candySelector = data.candySelector;
      List<bool> saltySelector = data.saltySelector;
      String foodStep06 = data.foodStep06;
      String foodStep07 = data.foodStep07;
      int step = data.presentStep;
      bool buttonState = false;

      if (step == 1) {
        priceState == 0 ? buttonState = false : buttonState = true;
      } else if (step == 2) {
        foodSelector.contains(true) ? buttonState = true : buttonState = false;
      } else if (step == 3) {
        spicySelector.contains(true) ? buttonState = true : buttonState = false;
      } else if (step == 4) {
        candySelector.contains(true) ? buttonState = true : buttonState = false;
      } else if (step == 5) {
        saltySelector.contains(true) ? buttonState = true : buttonState = false;
      } else if (step == 6) {
        buttonState = true;
      } else if (step == 7) {
        buttonState = true;
        // foodStep07.isEmpty ? buttonState = false : buttonState = true;
      }

      return SizedBox(
        width: double.infinity,
        height: 76,
        child: ElevatedButton(
            onPressed: () async {
              if (buttonState == true) {
                if (step == 7) {
                  bool foodTasteInputResult =
                      await TasteRequest().createFoodTastePreference(context);
                  context.read<TasteProvider>().foodTasteInit();
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const MyPageScreen()));
                } else {
                  context.read<TasteProvider>().presentStepChange(step + 1);
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
                      child: Text(step == 7 ? '완료' : '다음',
                          style: TextStyle(
                              fontSize: 16.0.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w700)))),
            ])),
      );
    });
  }
}
