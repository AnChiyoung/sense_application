import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/add_event/add_event_model.dart';
import 'package:sense_flutter_application/public_widget/add_event_cancel_dialog.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';
import 'package:sense_flutter_application/screens/recommended_event/price_select_screen.dart';
import 'package:sense_flutter_application/views/recommended_event/recommended_event_provider.dart';

class RecommendedEventHeaderMenu extends StatefulWidget {
  const RecommendedEventHeaderMenu({Key? key}) : super(key: key);

  @override
  State<RecommendedEventHeaderMenu> createState() => _RecommendedEventHeaderMenuState();
}

class _RecommendedEventHeaderMenuState extends State<RecommendedEventHeaderMenu> {
  @override
  Widget build(BuildContext context) {
    return HeaderMenu(title: '이벤트 생성', closeCallback: closeCallback);
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

class RecommendedEventTitle extends StatelessWidget {
  const RecommendedEventTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('무엇이\n필요하신가요?', style: TextStyle(fontSize: 24, color: StaticColor.addEventTitleColor, fontWeight: FontWeight.w500), textAlign: TextAlign.left),
          ],
        )
    );
  }
}

class RecommendedEventCategory extends StatefulWidget {
  const RecommendedEventCategory({Key? key}) : super(key: key);

  @override
  State<RecommendedEventCategory> createState() => _RecommendedEventCategoryState();
}

class _RecommendedEventCategoryState extends State<RecommendedEventCategory> {
  bool present = false, hotel = false, lunch = false, dinner = false, activity = false, pub = false;

  bool buttonStateCheck() {
    return present || hotel || lunch || dinner || activity || pub;
  }

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
                    height: 88,
                    decoration: BoxDecoration(
                      color: StaticColor.categoryUnselectedColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            present = !present;
                            buttonStateCheck() == true ? {context.read<RecommendedEventProvider>().nextButtonState(true), AddEventModel.eventRecommendedModel = '선물'} : {context.read<RecommendedEventProvider>().nextButtonState(false), AddEventModel.eventRecommendedModel = ''};
                          });
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: present == true ? StaticColor.categorySelectedColor : StaticColor.categoryUnselectedColor, elevation: 0.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/recommended_event/present.png', width: 28, height: 32, color: present == true ? Colors.white : Colors.black),
                              const SizedBox(
                                  height: 12
                              ),
                              Text('선물', style: TextStyle(fontSize: 13, color: present == true ? Colors.white : StaticColor.addEventFontColor, fontWeight: FontWeight.w700)),
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
                    height: 88,
                    decoration: BoxDecoration(
                      color: StaticColor.categoryUnselectedColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            hotel = !hotel;
                            buttonStateCheck() == true ? {context.read<RecommendedEventProvider>().nextButtonState(true), AddEventModel.eventRecommendedModel = '호텔'} : {context.read<RecommendedEventProvider>().nextButtonState(false), AddEventModel.eventRecommendedModel = ''};
                          });
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: hotel == true ? StaticColor.categorySelectedColor : StaticColor.categoryUnselectedColor, elevation: 0.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/recommended_event/hotel.png', width: 33, height: 32, color: hotel == true ? Colors.white : Colors.black),
                              const SizedBox(
                                  height: 12
                              ),
                              Text('호텔', style: TextStyle(fontSize: 13, color: hotel == true ? Colors.white : StaticColor.addEventFontColor, fontWeight: FontWeight.w700)),
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
                    height: 88,
                    decoration: BoxDecoration(
                      color: StaticColor.categoryUnselectedColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            lunch = !lunch;
                            buttonStateCheck() == true ? {context.read<RecommendedEventProvider>().nextButtonState(true), AddEventModel.eventRecommendedModel = '점심'} : {context.read<RecommendedEventProvider>().nextButtonState(false), AddEventModel.eventRecommendedModel = ''};
                          });
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: lunch == true ? StaticColor.categorySelectedColor : StaticColor.categoryUnselectedColor, elevation: 0.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/recommended_event/lunch.png', width: 35, height: 32, color: lunch == true ? Colors.white : Colors.black),
                              const SizedBox(
                                  height: 12
                              ),
                              Text('점심', style: TextStyle(fontSize: 13, color: lunch == true ? Colors.white : StaticColor.addEventFontColor, fontWeight: FontWeight.w700)),
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
                    height: 88,
                    decoration: BoxDecoration(
                      color: StaticColor.categoryUnselectedColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            dinner = !dinner;
                            buttonStateCheck() == true ? {context.read<RecommendedEventProvider>().nextButtonState(true), AddEventModel.eventRecommendedModel = '저녁'} : {context.read<RecommendedEventProvider>().nextButtonState(false), AddEventModel.eventRecommendedModel = ''};
                          });
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: dinner == true ? StaticColor.categorySelectedColor : StaticColor.categoryUnselectedColor, elevation: 0.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/recommended_event/dinner.png', width: 32, height: 32, color: dinner == true ? Colors.white : Colors.black),
                              const SizedBox(
                                  height: 12
                              ),
                              Text('저녁', style: TextStyle(fontSize: 13, color: dinner == true ? Colors.white : StaticColor.addEventFontColor, fontWeight: FontWeight.w700)),
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
                    height: 88,
                    decoration: BoxDecoration(
                      color: StaticColor.categoryUnselectedColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            activity = !activity;
                            buttonStateCheck() == true ? {context.read<RecommendedEventProvider>().nextButtonState(true), AddEventModel.eventRecommendedModel = '액티비티'} : {context.read<RecommendedEventProvider>().nextButtonState(false), AddEventModel.eventRecommendedModel = ''};
                          });
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: activity == true ? StaticColor.categorySelectedColor : StaticColor.categoryUnselectedColor, elevation: 0.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/recommended_event/activity.png', width: 32, height: 32, color: activity == true ? Colors.white : Colors.black),
                              const SizedBox(
                                  height: 12
                              ),
                              Text('액티비티', style: TextStyle(fontSize: 13, color: activity == true ? Colors.white : StaticColor.addEventFontColor, fontWeight: FontWeight.w700)),
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
                    height: 88,
                    decoration: BoxDecoration(
                      color: StaticColor.categoryUnselectedColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            pub = !pub;
                            buttonStateCheck() == true ? {context.read<RecommendedEventProvider>().nextButtonState(true), AddEventModel.eventRecommendedModel = '술집'} : {context.read<RecommendedEventProvider>().nextButtonState(false), AddEventModel.eventRecommendedModel = ''};
                          });
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: pub == true ? StaticColor.categorySelectedColor : StaticColor.categoryUnselectedColor, elevation: 0.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/recommended_event/pub.png', width: 32, height: 37, color: pub == true ? Colors.white : Colors.black),
                              const SizedBox(
                                  height: 12
                              ),
                              Text('술집', style: TextStyle(fontSize: 13, color: pub == true ? Colors.white : StaticColor.addEventFontColor, fontWeight: FontWeight.w700)),
                            ]
                        )
                    ),
                  ),
                ),
              ]
          ),
        ],
      ),
    );
  }
}

class RecommendedEventNextButton extends StatefulWidget {
  const RecommendedEventNextButton({Key? key}) : super(key: key);

  @override
  State<RecommendedEventNextButton> createState() => _RecommendedEventNextButtonState();
}

class _RecommendedEventNextButtonState extends State<RecommendedEventNextButton> {

  Future backButtonAction(BuildContext context) async {
    context.read<RecommendedEventProvider>().nextButtonReset();
  }

  @override
  Widget build(BuildContext context) {

    final buttonEnabled = context.watch<RecommendedEventProvider>().buttonState;

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
              buttonEnabled == true ? Navigator.push(context, MaterialPageRoute(builder: (context) => PriceSelectScreen())) : (){};
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
