import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/add_event/add_event_model.dart';

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
  List<String> tabCategory = ['전체(0)', '친구(0)', '가족(0)', '연인(0)', '직장(0)'];

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
              )
            ),
            Expanded(
              child: TabBarView(
                controller: contactTabController,
                children: [
                  Container(),
                  Container(),
                  Container(),
                  Container(),
                  Container(),
                ]
              ),
            )
          ]
        )
      ),
    );
  }
}