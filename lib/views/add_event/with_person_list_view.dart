import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/add_event/add_event_model.dart';
import 'package:sense_flutter_application/public_widget/add_event_cancel_dialog.dart';
import 'package:sense_flutter_application/screens/add_event/regedit_contact_screen.dart';
import 'package:sense_flutter_application/screens/add_event/share_event_screen.dart';
import 'package:sense_flutter_application/views/add_event/add_event_view.dart';

class ContactListHeader extends StatefulWidget {
  const ContactListHeader({Key? key}) : super(key: key);

  @override
  State<ContactListHeader> createState() => _ContactListHeaderState();
}

class _ContactListHeaderState extends State<ContactListHeader> {
  @override
  Widget build(BuildContext context) {
    return HeaderMenu(backCallback: backCallback, title: '이벤트 생성', closeCallback: closeCallback);
  }

  void backCallback() {
    // Navigator.push(context, MaterialPageRoute(builder: (context) => const RegeditContactScreen()));
    Navigator.of(context).pop();
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
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('함께 할\n사람을 선택해주세요', style: TextStyle(fontSize: 24, color: StaticColor.addEventTitleColor, fontWeight: FontWeight.w500)),
            Container(
              width: 81,
              height: 32,
              decoration: BoxDecoration(
                color: StaticColor.categoryUnselectedColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ShareEventScreen()));
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

class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> with TickerProviderStateMixin {

  late TabController contactTabController;

  /// none used List<Tab>
  /// used List<Widget>
  /// none used Expanded
  /// 렌더 전 context 부재로 mediaquery를 사용할 수 없기에 [build] 내부에서 tab widget 생성
  List<Widget> tabs = [];

  /// server response용 widget
  List<String> tabCategory = ['전체(0)', '친구(0)', '가족(0)', '연인(0)', '직장(0)'];

  // List<ContactModel>? contactModel;
  ContactModel? contactModel;

  @override
  void initState() {
    contactTabController = TabController(length: 5, vsync: this);
    contactModel = ContactModel.fromJson(contactDummyModel);
    // contactModel = contactDummyModel.map((e) {
    //   int index = contactDummyModel.indexOf(e);
    //
    //   ContactModel.fromJson(contactDummyModel)
    // });
    super.initState();
  }

  @override
  void dispose() {
    contactTabController.dispose();
    super.dispose();
  }

  void publicWidthSet(double value) {
    tabs = tabCategory.map((e) {
      return SizedBox(width: value, child: Tab(icon: Text(e.toString(), overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, color: StaticColor.contactTextColor, fontWeight: FontWeight.w700))));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {

    var publicWidth = MediaQuery.of(context).size.width / 5;
    publicWidthSet(publicWidth);

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
            Expanded(
              child: SizedBox(
                width: double.infinity,
                // mediaquery.height - safearea - header - title - tab으로 수정?
                height: 300,
                child: TabBarView(
                  controller: contactTabController,
                    children: [
                      // ContactListAll(),
                      Column(
                        children: [
                          SearchBox(),
                          ContactListBox(),
                          // Center(
                          //   child: Column(
                          //     children: [
                          //       Text(contactModel!.name),
                          //       Text(contactModel!.phoneNumber),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                      // Container(
                      //   child: Column(
                      //     children: [
                      //       const SizedBox(
                      //         height: 56
                      //       ),
                      //       Text('사람이 없습니다\n연락처를 불러올까요?', style: TextStyle(fontSize: 16, color: StaticColor.contactLoadTextColor, fontWeight: FontWeight.w400), textAlign: TextAlign.center),
                      //       const SizedBox(
                      //         height: 30
                      //       ),
                      //       Container(
                      //         width: 81,
                      //         height: 32,
                      //         decoration: BoxDecoration(
                      //           color: StaticColor.categoryUnselectedColor,
                      //           borderRadius: BorderRadius.circular(8.0),
                      //         ),
                      //         child: ElevatedButton(
                      //           onPressed: () {
                      //           },
                      //           style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categoryUnselectedColor, elevation: 0.0),
                      //           child: Text('불러오기', style: TextStyle(fontSize: 13, color: StaticColor.addEventFontColor, fontWeight: FontWeight.w400)),
                      //         ),
                      //       ),
                      //     ]
                      //   )
                      // ),
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

  Future backButtonAction(BuildContext context) async {
    context.read<AddEventProvider>().nextButtonReset();
  }

  @override
  Widget build(BuildContext context) {

    final buttonEnabled = context.watch<AddEventProvider>().contactListButtonState;

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
              buttonEnabled == true ? Navigator.push(context, MaterialPageRoute(builder: (context) => const ShareEventScreen())) : (){};
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

  // void showToastAddEvent() {
  //   Fluttertoast.showToast(
  //     msg: '함께 할 사람이 선택되지 않았습니다',
  //     gravity: ToastGravity.BOTTOM,
  //     backgroundColor: Colors.redAccent,
  //     fontSize: 20,
  //     textColor: Colors.white,
  //     toastLength: Toast.LENGTH_SHORT,
  //   );
  // }
}

class SearchBox extends StatefulWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 32.0),
      child: Container(
        height: 48,
        child: Stack(
          children: [
            TextFormField(
              textAlignVertical: TextAlignVertical.center,
              onChanged: null,
              cursorHeight: 22,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10), // 수정 필요함
                filled: true,
                fillColor: StaticColor.textFormFieldFillColor,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: StaticColor.searchBoxBorderColor),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: StaticColor.searchBoxBorderColor),
                  borderRadius: BorderRadius.circular(8.0),
                )
              ),
            ),
            GestureDetector(
                onTap: () {
                  print('click the searchbox!!');
                },
                child: Padding(padding: const EdgeInsets.only(right: 12.0), child: Align(alignment: Alignment.centerRight, child: Image.asset('assets/add_event/button_search.png', width: 24, height: 24)))),
          ]
        ),
      )
    );
  }
}

class ContactListBox extends StatefulWidget {
  const ContactListBox({Key? key}) : super(key: key);

  @override
  State<ContactListBox> createState() => _ContactListBoxState();
}

class _ContactListBoxState extends State<ContactListBox> {

  late bool _allCheckState;

  @override
  void initState() {
    _allCheckState = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final allCheckState = context.watch<AddEventProvider>().allCheckState;

    return Padding(
      padding: const EdgeInsets.only(bottom: 0.0),
      child: Column(
        children: [
          // 전체선택 행
          Row(
            children: [
              Text('전체선택', style: TextStyle(fontSize: 14, color: StaticColor.contactListBoxTextColor, fontWeight: FontWeight.w700)),
              const SizedBox(
                width: 5.25,
              ),
              GestureDetector(
                onTap: () {
                  _allCheckState = _allCheckState!;
                  context.read<AddEventProvider>().contactListAllCheckState(_allCheckState);
                },
                child: allCheckState == false ? Image.asset('assets/add_event/button_all_check.png', width: 20, height: 20, color: StaticColor.nonAllCheck) :
                    Image.asset('assets/add_event/button_all_check.png', width: 20, height: 20, color: StaticColor.allCheck),
              )
            ],
          ),
        ],
      ),
    );
  }
}


class ContactListAll extends StatefulWidget {
  const ContactListAll({Key? key}) : super(key: key);

  @override
  State<ContactListAll> createState() => _ContactListAllState();
}

class _ContactListAllState extends State<ContactListAll> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

/// search delegate vs view rebuild?
class ContactSearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
  
}
