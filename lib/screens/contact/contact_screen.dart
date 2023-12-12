import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/contact/contact_version02/contact_search_field.dart';
import 'package:sense_flutter_application/views/contact/contact_version02/contact_view.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {

    /// safe area height
    final safeAreaTopPadding = MediaQuery.of(context).padding.top;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: const Scaffold(
        // backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            ContactSearchField(),
            Expanded(child: ContactDataExist())
            // Container(
            //   width: double.infinity,
            //   height: double.infinity,
            //   // height: MediaQuery.of(context).size.height - safeAreaTopPadding,
            //   child: ,
            //   // child: ContactDataSection(),
            // ),
          ],
        ),
      ),
    );
  }
}
