import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/contact/contact_model.dart';
import 'package:sense_flutter_application/public_widget/empty_user_profile.dart';

class ContactDetailFriendInfoView extends StatefulWidget {
  ContactModel contactModel;
  ContactDetailFriendInfoView({super.key, required this.contactModel});

  @override
  State<ContactDetailFriendInfoView> createState() => _ContactDetailFriendInfoViewState();
}

class _ContactDetailFriendInfoViewState extends State<ContactDetailFriendInfoView> {

  String name = '';
  String relation = '';
  String phoneNumber = '';

  @override
  void initState() {
    name = widget.contactModel.name!;
    relation = widget.contactModel.contactCategoryObject!.title!;
    phoneNumber = widget.contactModel.phone!.isEmpty ? '미등록' : widget.contactModel.phone!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 18.0),
      child: Container(
        width: double.infinity,
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
                  const SizedBox(width: 16.0),
                  /// name, phone number
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(name, style: TextStyle(fontSize: 20, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
                          const SizedBox(width: 8.0),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                                child: Text(relation, style: TextStyle(fontSize: 12, color: StaticColor.grey70055, fontWeight: FontWeight.w400))),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Text(phoneNumber, style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              /// bottom event count, favorite count
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('이벤트', style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                              const SizedBox(width: 16.0),
                              Text('0', style: TextStyle(fontSize: 14, color: StaticColor.mainSoft, fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('취향', style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                              const SizedBox(width: 16.0),
                              Text('0', style: TextStyle(fontSize: 14, color: StaticColor.mainSoft, fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                      ),
                    ),
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
