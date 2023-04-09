import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/add_event/with_person_list_view.dart';

class WithPersonScreen extends StatefulWidget {
  const WithPersonScreen({Key? key}) : super(key: key);

  @override
  State<WithPersonScreen> createState() => _WithPersonState();
}

class _WithPersonState extends State<WithPersonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: const [
                ContactListHeader(),
                ContactListTitle(),
                Expanded(child: ContactList()),
              ]
            ),
            const Align(
                alignment: Alignment.bottomCenter,
                child: ContactNextButton()
            ),
          ]
        ),
      ),
    );
  }
}