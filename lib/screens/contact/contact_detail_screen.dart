import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/contact/contact_model.dart';
import 'package:sense_flutter_application/views/contact/detail/ai_analytics_view.dart';
import 'package:sense_flutter_application/views/contact/detail/bottom_button_view.dart';
import 'package:sense_flutter_application/views/contact/detail/combine_event_view.dart';
import 'package:sense_flutter_application/views/contact/detail/contact_detail_friend_info_view.dart';
import 'package:sense_flutter_application/views/contact/detail/contact_detail_header_view.dart';
import 'package:sense_flutter_application/views/contact/detail/favorite_view.dart';

class ContactFriendScreen extends StatefulWidget {
  ContactModel contactModel;
  ContactFriendScreen({Key? key, required this.contactModel}) : super(key: key);

  @override
  State<ContactFriendScreen> createState() => _ContactFriendScreenState();
}

class _ContactFriendScreenState extends State<ContactFriendScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                ContactDetailHeader(contactModel: widget.contactModel),
                Container(height: 1.0, color: StaticColor.grey200EE),
                ContactDetailFriendInfoView(contactModel: widget.contactModel),
                AiAnalyticsView(),
                CombineEventView(),
                FavoriteListView(contactModel: widget.contactModel),
                // ContactDetailView(),
              ]
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BottomButtonView(),
            )
          ],
        ),
      ),
    );
  }
}
