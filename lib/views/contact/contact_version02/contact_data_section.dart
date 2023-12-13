import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/contact/contact_model.dart';
import 'package:sense_flutter_application/public_widget/empty_user_profile.dart';
import 'package:sense_flutter_application/screens/contact/contact_detail_screen.dart';

class ContactDataSection extends StatefulWidget {
  List<List<ContactModel>> contactCollector;
  ContactDataSection({super.key, required this.contactCollector});

  @override
  State<ContactDataSection> createState() => _ContactDataSectionState();
}

class _ContactDataSectionState extends State<ContactDataSection> with TickerProviderStateMixin {
  late TabController contactTabController;

  @override
  void initState() {
    contactTabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Column(
        children: [
          TabBar(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            controller: contactTabController,
            labelPadding: EdgeInsets.symmetric(horizontal: 1.0.w),
            labelColor: StaticColor.mainSoft,
            labelStyle: TextStyle(fontSize: 14.0.sp, fontWeight: FontWeight.w700),
            unselectedLabelColor: StaticColor.grey70055,
            indicatorWeight: 1,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: StaticColor.mainSoft, width: 3.0),
            ),
            unselectedLabelStyle: TextStyle(fontSize: 14.0.sp, fontWeight: FontWeight.w500),
            tabs: [
              SizedBox(
                height: 37.0.h,
                child: Tab(text: '전체(${widget.contactCollector.elementAt(0).length.toString()})'),
              ),
              SizedBox(
                height: 37.0.h,
                child: Tab(text: '친구(${widget.contactCollector.elementAt(1).length.toString()})'),
              ),
              SizedBox(
                height: 37.0.h,
                child: Tab(text: '가족(${widget.contactCollector.elementAt(2).length.toString()})'),
              ),
              SizedBox(
                height: 37.0.h,
                child: Tab(text: '연인(${widget.contactCollector.elementAt(3).length.toString()})'),
              ),
              SizedBox(
                height: 37.0.h,
                child: Tab(text: '직장(${widget.contactCollector.elementAt(4).length.toString()})'),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: contactTabController,
              children: [
                // Container(width: double.infinity, height: double.infinity, color: Colors.red),
                // Container(width: double.infinity, height: double.infinity, color: Colors.green),
                // Container(width: double.infinity, height: double.infinity, color: Colors.yellow),
                // Container(width: double.infinity, height: double.infinity, color: Colors.blue),
                // Container(width: double.infinity, height: double.infinity, color: Colors.black),
                ContactTotal(contactList: widget.contactCollector.elementAt(0)),
                ContactFamily(contactList: widget.contactCollector.elementAt(1)),
                ContactFriend(contactList: widget.contactCollector.elementAt(2)),
                ContactCouple(contactList: widget.contactCollector.elementAt(3)),
                ContactCoworker(contactList: widget.contactCollector.elementAt(4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ContactTotal extends StatefulWidget {
  List<ContactModel> contactList;
  ContactTotal({super.key, required this.contactList});

  @override
  State<ContactTotal> createState() => _ContactTotalState();
}

class _ContactTotalState extends State<ContactTotal> {
  List<ContactModel> favoriteList = [];
  List<ContactModel> birthdayList = [];

  @override
  void initState() {
    favoriteList.clear();
    for (var element in widget.contactList) {
      element.isBookmarked == true ? favoriteList.add(element) : {};
    }
    birthdayList.clear();
    for (var element in widget.contactList) {
      element.birthday == DateFormat('yyyy-MM-dd').format(DateTime.now())
          ? birthdayList.add(element)
          : {};
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        favoriteList.isEmpty
            ? const SizedBox.shrink()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      padding: const EdgeInsets.only(left: 20.0),
                      alignment: Alignment.centerLeft,
                      height: 32,
                      color: StaticColor.grey100F6,
                      child: Text('즐겨찾기',
                          style: TextStyle(
                              fontSize: 14,
                              color: StaticColor.black90015,
                              fontWeight: FontWeight.w500))),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: favoriteList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              print(favoriteList.elementAt(index).id);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ContactDetailScreen(
                                          contactModel: favoriteList.elementAt(index))));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),

                              /// gesture detector press용 color bug 해소를 위한 container
                              child: Container(
                                width: double.infinity,
                                height: 50.0.h,
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    favoriteList.elementAt(index).profileImage! == ''
                                        ? Image.asset('assets/feed/empty_user_profile.png',
                                            width: 40, height: 40)
                                        : UserProfileImage(
                                            profileImageUrl:
                                                favoriteList.elementAt(index).profileImage!),
                                    const SizedBox(width: 8),
                                    Text(favoriteList.elementAt(index).name!,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
        birthdayList.isEmpty
            ? const SizedBox.shrink()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      padding: const EdgeInsets.only(left: 20.0),
                      alignment: Alignment.centerLeft,
                      height: 32,
                      color: StaticColor.grey100F6,
                      child: Text('생일인 친구',
                          style: TextStyle(
                              fontSize: 14,
                              color: StaticColor.black90015,
                              fontWeight: FontWeight.w500))),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: birthdayList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              print(birthdayList.elementAt(index).id);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ContactDetailScreen(
                                          contactModel: birthdayList.elementAt(index))));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),

                              /// gesture detector press용 color bug 해소를 위한 container
                              child: Container(
                                width: double.infinity,
                                height: 50.0.h,
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    birthdayList.elementAt(index).profileImage! == ''
                                        ? Image.asset('assets/feed/empty_user_profile.png',
                                            width: 40, height: 40)
                                        : UserProfileImage(
                                            profileImageUrl:
                                                birthdayList.elementAt(index).profileImage!),
                                    const SizedBox(width: 8),
                                    Text(birthdayList.elementAt(index).name!,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
        Container(
            padding: const EdgeInsets.only(left: 20.0),
            alignment: Alignment.centerLeft,
            height: 32,
            color: StaticColor.grey100F6,
            child: Text('친구',
                style: TextStyle(
                    fontSize: 14, color: StaticColor.black90015, fontWeight: FontWeight.w500))),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: widget.contactList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      print(widget.contactList.elementAt(index).id);
                      // context.read<ContactProvider>().contactModelLoad(widget.contactListModel.elementAt(index).id!);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ContactDetailScreen(
                                  contactModel: widget.contactList.elementAt(index))));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),

                      /// gesture detector press용 color bug 해소를 위한 container
                      child: Container(
                        width: double.infinity,
                        height: 50.0.h,
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            widget.contactList.elementAt(index).profileImage! == ''
                                ? Image.asset('assets/feed/empty_user_profile.png',
                                    width: 40, height: 40)
                                : UserProfileImage(
                                    profileImageUrl:
                                        widget.contactList.elementAt(index).profileImage!),
                            const SizedBox(width: 8),
                            Text(widget.contactList.elementAt(index).name!,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}

class ContactFamily extends StatefulWidget {
  List<ContactModel> contactList;
  ContactFamily({super.key, required this.contactList});

  @override
  State<ContactFamily> createState() => _ContactFamilyState();
}

class _ContactFamilyState extends State<ContactFamily> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: ListView.builder(
          physics: const ClampingScrollPhysics(),
          itemCount: widget.contactList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // context.read<ContactProvider>().contactModelLoad(widget.contactListModel.elementAt(index).id!);
                // print(widget.contactList.elementAt(index).id);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ContactDetailScreen(
                            contactModel: widget.contactList.elementAt(index))));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),

                /// gesture detector press용 color bug 해소를 위한 container
                child: Container(
                  width: double.infinity,
                  height: 50.0.h,
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      widget.contactList.elementAt(index).profileImage! == ''
                          ? Image.asset('assets/feed/empty_user_profile.png', width: 40, height: 40)
                          : UserProfileImage(
                              profileImageUrl: widget.contactList.elementAt(index).profileImage!),
                      const SizedBox(width: 8),
                      Text(widget.contactList.elementAt(index).name!,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class ContactFriend extends StatefulWidget {
  List<ContactModel> contactList;
  ContactFriend({super.key, required this.contactList});

  @override
  State<ContactFriend> createState() => _ContactFriendState();
}

class _ContactFriendState extends State<ContactFriend> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: ListView.builder(
          physics: const ClampingScrollPhysics(),
          itemCount: widget.contactList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // context.read<ContactProvider>().contactModelLoad(widget.contactListModel.elementAt(index).id!);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ContactDetailScreen(
                            contactModel: widget.contactList.elementAt(index))));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),

                /// gesture detector press용 color bug 해소를 위한 container
                child: Container(
                  width: double.infinity,
                  height: 50.0.h,
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      widget.contactList.elementAt(index).profileImage! == ''
                          ? Image.asset('assets/feed/empty_user_profile.png', width: 40, height: 40)
                          : UserProfileImage(
                              profileImageUrl: widget.contactList.elementAt(index).profileImage!),
                      const SizedBox(width: 8),
                      Text(widget.contactList.elementAt(index).name!,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class ContactCouple extends StatefulWidget {
  List<ContactModel> contactList;
  ContactCouple({super.key, required this.contactList});

  @override
  State<ContactCouple> createState() => _ContactCoupleState();
}

class _ContactCoupleState extends State<ContactCouple> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: ListView.builder(
          physics: const ClampingScrollPhysics(),
          itemCount: widget.contactList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // context.read<ContactProvider>().contactModelLoad(widget.contactListModel.elementAt(index).id!);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ContactDetailScreen(
                            contactModel: widget.contactList.elementAt(index))));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),

                /// gesture detector press용 color bug 해소를 위한 container
                child: Container(
                  width: double.infinity,
                  height: 50.0.h,
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      widget.contactList.elementAt(index).profileImage! == ''
                          ? Image.asset('assets/feed/empty_user_profile.png', width: 40, height: 40)
                          : UserProfileImage(
                              profileImageUrl: widget.contactList.elementAt(index).profileImage!),
                      const SizedBox(width: 8),
                      Text(widget.contactList.elementAt(index).name!,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class ContactCoworker extends StatefulWidget {
  List<ContactModel> contactList;
  ContactCoworker({super.key, required this.contactList});

  @override
  State<ContactCoworker> createState() => _ContactCoworkerState();
}

class _ContactCoworkerState extends State<ContactCoworker> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: ListView.builder(
          physics: const ClampingScrollPhysics(),
          itemCount: widget.contactList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // context.read<ContactProvider>().contactModelLoad(widget.contactListModel.elementAt(index).id!);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ContactDetailScreen(
                            contactModel: widget.contactList.elementAt(index))));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),

                /// gesture detector press용 color bug 해소를 위한 container
                child: Container(
                  width: double.infinity,
                  height: 50.0.h,
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      widget.contactList.elementAt(index).profileImage! == ''
                          ? Image.asset('assets/feed/empty_user_profile.png', width: 40, height: 40)
                          : UserProfileImage(
                              profileImageUrl: widget.contactList.elementAt(index).profileImage!),
                      const SizedBox(width: 8),
                      Text(widget.contactList.elementAt(index).name!,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
