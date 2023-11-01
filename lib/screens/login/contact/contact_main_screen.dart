
import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/login/contact/contact_explanation_view.dart';
import 'package:sense_flutter_application/views/login/contact/contact_title_view.dart';

class ContactMainVeiw extends StatefulWidget {
  const ContactMainVeiw({super.key});

  @override
  _ContactMainVeiw createState() => _ContactMainVeiw();
}

class _ContactMainVeiw extends State<ContactMainVeiw> {
  final certificationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ContactTitleVeiw(),
                  ContactExplanationVeiw()
                ]))
    );
  }


}

