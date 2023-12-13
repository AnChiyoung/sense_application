import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/contact/contact_model.dart';
import 'package:sense_flutter_application/public_widget/behavior_collection.dart';
import 'package:sense_flutter_application/public_widget/empty_user_profile.dart';
import 'package:sense_flutter_application/screens/contact/contact_detail_screen.dart';
import 'package:sense_flutter_application/views/contact/contacts_provider.dart';

class ContactListField extends StatefulWidget {
  const ContactListField({super.key});

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
              Consumer<ContactProvider>(builder: (context, data, child) {
                List<ContactModel> dataList = data.callContact;

                if (dataList.isEmpty) {
                  return const SizedBox.shrink();
                } else if (dataList.isNotEmpty) {
                  return Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(left: 20.0),
                          alignment: Alignment.centerLeft,
                          height: 32,
                          color: StaticColor.grey100F6,
                          child: Text('친구',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: StaticColor.black90015,
                                  fontWeight: FontWeight.w500))),
                      ContactBasicField(callContact: dataList),
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              })
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
                // context.read<ContactProvider>().contactModelLoad(widget.callContact.elementAt(index).id!);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ContactDetailScreen(
                            contactModel: widget.callContact.elementAt(index))));
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
                      widget.callContact.elementAt(index).profileImage! == ''
                          ? Image.asset('assets/feed/empty_user_profile.png', width: 40, height: 40)
                          : UserProfileImage(
                              profileImageUrl: widget.callContact.elementAt(index).profileImage!),
                      const SizedBox(width: 8),
                      Text(widget.callContact.elementAt(index).name!,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400)),
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
