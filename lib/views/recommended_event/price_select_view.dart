import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/public_widget/add_event_cancel_dialog.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';
import 'package:sense_flutter_application/screens/recommended_event/region_select_screen.dart';
import 'package:sense_flutter_application/views/recommended_event/recommended_event_provider.dart';

class PriceSelectHeaderMenu extends StatefulWidget {
  const PriceSelectHeaderMenu({Key? key}) : super(key: key);

  @override
  State<PriceSelectHeaderMenu> createState() => _PriceSelectHeaderMenuState();
}

class _PriceSelectHeaderMenuState extends State<PriceSelectHeaderMenu> {
  @override
  Widget build(BuildContext context) {
    return HeaderMenu(backCallback: backCallback, title: '선물', closeCallback: closeCallback);
  }

  void backCallback() {
    Navigator.of(context).pop();
    context.read<RecommendedEventProvider>().priceNextButtonReset();
  }

  void closeCallback() {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const AddEventCancelDialog();
        });
  }
}

class PriceSelectTitle extends StatelessWidget {
  const PriceSelectTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('최대 예산을\n선택해 주세요', style: TextStyle(fontSize: 24, color: StaticColor.addEventTitleColor, fontWeight: FontWeight.w500), textAlign: TextAlign.left),
          ],
        )
    );
  }
}

class PriceSelectCategory extends StatefulWidget {
  const PriceSelectCategory({Key? key}) : super(key: key);

  @override
  State<PriceSelectCategory> createState() => _PriceSelectCategoryState();
}

class _PriceSelectCategoryState extends State<PriceSelectCategory> {
  bool price01 = false, price02 = false, price03 = false, price04 = false, price05 = false, price06 = false, price07 = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: StaticColor.categoryUnselectedColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            price01 = true;
                            price02 = false;
                            price03 = false;
                            price04 = false;
                            price05 = false;
                            price06 = false;
                            price07 = false;
                            context.read<RecommendedEventProvider>().priceNextButtonState(true);
                          });
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: price01 == true ? StaticColor.categorySelectedColor : StaticColor.categoryUnselectedColor, elevation: 0.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('5만원 이하', style: TextStyle(fontSize: 13, color: price01 == true ? Colors.white : StaticColor.addEventFontColor, fontWeight: FontWeight.w700)),
                            ]
                        )
                    ),
                  ),
                ),
                const SizedBox(
                    width: 12
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: StaticColor.categoryUnselectedColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            price01 = false;
                            price02 = true;
                            price03 = false;
                            price04 = false;
                            price05 = false;
                            price06 = false;
                            price07 = false;
                            context.read<RecommendedEventProvider>().priceNextButtonState(true);
                          });
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: price02 == true ? StaticColor.categorySelectedColor : StaticColor.categoryUnselectedColor, elevation: 0.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('10만원 이하', style: TextStyle(fontSize: 13, color: price02 == true ? Colors.white : StaticColor.addEventFontColor, fontWeight: FontWeight.w700)),
                            ]
                        )

                    ),
                  ),
                ),
              ]
          ),
          const SizedBox(
              height: 12
          ),
          Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: StaticColor.categoryUnselectedColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            price01 = false;
                            price02 = false;
                            price03 = true;
                            price04 = false;
                            price05 = false;
                            price06 = false;
                            price07 = false;
                            context.read<RecommendedEventProvider>().priceNextButtonState(true);
                          });
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: price03 == true ? StaticColor.categorySelectedColor : StaticColor.categoryUnselectedColor, elevation: 0.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('15만원 이하', style: TextStyle(fontSize: 13, color: price03 == true ? Colors.white : StaticColor.addEventFontColor, fontWeight: FontWeight.w700)),
                            ]
                        )
                    ),
                  ),
                ),
                const SizedBox(
                    width: 12
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: StaticColor.categoryUnselectedColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            price01 = false;
                            price02 = false;
                            price03 = false;
                            price04 = true;
                            price05 = false;
                            price06 = false;
                            price07 = false;
                            context.read<RecommendedEventProvider>().priceNextButtonState(true);
                          });
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: price04 == true ? StaticColor.categorySelectedColor : StaticColor.categoryUnselectedColor, elevation: 0.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('20만원 이하', style: TextStyle(fontSize: 13, color: price04 == true ? Colors.white : StaticColor.addEventFontColor, fontWeight: FontWeight.w700)),
                            ]
                        )

                    ),
                  ),
                ),
              ]
          ),
          const SizedBox(
              height: 12
          ),
          Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: StaticColor.categoryUnselectedColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            price01 = false;
                            price02 = false;
                            price03 = false;
                            price04 = false;
                            price05 = true;
                            price06 = false;
                            price07 = false;
                            context.read<RecommendedEventProvider>().priceNextButtonState(true);
                          });
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: price05 == true ? StaticColor.categorySelectedColor : StaticColor.categoryUnselectedColor, elevation: 0.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('25만원 이하', style: TextStyle(fontSize: 13, color: price05 == true ? Colors.white : StaticColor.addEventFontColor, fontWeight: FontWeight.w700)),
                            ]
                        )
                    ),
                  ),
                ),
                const SizedBox(
                    width: 12
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: StaticColor.categoryUnselectedColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            price01 = false;
                            price02 = false;
                            price03 = false;
                            price04 = false;
                            price05 = false;
                            price06 = true;
                            price07 = false;
                            context.read<RecommendedEventProvider>().priceNextButtonState(true);
                          });
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: price06 == true ? StaticColor.categorySelectedColor : StaticColor.categoryUnselectedColor, elevation: 0.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('30만원 이하', style: TextStyle(fontSize: 13, color: price06 == true ? Colors.white : StaticColor.addEventFontColor, fontWeight: FontWeight.w700)),
                            ]
                        )
                    ),
                  ),
                ),
              ]
          ),
          const SizedBox(
              height: 12
          ),
          Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: StaticColor.categoryUnselectedColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            price01 = false;
                            price02 = false;
                            price03 = false;
                            price04 = false;
                            price05 = false;
                            price06 = false;
                            price07 = true;
                            context.read<RecommendedEventProvider>().priceNextButtonState(true);
                          });
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: price07 == true ? StaticColor.categorySelectedColor : StaticColor.categoryUnselectedColor, elevation: 0.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('제한없음', style: TextStyle(fontSize: 13, color: price07 == true ? Colors.white : StaticColor.addEventFontColor, fontWeight: FontWeight.w700)),
                            ]
                        )
                    ),
                  ),
                ),
                const SizedBox(
                    width: 12
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                  // child: Container(
                  //   height: 88,
                  //   decoration: BoxDecoration(
                  //     color: StaticColor.categoryUnselectedColor,
                  //     borderRadius: BorderRadius.circular(8.0),
                  //   ),
                  // ),
                ),
              ]
          ),
        ],
      ),
    );
  }
}

class PriceSelectNextButton extends StatefulWidget {
  const PriceSelectNextButton({Key? key}) : super(key: key);

  @override
  State<PriceSelectNextButton> createState() => _PriceSelectNextButtonState();
}

class _PriceSelectNextButtonState extends State<PriceSelectNextButton> {

  Future backButtonAction(BuildContext context) async {
    context.read<RecommendedEventProvider>().priceNextButtonReset();
  }

  @override
  Widget build(BuildContext context) {

    final buttonEnabled = context.watch<RecommendedEventProvider>().priceNextButton;

    return WillPopScope(
      onWillPop: () async {
        await backButtonAction(context);
        return true;
      },
      child: SizedBox(
        width: double.infinity,
        height: 76,
        child: ElevatedButton(
            onPressed: () {
              buttonEnabled == true ? Navigator.push(context, MaterialPageRoute(builder: (context) => RegionSelectScreen())) : (){};
            },
            style: ElevatedButton.styleFrom(backgroundColor: buttonEnabled == true ? StaticColor.categorySelectedColor : StaticColor.unSelectedColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  SizedBox(height: 56, child: Center(child: Text('다음', style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w700)))),
                ]
            )
        ),
      ),
    );
  }
}
