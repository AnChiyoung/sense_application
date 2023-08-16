
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/contact/contact_model.dart';
import 'package:sense_flutter_application/public_widget/behavior_collection.dart';
import 'package:sense_flutter_application/public_widget/empty_user_profile.dart';
import 'package:sense_flutter_application/screens/contact/contact_detail_screen.dart';
import 'package:sense_flutter_application/views/contact/contact_call_field.dart';
import 'package:sense_flutter_application/views/contact/contact_list_field.dart';
import 'package:sense_flutter_application/views/contact/contacts_provider.dart';
import 'package:sense_flutter_application/views/contact/relation_page/couple.dart';
import 'package:sense_flutter_application/views/contact/relation_page/coworker.dart';
import 'package:sense_flutter_application/views/contact/relation_page/family.dart';
import 'package:sense_flutter_application/views/contact/relation_page/friend.dart';

class ContactListView extends StatefulWidget {
  const ContactListView({Key? key}) : super(key: key);

  @override
  State<ContactListView> createState() => _ContactListViewState();
}

class _ContactListViewState extends State<ContactListView> with TickerProviderStateMixin {
  late TabController contactTabController;

  /// none used List<Tab>
  /// used List<Widget>
  /// none used Expanded
  /// 렌더 전 context 부재로 mediaquery를 사용할 수 없기에 [build] 내부에서 tab widget 생성
  List<Widget> tabs = [];

  /// server response용 widget
  List<String> tabCategory = ['전체', '친구', '가족', '연인', '직장'];
  List<int> tabCategoryCount = [];

  // List<ContactModel>? contactModel;
  // ContactModel? contactModel;

  List<ContactModel> initData = [];

  @override
  void initState() {
    contactTabController = TabController(length: 5, vsync: this);
    tabCategoryCount = context.read<ContactProvider>().contactCount;
    // contactModel = ContactModel.fromJson(contactDummyModel);
    // contactModel = contactDummyModel.map((e) {
    //   int index = contactDummyModel.indexOf(e);
    //
    //   ContactModel.fromJson(contactDummyModel)
    // });
    // getPermission();
    initDataFetch();
    super.initState();
  }

  @override
  void dispose() {
    contactTabController.dispose();
    super.dispose();
  }

  void initDataFetch() async {
    // ContactTabModel resultModel = await ContactRequest().contactListRequest();
    initData = await ContactRequest().contactListRequest();
    // initData = resultModel.contactModelList!;
    initData.isNotEmpty ? context.read<ContactProvider>().isCallContact(initData) : {};
  }

  void publicWidthSet(double value) {
    tabs = tabCategory.map((e) {
      return Consumer<ContactProvider>(
        builder: (context, data, child) {

          int listCount = data.listCount;

          return SizedBox(
              width: value,
              child: Tab(
                  icon: Row(
                    children: [
                      /// 연락처 섹션 이름
                      Text(
                        e.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 13, color: StaticColor.contactTextColor, fontWeight: FontWeight.w700),
                      ),
                      /// 연락처 섹션 별 카운트
                      Text(
                        // '(${tabCategoryCount.elementAt(tabCategory.indexOf(e)).toString()})',
                          '(${listCount.toString()})',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 13, color: StaticColor.contactTextColor, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
              ),
          );
        }
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var publicWidth = MediaQuery.of(context).size.width / 5;
    publicWidthSet(publicWidth);

    return Column(
      children: [
        /// tabbar
        Consumer<ContactProvider>(
          builder: (context, data, child) {
            return Padding(
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
                        // tabs: tabs,
                        tabs: [
                          Tab(
                            icon: Row(
                              children: [
                                /// 연락처 섹션 이름
                                Text(
                                  '전체',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 13, color: StaticColor.contactTextColor, fontWeight: FontWeight.w700),
                                ),
                                /// 연락처 섹션 별 카운트
                                // Expanded(
                                //   child: Text(
                                //     // '(${tabCategoryCount.elementAt(tabCategory.indexOf(e)).toString()})',
                                //     '(10)',
                                //     overflow: TextOverflow.ellipsis,
                                //     style: TextStyle(fontSize: 13, color: StaticColor.contactTextColor, fontWeight: FontWeight.w700),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          Tab(
                            icon: Row(
                              children: [
                                /// 연락처 섹션 이름
                                Text(
                                  '친구',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 13, color: StaticColor.contactTextColor, fontWeight: FontWeight.w700),
                                ),
                                /// 연락처 섹션 별 카운트
                                // Expanded(
                                //   child: Text(
                                //     // '(${tabCategoryCount.elementAt(tabCategory.indexOf(e)).toString()})',
                                //     '(10)',
                                //     overflow: TextOverflow.ellipsis,
                                //     style: TextStyle(fontSize: 13, color: StaticColor.contactTextColor, fontWeight: FontWeight.w700),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          Tab(
                            icon: Row(
                              children: [
                                /// 연락처 섹션 이름
                                Text(
                                  '가족',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 13, color: StaticColor.contactTextColor, fontWeight: FontWeight.w700),
                                ),
                                /// 연락처 섹션 별 카운트
                                // Text(
                                //   // '(${tabCategoryCount.elementAt(tabCategory.indexOf(e)).toString()})',
                                //   '(1)',
                                //   overflow: TextOverflow.ellipsis,
                                //   style: TextStyle(fontSize: 13, color: StaticColor.contactTextColor, fontWeight: FontWeight.w700),
                                // ),
                              ],
                            ),
                          ),
                          Tab(
                            icon: Row(
                              children: [
                                /// 연락처 섹션 이름
                                Text(
                                  '연인',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 13, color: StaticColor.contactTextColor, fontWeight: FontWeight.w700),
                                ),
                                /// 연락처 섹션 별 카운트
                                // Text(
                                //   // '(${tabCategoryCount.elementAt(tabCategory.indexOf(e)).toString()})',
                                //   '(0)',
                                //   overflow: TextOverflow.ellipsis,
                                //   style: TextStyle(fontSize: 13, color: StaticColor.contactTextColor, fontWeight: FontWeight.w700),
                                // ),
                              ],
                            ),
                          ),
                          Tab(
                            icon: Row(
                              children: [
                                /// 연락처 섹션 이름
                                Center(
                                  child: Text(
                                    '직장',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 13, color: StaticColor.contactTextColor, fontWeight: FontWeight.w700),
                                  ),
                                ),
                                /// 연락처 섹션 별 카운트
                                // Text(
                                //   // '(${tabCategoryCount.elementAt(tabCategory.indexOf(e)).toString()})',
                                //   '(2)',
                                //   overflow: TextOverflow.ellipsis,
                                //   style: TextStyle(fontSize: 13, color: StaticColor.contactTextColor, fontWeight: FontWeight.w700),
                                // ),
                              ],
                            ),
                          ),
                        ],
                        isScrollable: false,
                        indicatorWeight: 3.0,
                        indicatorColor: StaticColor.tabbarIndicatorColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        ),

        /// tabbar view
        Expanded(
          child: TabBarView(
            controller: contactTabController,
            children: [
              /// 전체 페이지
              Consumer<ContactProvider>(
                builder: (context, data, child) {

                  List<ContactModel> contactList = data.callContact;

                  /// provider contact list가 비어있다면 불러오는 화면을
                  if(contactList.isEmpty) {
                    return ContactCallField();
                  /// provider contact list가 비어있지 않다면 리스트를
                  } else {
                    return SingleChildScrollView(child: ContactListField());
                  }

                  List<ContactModel> dataList = data.callContact;

                  if(dataList.isEmpty) {
                    return ContactCallField();
                  } else {
                    return SingleChildScrollView(child: Expanded(child: ContactListField()));
                    // return FutureBuilder(
                    //     future: ContactRequest().contactListRequest(),
                    //     builder: (context, snapshot) {
                    //       if(snapshot.hasError) {
                    //         return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
                    //       } else if(snapshot.hasData) {
                    //         if(snapshot.connectionState == ConnectionState.waiting) {
                    //           return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
                    //         } else if(snapshot.connectionState == ConnectionState.done) {
                    //
                    //           List<ContactModel>? model = snapshot.data;
                    //           context.read<ContactProvider>().isCallContact(model!);
                    //
                    //           if(model!.isEmpty) {
                    //             return ContactCallField();
                    //           } else {
                    //             return SingleChildScrollView(child: Expanded(child: ContactListField()));
                    //           }
                    //
                    //         } else {
                    //           return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
                    //         }
                    //       } else {
                    //         return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
                    //       }
                    //     }
                    // );

                    // return SingleChildScrollView(
                    //   child: Expanded(
                    //     child: ContactListField()
                    //   ),
                    // );
                  }
                }
              ),



              // FutureBuilder(
              //     future: ContactRequest().contactListRequest(),
              //     builder: (context, snapshot) {
              //       if(snapshot.hasError) {
              //         return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
              //       } else if(snapshot.hasData) {
              //         if(snapshot.connectionState == ConnectionState.waiting) {
              //           return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
              //         } else if(snapshot.connectionState == ConnectionState.done) {
              //
              //           List<ContactModel>? model = snapshot.data;
              //           context.read<ContactProvider>().isCallContact(model!);
              //
              //           if(model!.isEmpty) {
              //             return ContactCallField();
              //           } else {
              //             return SingleChildScrollView(child: Expanded(child: ContactListField()));
              //           }
              //
              //         } else {
              //           return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
              //         }
              //       } else {
              //         return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
              //       }
              //     }
              // ),
              FriendView(),
              FamilyView(),
              CoupleView(),
              CoworkerView(),

              // Container(child: Center(child: Text('목록이 없습니다.\n친구와의 관계를 설정해주세요.'))),
              // Container(child: Center(child: Text('목록이 없습니다.\n친구와의 관계를 설정해주세요.'))),
              // Container(child: Center(child: Text('목록이 없습니다.\n친구와의 관계를 설정해주세요.'))),
              // Container(child: Center(child: Text('목록이 없습니다.\n친구와의 관계를 설정해주세요.'))),
            ],
          ),
        ),
      ],
    );
  }


}

class SearchResultField extends StatefulWidget {
  const SearchResultField({Key? key}) : super(key: key);

  @override
  State<SearchResultField> createState() => _SearchResultFieldState();
}

class _SearchResultFieldState extends State<SearchResultField> {

  late Future onceRunFuture;
  List<ContactModel> searchResultList = [];

  @override
  void initState() {
    onceRunFuture = _fetchData();
    super.initState();
  }

  Future<List<ContactModel>> _fetchData() async {
    List<ContactModel> result = await ContactRequest().contactListRequest();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactProvider>(
      builder: (context, data, child) {

        searchResultList.clear();
        String searchText = data.searchText;

        return Expanded(
          child: FutureBuilder(
              future: onceRunFuture,
              builder: (context, snapshot) {
                if(snapshot.hasError) {
                  return Text('fetching error..');
                } else if(snapshot.hasData) {

                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
                  } else if(snapshot.connectionState == ConnectionState.done) {

                    /// fetching data
                    List<ContactModel> model = snapshot.data!;
                    // List<ContactModel> model = snapshot.data.contactModelList;
                    // int modelCount = snapshot.data.count;

                    /// search result : intenal listview
                    /// 대소문자 구분? 구분x?
                    for(int i = 0; i < model.length; i++) {
                      /// 소문자 조져보자.
                      if(model.elementAt(i).name!.toLowerCase().contains(searchText.toLowerCase())) {
                        searchResultList.add(model.elementAt(i));
                      }
                    }

                    // print('---');
                    // print(searchText);
                    // print(searchResultList);
                    // print('---');

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
                      child: ListView.builder(
                        itemCount: searchResultList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // context.read<ContactProvider>().contactModelLoad(widget.callContact.elementAt(index).id!);
                              Navigator.push(context, MaterialPageRoute(builder: (_) => ContactDetailScreen(contactModel: searchResultList.elementAt(index))));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),

                              /// gesture detector press용 color bug 해소를 위한 container
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    searchResultList.elementAt(index).profileImage! == ''
                                        ? Image.asset('assets/feed/empty_user_profile.png', width: 40, height: 40)
                                        : UserProfileImage(profileImageUrl: searchResultList.elementAt(index).profileImage!),
                                    const SizedBox(width: 8),
                                    Text(searchResultList.elementAt(index).name!,
                                        style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      ),
                    );

                  } else {
                    return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
                  }
                } else {
                  return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
                }
              }
          ),
        );
      }
    );
  }
}
