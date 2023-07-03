import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/contact/contact_model.dart';
import 'package:sense_flutter_application/public_widget/behavior_collection.dart';
import 'package:sense_flutter_application/screens/contact/contact_detail_screen.dart';
import 'package:sense_flutter_application/views/contact/contacts_provider.dart';

class ContactListField extends StatefulWidget {
  const ContactListField({Key? key}) : super(key: key);

  @override
  State<ContactListField> createState() => _ContactListFieldState();
}

class _ContactListFieldState extends State<ContactListField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Column(
            children: [
              // /// favorite field
              // Column(
              //   children: [
              //     Container(
              //       padding: const EdgeInsets.only(left: 20.0),
              //       alignment: Alignment.centerLeft,
              //       height: 32,
              //       color: StaticColor.grey100F6,
              //       child: Text('즐겨찾기', style: TextStyle(fontSize: 14, color: StaticColor.black90015, fontWeight: FontWeight.w500),),),
              //     /// favorite list insert
              //   ],
              // ),
              //
              // const SizedBox(height: 16.0),
              //
              // /// birthday field
              // Column(
              //   children: [
              //     Container(
              //       padding: const EdgeInsets.only(left: 20.0),
              //       alignment: Alignment.centerLeft,
              //       height: 32,
              //       color: StaticColor.grey100F6,
              //       child: Text('생일인 친구', style: TextStyle(fontSize: 14, color: StaticColor.black90015, fontWeight: FontWeight.w500))),
              //     /// birthday field
              //   ],
              // ),
              //
              // const SizedBox(height: 16.0),

              /// friends
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 20.0),
                    alignment: Alignment.centerLeft,
                    height: 32,
                    color: StaticColor.grey100F6,
                    child: Text('친구', style: TextStyle(fontSize: 14, color: StaticColor.black90015, fontWeight: FontWeight.w500))),

                  Consumer<ContactProvider>(
                    builder: (context, data, child) {

                      if(data.callContact.isEmpty) {
                        return const SizedBox.shrink();
                      } else {
                        return ContactBasicField(callContact: data.callContact);
                      }
                    }
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ContactBasicField extends StatefulWidget {
  List<ContactModel> callContact;
  ContactBasicField({super.key, required this.callContact});

  @override
  State<ContactBasicField> createState() => _ContactBasicFieldState();
}

class _ContactBasicFieldState extends State<ContactBasicField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView.builder(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.callContact.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => ContactFriendScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),

                /// gesture detector press용 color bug 해소를 위한 container
                child: Container(
                  width: double.infinity,
                  height: 50,
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Image.asset('assets/contact/empty_profile.png', width: 40, height: 40),
                      const SizedBox(width: 8),
                      Text(widget.callContact.elementAt(index).name!,
                          style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

