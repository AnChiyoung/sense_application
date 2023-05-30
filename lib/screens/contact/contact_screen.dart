import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/contact/contact_list_field.dart';
import 'package:sense_flutter_application/views/contact/contact_search_field.dart';
import 'package:sense_flutter_application/views/contact/contacts_provider.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

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
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          height: MediaQuery.of(context).size.height - safeAreaTopPadding,
          child: Column(
            children: [
              ContactSearchField(),
              Container(width: double.infinity, height: 1, color: StaticColor.grey200EE),
              Consumer<ContactProvider>(
                builder: (context, data, child) => data.searchState == true ?
                  SearchResultField() : Expanded(child: ContactListField())),
            ],
          ),
        ),
      ),
    );
  }
}
