import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/contact/contact_model.dart';

class ContactTab extends StatefulWidget {
  TabController controller;
  ContactTab({super.key, required this.controller});

  @override
  State<ContactTab> createState() => _ContactTabState();
}

class _ContactTabState extends State<ContactTab> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        ContactRequest().contactListRequest(),
        // ContactRequest().contactListRequest(1),
        // ContactRequest().contactListRequest(2),
        // ContactRequest().contactListRequest(3),
        // ContactRequest().contactListRequest(4),
      ]),
      builder: (context, snapshot) {
        // List<ContactModel> totalList = snapshot.data!.elementAt(0) ?? [];
        // List<ContactModel> familyList = snapshot.data!.elementAt(1) ?? [];
        // List<ContactModel> friendList = snapshot.data!.elementAt(2) ?? [];
        // List<ContactModel> coupleList = snapshot.data!.elementAt(3) ?? [];
        // List<ContactModel> coperationList = snapshot.data!.elementAt(4) ?? [];

        /// count
        List<int> countList = [0,0,0,0,0];
        // List<int> countList = [totalList.length, familyList.length, friendList.length, coupleList.length, coperationList.length];

        // print(totalList.length);
        return ContactTabMenu(controller: widget.controller, count: countList);
      }
    );
  }
}

class ContactTabMenu extends StatefulWidget {
  TabController controller;
  List<int> count;
  ContactTabMenu({super.key, required this.controller, required this.count});

  @override
  State<ContactTabMenu> createState() => _ContactTabMenuState();
}

class _ContactTabMenuState extends State<ContactTabMenu> {
  @override
  Widget build(BuildContext context) {

     double tabWidth = (MediaQuery.of(context).size.width - 40.0) / 5;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: DefaultTabController(
        initialIndex: 1,
        length: 5,
        child: Column(
          children: [
            TabBar(
              isScrollable: false,
              controller: widget.controller,
              labelColor: StaticColor.mainSoft,
              labelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700),
              unselectedLabelColor: StaticColor.grey70055,
              indicatorWeight: 5,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: -5.0),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: StaticColor.mainSoft, width: 3.0),
                insets: EdgeInsets.symmetric(horizontal: 1.0.w),
              ),
              unselectedLabelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
              tabs: [
                SizedBox(
                  // width: tabWidth,
                  height: 40.0.h,
                  child: Tab(
                    child: Text('전체(${widget.count.elementAt(0)})', overflow: TextOverflow.ellipsis),
                  ),
                ),
                SizedBox(
                  // width: tabWidth,
                  height: 40.0.h,
                  child: Tab(
                    child: Text('가족(${widget.count.elementAt(1)})', overflow: TextOverflow.ellipsis),
                  ),
                ),
                SizedBox(
                  // width: tabWidth,
                  height: 40.0.h,
                  child: Tab(
                    child: Text('친구(${widget.count.elementAt(2)})', overflow: TextOverflow.ellipsis),
                  ),
                ),
                SizedBox(
                  // width: tabWidth,
                  height: 40.0.h,
                  child: Tab(
                    child: Text('연인(${widget.count.elementAt(3)})', overflow: TextOverflow.ellipsis),
                  ),
                ),
                SizedBox(
                  // width: tabWidth,
                  height: 40.0.h,
                  child: Tab(
                      child: Text('직장(${widget.count.elementAt(4)})', overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

