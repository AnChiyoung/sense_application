import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/contact/contact_model.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';
import 'package:sense_flutter_application/screens/contact/contact_info_screen.dart';
import 'package:sense_flutter_application/views/contact/contacts_provider.dart';

class ContactDetailHeader extends StatefulWidget {
  ContactModel contactModel;
  ContactDetailHeader({super.key, required this.contactModel});

  @override
  State<ContactDetailHeader> createState() => _ContactDetailHeaderState();
}

class _ContactDetailHeaderState extends State<ContactDetailHeader> {
  @override
  Widget build(BuildContext context) {
    return HeaderMenu(backCallback: backCallback, rightMenu: ContactDetailHeaderRightMenu(contactModel: widget.contactModel));
  }

  void backCallback() {
    context.read<ContactProvider>().bookmarkedInitialize();
    Navigator.of(context).pop();
  }
}

class ContactDetailHeaderRightMenu extends StatefulWidget {
  ContactModel contactModel;
  ContactDetailHeaderRightMenu({super.key, required this.contactModel});

  @override
  State<ContactDetailHeaderRightMenu> createState() => _ContactDetailHeaderRightMenuState();
}

class _ContactDetailHeaderRightMenuState extends State<ContactDetailHeaderRightMenu> {

  late bool isBookmarked;

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactProvider>(
      builder: (context, data, child) {

        if(data.bookmarkState == null) {
          print('model from params');
          isBookmarked = widget.contactModel.isBookmarked ?? false;
        } else {
          print('model from provider');
          isBookmarked = data.bookmarkState ?? false;
        }

        return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              /// favorite
              // Material(
              //   color: Colors.transparent,
              //   child: SizedBox(
              //     width: 40,
              //     height: 40,
              //     child: InkWell(
              //       borderRadius: BorderRadius.circular(25.0),
              //       onTap: () async {
              //         if(isBookmarked == true) {
              //           ContactModel result = await ContactRequest().unBookmarkedRequest(widget.contactModel.id!);
              //           // context.read<ContactProvider>().bookmarkedChange(result);
              //           setState(() {
              //             isBookmarked = !isBookmarked;
              //           });
              //         } else if(isBookmarked == false) {
              //           ContactModel result = await ContactRequest().bookmarkedRequest(widget.contactModel.id!);
              //           // context.read<ContactProvider>().bookmarkedChange(result);
              //           setState(() {
              //             isBookmarked = !isBookmarked;
              //           });
              //         }
              //       },
              //       child: Center(child: Image.asset('assets/contact/friend_like_empty.png', width: 24, height: 24, color: isBookmarked == true ? StaticColor.mainSoft : Colors.grey)),
              //     ),
              //   ),
              // ),

              Material(
                color: Colors.transparent,
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(25.0),
                    onTap: () async {
                      if(isBookmarked == true) {
                        ContactModel result = await ContactRequest().unBookmarkedRequest(widget.contactModel.id!);
                        context.read<ContactProvider>().infoChange(false);
                      } else if(isBookmarked == false) {
                        ContactModel result = await ContactRequest().bookmarkedRequest(widget.contactModel.id!);
                        context.read<ContactProvider>().infoChange(true);
                      }
                    },
                    child: Center(child: Image.asset('assets/contact/friend_like_empty.png', width: 24, height: 24, color: isBookmarked == true ? StaticColor.mainSoft : Colors.grey)),
                  ),
                ),
              ),

              /// edit trigger
              Material(
                  color: Colors.transparent,
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(25.0),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => ContactInfoScreen(contactModel: widget.contactModel)));
                      },
                      child: Center(child: Image.asset('assets/contact/contact_detail_edit_trigger.png', width: 24, height: 24)),
                    ),
                  )
              ),
            ]
        );
      }
    );
  }
}

