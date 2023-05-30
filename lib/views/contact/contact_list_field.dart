import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/add_event/add_event_model.dart';
import 'package:sense_flutter_application/models/contact/contact_model.dart';
import 'package:sense_flutter_application/public_widget/behavior_collection.dart';
import 'package:sense_flutter_application/screens/contact/contact_friend_screen.dart';
import 'package:sense_flutter_application/views/contact/contacts_provider.dart';

class ContactListField extends StatefulWidget {
  const ContactListField({Key? key}) : super(key: key);

  @override
  State<ContactListField> createState() => _ContactListFieldState();
}

class _ContactListFieldState extends State<ContactListField> with TickerProviderStateMixin {
  late TabController contactTabController;

  /// none used List<Tab>
  /// used List<Widget>
  /// none used Expanded
  /// 렌더 전 context 부재로 mediaquery를 사용할 수 없기에 [build] 내부에서 tab widget 생성
  List<Widget> tabs = [];

  /// server response용 widget
  List<String> tabCategory = ['전체(0)', '가족(0)', '친구(0)', '연인(0)', '직장(0)'];

  // List<ContactModel>? contactModel;
  // ContactModel? contactModel;

  @override
  void initState() {
    contactTabController = TabController(length: 5, vsync: this);
    // contactModel = ContactModel.fromJson(contactDummyModel);
    // contactModel = contactDummyModel.map((e) {
    //   int index = contactDummyModel.indexOf(e);
    //
    //   ContactModel.fromJson(contactDummyModel)
    // });
    // getPermission();
    super.initState();
  }

  @override
  void dispose() {
    contactTabController.dispose();
    super.dispose();
  }

  void publicWidthSet(double value) {
    tabs = tabCategory.map((e) {
      return SizedBox(
          width: value,
          child: Tab(
              icon: Text(e.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, color: StaticColor.contactTextColor, fontWeight: FontWeight.w700))));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var publicWidth = MediaQuery.of(context).size.width / 5;
    publicWidthSet(publicWidth);

    return Column(
      children: [
        /// tabbar
        Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 20.0, right: 20.0),
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
              ],
            ),
          ),
        ),

        /// tabbar view
        Expanded(
          child: TabBarView(
            controller: contactTabController,
            children: [
              SizedBox(
                child: Column(
                  children: [
                    /// favorite
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 20.0),
                          alignment: Alignment.centerLeft,
                          height: 32, color: StaticColor.grey100F6,
                          child: Text('즐겨찾기', style: TextStyle(fontSize: 14, color: StaticColor.black90015, fontWeight: FontWeight.w500))),
                      ],
                      /// favorite list insert
                    ),

                    const SizedBox(height: 16.0),

                    /// birthday friends
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 20.0),
                          alignment: Alignment.centerLeft,
                          height: 32, color: StaticColor.grey100F6,
                          child: Text('생일인 친구', style: TextStyle(fontSize: 14, color: StaticColor.black90015, fontWeight: FontWeight.w500))),
                      ],
                    ),

                    const SizedBox(height: 16.0),

                    /// friends
                    Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.only(left: 20.0),
                            alignment: Alignment.centerLeft,
                            height: 32, color: StaticColor.grey100F6,
                            child: Text('친구', style: TextStyle(fontSize: 14, color: StaticColor.black90015, fontWeight: FontWeight.w500))),
                        // Consumer<ContactProvider>(
                        //   builder: (context, data, child) => data.callContact == [] ?
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                getPermission();
                              },
                              child: Container(
                                  width: 100, height: 40, child: Center(child: Text('연락처 불러오기', style: TextStyle(color: Colors.white)))),
                            ),
                        //   ) : const SizedBox.shrink(),
                        ),
                        Consumer<ContactProvider>(
                          builder: (context, data, child) => data.callContact.length == 0 ?
                          const SizedBox.shrink() : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
                            child: Expanded(
                              child: ScrollConfiguration(
                                behavior: MyBehavior(),
                                child: ListView.builder(
                                  physics: const ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: data.callContact.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (_) => ContactFriendScreen()));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                                        /// gesture detector press용 color bug 해소를 위한 container
                                        child: Container(
                                          width: double.infinity,
                                          color: Colors.transparent,
                                          child: Row(
                                            children: [
                                              Image.asset('assets/contact/empty_profile.png', width: 40, height: 40),
                                              const SizedBox(width: 8),
                                              Text(data.callContact.elementAt(index).familyName!, style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(child: Center(child: Text('목록이 없습니다.\n친구와의 관계를 설정해주세요.'))),
              Container(child: Center(child: Text('목록이 없습니다.\n친구와의 관계를 설정해주세요.'))),
              Container(child: Center(child: Text('목록이 없습니다.\n친구와의 관계를 설정해주세요.'))),
              Container(child: Center(child: Text('목록이 없습니다.\n친구와의 관계를 설정해주세요.'))),
            ],
          ),
        ),
      ],
    );
  }

  void getPermission() async {
    //(주의) Android 11버전 이상과 iOS에서는 유저가 한 두번 이상 거절하면 다시는 팝업 띄울 수 없습니다.
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      //연락처 권한 줬는지 여부
      setState(() {});
      print('허락됨');
      ContactsListModel.contacts = await ContactsService.getContacts();
      context.read<ContactProvider>().isCallContact(ContactsListModel.contacts);

      print(ContactsListModel.contacts.length);
      for (int i = 0; i < ContactsListModel.contacts.length; i++) {
        if (ContactsListModel.contacts[i].givenName == '') {
          print(ContactsListModel.contacts[i].familyName);
        } else {
          print(ContactsListModel.contacts[i].givenName);
        }
        setState(() {});
      }
    } else if (status.isDenied) {
      print('거절됨');
      Permission.contacts.request(); //허락해달라고 팝업띄우는 코드
    }
    // 하지만 아이폰의 경우 OS가 금지하는 경우도 있고 (status.isRestricted)
    // 안드로이드의 경우 아예 앱 설정에서 꺼놓은 경우 (status.isPermanentlyDenied)
    // 그것도 체크하고 싶으면
    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}

class SearchResultField extends StatefulWidget {
  const SearchResultField({Key? key}) : super(key: key);

  @override
  State<SearchResultField> createState() => _SearchResultFieldState();
}

class _SearchResultFieldState extends State<SearchResultField> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
