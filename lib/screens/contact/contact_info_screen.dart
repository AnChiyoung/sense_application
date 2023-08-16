import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/contact/contact_model.dart';
import 'package:sense_flutter_application/views/contact/contact_info_view.dart';

class ContactInfoScreen extends StatefulWidget {
  ContactModel contactModel;
  ContactInfoScreen({super.key, required this.contactModel});

  @override
  State<ContactInfoScreen> createState() => _ContactInfoScreenState();
}

class _ContactInfoScreenState extends State<ContactInfoScreen> {
  @override
  Widget build(BuildContext context) {

    /// safe area height
    final safeAreaTopPadding = MediaQuery.of(context).padding.top;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Column(
                children: [
                  ContactInfoHeader(),
                  Container(
                    height: 1.0,
                    color: StaticColor.grey300E0,
                  ),
                  ContactInfoUserProfile(contactModel: widget.contactModel),
                  ContactInfoBasic(contactModel: widget.contactModel),
                  ContactInfoGender(contactModel: widget.contactModel),
                  ContactInfoCategory(contactModel: widget.contactModel),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ContactInfoSaveButton(contactModel: widget.contactModel, topPadding: safeAreaTopPadding, height: screenHeight),
              )
            ],
          ),
        ),
      ),
    );
  }
}
