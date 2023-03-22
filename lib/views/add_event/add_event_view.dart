import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/screens/add_event/with_person_list_screen.dart';

class HeaderMenu extends StatefulWidget {
  Function? backCallback;
  String? title;
  Function? closeCallback;
  HeaderMenu({Key? key, this.backCallback, this.title, this.closeCallback}) : super(key: key);

  @override
  State<HeaderMenu> createState() => _HeaderMenuState();
}

class _HeaderMenuState extends State<HeaderMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Stack(
        children: [
          widget.backCallback == null ? Container() : Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: GestureDetector(
                onTap: () {
                  widget.backCallback?.call();
                },
                child: Image.asset('assets/add_event/button_back.png', width: 24, height: 24),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(widget.title!, style: TextStyle(fontSize: 16, color: StaticColor.contactTextColor, fontWeight: FontWeight.w500)),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 18),
              child: GestureDetector(
                onTap: () {
                  widget.closeCallback?.call();
                },
                child: Image.asset('assets/add_event/button_close.png', width: 15.01, height: 14.96)
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CategoryHeaderMenu extends StatefulWidget {
  const CategoryHeaderMenu({Key? key}) : super(key: key);

  @override
  State<CategoryHeaderMenu> createState() => _CategoryHeaderMenuState();
}

class _CategoryHeaderMenuState extends State<CategoryHeaderMenu> {
  @override
  Widget build(BuildContext context) {
    return HeaderMenu(title: '이벤트 생성', closeCallback: closeCallback); // 왜 miss?
  }

  void closeCallback() {
    Navigator.of(context).pop();
    context.read<AddEventProvider>().nextButtonReset();
  }
}


class CategorySelectTitle extends StatefulWidget {
  const CategorySelectTitle({Key? key}) : super(key: key);

  @override
  State<CategorySelectTitle> createState() => _CategorySelectTitleState();
}

class _CategorySelectTitleState extends State<CategorySelectTitle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('유형을\n선택해주세요', style: TextStyle(fontSize: 24, color: StaticColor.addEventTitleColor, fontWeight: FontWeight.w500), textAlign: TextAlign.left),
          Container(
            width: 81,
            height: 32,
            decoration: BoxDecoration(
              color: StaticColor.categoryUnselectedColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const WithPersonScreen()));
              },
              style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categoryUnselectedColor, elevation: 0.0),
              child: Text('건너뛰기', style: TextStyle(fontSize: 13, color: StaticColor.addEventFontColor, fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      )
    );
  }
}

class CategorySelect extends StatefulWidget {
  const CategorySelect({Key? key}) : super(key: key);

  @override
  State<CategorySelect> createState() => _CategorySelectState();
}

class _CategorySelectState extends State<CategorySelect> {
  bool birthday = false, date = false, travel = false, meet = false, business = false;
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
                        birthday = true;
                        date = false;
                        travel = false;
                        meet = false;
                        business = false;
                        context.read<AddEventProvider>().nextButtonState(true);
                      });
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: birthday == true ? StaticColor.categorySelectedColor : StaticColor.categoryUnselectedColor, elevation: 0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/add_event/birthday.png', width: 32, height: 32, color: birthday == true ? Colors.white : Colors.black),
                        const SizedBox(
                          height: 12
                        ),
                        Text('생일', style: TextStyle(fontSize: 13, color: birthday == true ? Colors.white : StaticColor.addEventFontColor, fontWeight: FontWeight.w700)),
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
                        birthday = false;
                        date = true;
                        travel = false;
                        meet = false;
                        business = false;
                        context.read<AddEventProvider>().nextButtonState(true);
                      });
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: date == true ? StaticColor.categorySelectedColor : StaticColor.categoryUnselectedColor, elevation: 0.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/add_event/date.png', width: 32, height: 32, color: date == true ? Colors.white : Colors.black),
                          const SizedBox(
                              height: 12
                          ),
                          Text('데이트', style: TextStyle(fontSize: 13, color: date == true ? Colors.white : StaticColor.addEventFontColor, fontWeight: FontWeight.w700)),
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
                          birthday = false;
                          date = false;
                          travel = true;
                          meet = false;
                          business = false;
                          context.read<AddEventProvider>().nextButtonState(true);
                        });
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: travel == true ? StaticColor.categorySelectedColor : StaticColor.categoryUnselectedColor, elevation: 0.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/add_event/travel.png', width: 32, height: 32, color: travel == true ? Colors.white : Colors.black),
                            const SizedBox(
                                height: 12
                            ),
                            Text('여행', style: TextStyle(fontSize: 13, color: travel == true ? Colors.white : StaticColor.addEventFontColor, fontWeight: FontWeight.w700)),
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
                          birthday = false;
                          date = false;
                          travel = false;
                          meet = true;
                          business = false;
                          context.read<AddEventProvider>().nextButtonState(true);
                        });
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: meet == true ? StaticColor.categorySelectedColor : StaticColor.categoryUnselectedColor, elevation: 0.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/add_event/meet.png', width: 32, height: 32, color: meet == true ? Colors.white : Colors.black),
                            const SizedBox(
                                height: 12
                            ),
                            Text('모임', style: TextStyle(fontSize: 13, color: meet == true ? Colors.white : StaticColor.addEventFontColor, fontWeight: FontWeight.w700)),
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
                          birthday = false;
                          date = false;
                          travel = false;
                          meet = false;
                          business = true;
                          context.read<AddEventProvider>().nextButtonState(true);
                        });
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: business == true ? StaticColor.categorySelectedColor : StaticColor.categoryUnselectedColor, elevation: 0.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/add_event/business.png', width: 32, height: 32, color: business == true ? Colors.white : Colors.black),
                            const SizedBox(
                                height: 12
                            ),
                            Text('비즈니스', style: TextStyle(fontSize: 13, color: business == true ? Colors.white : StaticColor.addEventFontColor, fontWeight: FontWeight.w700)),
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

class NextButton extends StatefulWidget {
  const NextButton({Key? key}) : super(key: key);

  @override
  State<NextButton> createState() => _NextButtonState();
}

class _NextButtonState extends State<NextButton> {

  Future backButtonAction(BuildContext context) async {
    context.read<AddEventProvider>().nextButtonReset();
  }

  @override
  Widget build(BuildContext context) {

    final buttonEnabled = context.watch<AddEventProvider>().buttonState;

    return WillPopScope(
      onWillPop: () async {
        await backButtonAction(context);
        return true;
      },
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
            onPressed: () {
              buttonEnabled == true ? Navigator.push(context, MaterialPageRoute(builder: (context) => WithPersonScreen())) : (){};
            },
            style: ElevatedButton.styleFrom(backgroundColor: buttonEnabled == true ? StaticColor.categorySelectedColor : StaticColor.unSelectedColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('다음', style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w700)),
                ]
            )
        ),
      ),
    );
  }

  /// 현재 미사용, toast message
  void showToastAddEvent() {
    Fluttertoast.showToast(
      msg: '유형을 선택해주세요',
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.redAccent,
      fontSize: 20,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}

class AddEventProvider with ChangeNotifier {
  bool _buttonState = false;
  bool get buttonState => _buttonState;

  bool _contactListButtonState = false;
  bool get contactListButtonState => _contactListButtonState;

  void nextButtonState(bool state) {
    _buttonState = state;
    notifyListeners();
  }

  void nextButtonReset() {
    _buttonState = false;
    notifyListeners();
  }

  void contactListNextButtonState(bool state) {
    _contactListButtonState = state;
    notifyListeners();
  }
}