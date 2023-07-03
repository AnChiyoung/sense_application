import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/contact/detail/contact_detail_friend_info_view.dart';
import 'package:sense_flutter_application/views/contact/detail/contact_detail_header_view.dart';

class ContactFriendScreen extends StatefulWidget {
  const ContactFriendScreen({Key? key}) : super(key: key);

  @override
  State<ContactFriendScreen> createState() => _ContactFriendScreenState();
}

class _ContactFriendScreenState extends State<ContactFriendScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            ContactDetailHeader(),
            Container(height: 1.0, color: StaticColor.grey200EE),
            ContactDetailFriendInfoView(),
            // ContactDetailView(),
          ]
        ),
      ),
    );
  }
}
