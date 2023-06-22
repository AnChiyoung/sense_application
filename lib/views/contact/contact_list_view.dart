
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/contact/contact_model.dart';
import 'package:sense_flutter_application/public_widget/behavior_collection.dart';
import 'package:sense_flutter_application/screens/contact/contact_friend_screen.dart';
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
              /// 전체 페이지
              Consumer<ContactProvider>(
                builder: (context, data, child) {
                  return FutureBuilder(
                      future: ContactRequest().contactListRequest(),
                      builder: (context, snapshot) {
                        if(snapshot.hasError) {
                          return const Center(child: Text('data loading..'));
                        } else if(snapshot.hasData) {
                          if(snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: Text('data loading..'));
                          } else if(snapshot.connectionState == ConnectionState.done) {
                            List<ContactModel>? model = snapshot.data;
                            // return model!.isEmpty ? ContactCallField() : ContactListField();
                            return data.callContact.isEmpty ? ContactCallField() : ContactListField();
                          } else {
                            return const Center(child: Text('data loading..'));
                          }
                        } else {
                          return const Center(child: Text('data loading..'));
                        }
                      }
                  );
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
