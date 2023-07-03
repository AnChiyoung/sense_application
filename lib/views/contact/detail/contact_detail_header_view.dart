import 'package:flutter/material.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';

class ContactDetailHeader extends StatefulWidget {
  const ContactDetailHeader({super.key});

  @override
  State<ContactDetailHeader> createState() => _ContactDetailHeaderState();
}

class _ContactDetailHeaderState extends State<ContactDetailHeader> {
  @override
  Widget build(BuildContext context) {
    return HeaderMenu(backCallback: backCallback, rightMenu: const ContactDetailHeaderRightMenu());
  }

  void backCallback() {
    Navigator.of(context).pop();
  }
}

class ContactDetailHeaderRightMenu extends StatefulWidget {
  const ContactDetailHeaderRightMenu({super.key});

  @override
  State<ContactDetailHeaderRightMenu> createState() => _ContactDetailHeaderRightMenuState();
}

class _ContactDetailHeaderRightMenuState extends State<ContactDetailHeaderRightMenu> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        /// favorite
        Material(
          color: Colors.transparent,
          child: SizedBox(
            width: 40,
            height: 40,
            child: InkWell(
              borderRadius: BorderRadius.circular(25.0),
              onTap: () {},
              child: Center(child: Image.asset('assets/contact/friend_like_empty.png', width: 24, height: 24)),
            ),
          )
        ),
        /// edit trigger
        Material(
            color: Colors.transparent,
            child: SizedBox(
              width: 40,
              height: 40,
              child: InkWell(
                borderRadius: BorderRadius.circular(25.0),
                onTap: () {},
                child: Center(child: Image.asset('assets/contact/contact_detail_edit_trigger.png', width: 24, height: 24)),
              ),
            )
        ),
      ]
    );
  }
}

