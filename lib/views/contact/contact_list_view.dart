
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/contact/contact_model.dart';
import 'package:sense_flutter_application/public_widget/behavior_collection.dart';
import 'package:sense_flutter_application/screens/contact/contact_detail_screen.dart';
import 'package:sense_flutter_application/views/contact/contact_call_field.dart';
import 'package:sense_flutter_application/views/contact/contact_list_field.dart';
import 'package:sense_flutter_application/views/contact/contacts_provider.dart';

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
  List<String> tabCategory = ['전체', '가족', '친구', '연인', '직장'];
  List<int> tabCategoryCount = [];

  // List<ContactModel>? contactModel;
  // ContactModel? contactModel;

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
    super.initState();
  }

  @override
  void dispose() {
    contactTabController.dispose();
    super.dispose();
  }

  void publicWidthSet(double value) {
    tabs = tabCategory.map((e) {
      return Consumer<ContactProvider>(
        builder: (context, data, child) {
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
                        '(${tabCategoryCount.elementAt(tabCategory.indexOf(e)).toString()})',
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
              /// 전체 페이지
              FutureBuilder(
                  future: ContactRequest().contactListRequest(),
                  builder: (context, snapshot) {
                    if(snapshot.hasError) {
                      return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
                    } else if(snapshot.hasData) {
                      if(snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
                      } else if(snapshot.connectionState == ConnectionState.done) {

                        List<ContactModel>? model = snapshot.data;
                        context.read<ContactProvider>().isCallContact(model!);

                        if(model!.isEmpty) {
                          return ContactCallField();
                        } else {
                          return SingleChildScrollView(child: Expanded(child: ContactListField()));
                        }

                      } else {
                        return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
                      }
                    } else {
                      return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
                    }
                  }
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
