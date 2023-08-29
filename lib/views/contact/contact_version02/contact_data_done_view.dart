import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/contact/contact_model.dart';
import 'package:sense_flutter_application/views/contact/contact_version02/contact_search_field.dart';
import 'package:sense_flutter_application/views/contact/contact_version02/contact_data_section.dart';
import 'package:sense_flutter_application/views/contact/contacts_provider.dart';

class ContactDataDone extends StatefulWidget {
  List<List<ContactModel>> contactCollector;
  ContactDataDone({super.key, required this.contactCollector});

  @override
  State<ContactDataDone> createState() => _ContactDataDoneState();
}

class _ContactDataDoneState extends State<ContactDataDone> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// searchbox
        // ContactSearchField(),
        /// divide line
        Container(width: double.infinity, height: 1.0.h, color: StaticColor.grey200EE),
        /// searchbox under field
        // Expanded(child: ContactDataSection(contactCollector: widget.contactCollector))
        Consumer<ContactProvider>( // ContactListView()
          builder: (context, data, child) => data.searchState == true ? const SearchResultSection() : Expanded(child: ContactDataSection(contactCollector: widget.contactCollector))
        ),
      ],
    );
  }
}