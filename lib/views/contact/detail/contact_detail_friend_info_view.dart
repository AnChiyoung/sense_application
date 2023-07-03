import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/public_widget/empty_user_profile.dart';

class ContactDetailFriendInfoView extends StatefulWidget {
  const ContactDetailFriendInfoView({super.key});

  @override
  State<ContactDetailFriendInfoView> createState() => _ContactDetailFriendInfoViewState();
}

class _ContactDetailFriendInfoViewState extends State<ContactDetailFriendInfoView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 18.0),
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: StaticColor.grey100F6,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  /// user profile
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: UserProfileImage(profileImageUrl: null)),
                  /// name, phone number
                  Column(
                    children: [

                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
