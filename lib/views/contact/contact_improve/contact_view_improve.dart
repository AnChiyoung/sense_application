import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/contact/contact_improve/contact_tab_improve.dart';
import 'package:sense_flutter_application/views/contact/contact_improve/contact_tabbarview_improve.dart';

class ContactListView extends StatefulWidget {
  const ContactListView({super.key});

  @override
  State<ContactListView> createState() => _ContactListViewState();
}

class _ContactListViewState extends State<ContactListView> with TickerProviderStateMixin{

  late TabController contactTabController;

  @override
  void initState() {
    contactTabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ContactTab(controller: contactTabController),
        // ContactTabBarView(controller: contactTabController),
        // Container(width: 30, height: 30, color: Colors.green),
        // Expanded(
        //   child: Container(color: Colors.green),
        // )
        Expanded(
          child: ContactTabBarView(controller: contactTabController),
        ),
      ]
    );
  }
}
