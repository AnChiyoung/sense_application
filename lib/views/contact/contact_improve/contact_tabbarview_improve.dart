import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/models/contact/contact_model.dart';
import 'package:sense_flutter_application/views/contact/contact_call_field.dart';
import 'package:sense_flutter_application/views/contact/contact_list_field.dart';
import 'package:sense_flutter_application/views/contact/contacts_provider.dart';
import 'package:sense_flutter_application/views/contact/relation_page/couple.dart';
import 'package:sense_flutter_application/views/contact/relation_page/coworker.dart';
import 'package:sense_flutter_application/views/contact/relation_page/family.dart';
import 'package:sense_flutter_application/views/contact/relation_page/friend.dart';

class ContactTabBarView extends StatefulWidget {
  TabController controller;
  ContactTabBarView({super.key, required this.controller});

  @override
  State<ContactTabBarView> createState() => _ContactTabBarViewState();
}

class _ContactTabBarViewState extends State<ContactTabBarView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        controller: widget.controller,
        children: [
          /// 전체 페이지
          SingleChildScrollView(
            child: ContactListField(),
          ),
          // Consumer<ContactProvider>(
          //     builder: (context, data, child) {
          //
          //       List<ContactModel> contactList = data.callContact;
          //
          //       /// provider contact list가 비어있다면 불러오는 화면을
          //       if(contactList.isEmpty) {
          //         return ContactCallField();
          //         /// provider contact list가 비어있지 않다면 리스트를
          //       } else {
          //         return SingleChildScrollView(child: ContactListField());
          //       }
          //     }
          // ),
          FamilyView(),
          FriendView(),
          CoupleView(),
          CoworkerView(),
          // Container(),
          // Container(),
          // Container(),
          // Container(),
          // Container(),
        ],
      ),
    );
  }
}
