import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/public_widget/add_event_cancel_dialog.dart';
import 'package:sense_flutter_application/screens/add_event/share_event_screen.dart';
import 'package:sense_flutter_application/views/add_event/add_event_view.dart';

class ContactListNextButton extends StatefulWidget {
  const ContactListNextButton({Key? key}) : super(key: key);

  @override
  State<ContactListNextButton> createState() => _ContactListNextButtonState();
}

class _ContactListNextButtonState extends State<ContactListNextButton> {
  @override
  Widget build(BuildContext context) {

    // final buttonEnabled = context.watch<AddEventProvider>().buttonState;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: StaticColor.categoryUnselectedColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ElevatedButton(
            onPressed: () {
              setState(() {
              });
            },
            // style: ElevatedButton.styleFrom(backgroundColor: buttonEnabled == true ? StaticColor.categorySelectedColor : StaticColor.categoryUnselectedColor, elevation: 0.0),
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
}

class ContactListHeader extends StatefulWidget {
  const ContactListHeader({Key? key}) : super(key: key);

  @override
  State<ContactListHeader> createState() => _ContactListHeaderState();
}

class _ContactListHeaderState extends State<ContactListHeader> {
  @override
  Widget build(BuildContext context) {
    return HeaderMenu(jumpCallback: jumpCallback, closeCallback: closeCallback);
  }

  void jumpCallback() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ShareEventScreen()));
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

class ContactListTitle extends StatefulWidget {
  const ContactListTitle({Key? key}) : super(key: key);

  @override
  State<ContactListTitle> createState() => _ContactListTitleState();
}

class _ContactListTitleState extends State<ContactListTitle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 30, bottom: 40),
        child: Center(
          child: Text('함께 할\n사람을 선택해주세요', style: TextStyle(fontSize: 24, color: StaticColor.addEventTitleColor, fontWeight: FontWeight.w500), textAlign: TextAlign.center),
        )
    );
  }
}

class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> with TickerProviderStateMixin {

  late TabController contactTabController;

  List<Tab> tabs = [
    Tab(icon: Text('전체(0)', overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, color: StaticColor.contactTextColor, fontWeight: FontWeight.w700))),
    Tab(icon: Text('친구(0)', overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13, color: StaticColor.contactTextColor, fontWeight: FontWeight.w700))),
    Tab(icon: Text('가족(0)', overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13, color: StaticColor.contactTextColor, fontWeight: FontWeight.w700))),
    Tab(icon: Text('연인(0)', overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13, color: StaticColor.contactTextColor, fontWeight: FontWeight.w700))),
    Tab(icon: Text('직장(0)', overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13, color: StaticColor.contactTextColor, fontWeight: FontWeight.w700))),
  ];

  @override
  void initState() {
    contactTabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    contactTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DefaultTabController(
        initialIndex: 1,
        length: 5,
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: TabBar(
                controller: contactTabController,
                tabs: tabs,
                isScrollable: false,
                indicatorWeight: 3.0,
                indicatorColor: StaticColor.tabbarIndicatorColor,

              ),
            ),
            Container(
              width: double.infinity,
              // mediaquery.height - safearea - header - title - tab으로 수정?
              height: 500,
              child: TabBarView(
                controller: contactTabController,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 56
                          ),
                          Text('사람이 없습니다\n연락처를 불러올까요?', style: TextStyle(fontSize: 16, color: StaticColor.contactLoadTextColor, fontWeight: FontWeight.w400), textAlign: TextAlign.center),
                          const SizedBox(
                            height: 30
                          ),
                          Container(
                            width: 81,
                            height: 32,
                            decoration: BoxDecoration(
                              color: StaticColor.categoryUnselectedColor,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categoryUnselectedColor, elevation: 0.0),
                              child: Text('불러오기', style: TextStyle(fontSize: 13, color: StaticColor.addEventFontColor, fontWeight: FontWeight.w400)),
                            ),
                          ),
                        ]
                      )
                    ),
                    Container(
                        child: Column(
                            children: [
                              const SizedBox(
                                  height: 56
                              ),
                              Text('사람이 없습니다\n연락처를 불러올까요?', style: TextStyle(fontSize: 16, color: StaticColor.contactLoadTextColor, fontWeight: FontWeight.w400), textAlign: TextAlign.center),
                              const SizedBox(
                                  height: 30
                              ),
                              Container(
                                width: 81,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: StaticColor.categoryUnselectedColor,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                  },
                                  style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categoryUnselectedColor, elevation: 0.0),
                                  child: Text('불러오기', style: TextStyle(fontSize: 13, color: StaticColor.addEventFontColor, fontWeight: FontWeight.w400)),
                                ),
                              ),
                            ]
                        )
                    ),
                    Container(
                        child: Column(
                            children: [
                              const SizedBox(
                                  height: 56
                              ),
                              Text('사람이 없습니다\n연락처를 불러올까요?', style: TextStyle(fontSize: 16, color: StaticColor.contactLoadTextColor, fontWeight: FontWeight.w400), textAlign: TextAlign.center),
                              const SizedBox(
                                  height: 30
                              ),
                              Container(
                                width: 81,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: StaticColor.categoryUnselectedColor,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                  },
                                  style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categoryUnselectedColor, elevation: 0.0),
                                  child: Text('불러오기', style: TextStyle(fontSize: 13, color: StaticColor.addEventFontColor, fontWeight: FontWeight.w400)),
                                ),
                              ),
                            ]
                        )
                    ),
                    Container(
                        child: Column(
                            children: [
                              const SizedBox(
                                  height: 56
                              ),
                              Text('사람이 없습니다\n연락처를 불러올까요?', style: TextStyle(fontSize: 16, color: StaticColor.contactLoadTextColor, fontWeight: FontWeight.w400), textAlign: TextAlign.center),
                              const SizedBox(
                                  height: 30
                              ),
                              Container(
                                width: 81,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: StaticColor.categoryUnselectedColor,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                  },
                                  style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categoryUnselectedColor, elevation: 0.0),
                                  child: Text('불러오기', style: TextStyle(fontSize: 13, color: StaticColor.addEventFontColor, fontWeight: FontWeight.w400)),
                                ),
                              ),
                            ]
                        )
                    ),
                    Container(
                        child: Column(
                            children: [
                              const SizedBox(
                                  height: 56
                              ),
                              Text('사람이 없습니다\n연락처를 불러올까요?', style: TextStyle(fontSize: 16, color: StaticColor.contactLoadTextColor, fontWeight: FontWeight.w400), textAlign: TextAlign.center),
                              const SizedBox(
                                  height: 30
                              ),
                              Container(
                                width: 81,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: StaticColor.categoryUnselectedColor,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                  },
                                  style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categoryUnselectedColor, elevation: 0.0),
                                  child: Text('불러오기', style: TextStyle(fontSize: 13, color: StaticColor.addEventFontColor, fontWeight: FontWeight.w400)),
                                ),
                              ),
                            ]
                        )
                    ),
                  ]
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ContactNextButton extends StatefulWidget {
  const ContactNextButton({Key? key}) : super(key: key);

  @override
  State<ContactNextButton> createState() => _ContactNextButtonState();
}

class _ContactNextButtonState extends State<ContactNextButton> {

  @override
  Widget build(BuildContext context) {

    final buttonEnabled = context.watch<AddEventProvider>().contactListButtonState;

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 52),
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: StaticColor.categoryUnselectedColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ElevatedButton(
            onPressed: () {
              buttonEnabled == true ? Navigator.push(context, MaterialPageRoute(builder: (context) => ShareEventScreen())) : showToastAddEvent();

            },
            style: ElevatedButton.styleFrom(backgroundColor: buttonEnabled == true ? StaticColor.categorySelectedColor : StaticColor.categoryUnselectedColor, elevation: 0.0),
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

  void showToastAddEvent() {
    Fluttertoast.showToast(
      msg: '함께 할 사람이 선택되지 않았습니다',
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.redAccent,
      fontSize: 20,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}
