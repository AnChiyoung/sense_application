import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/add_event/regedit_contact_view.dart';

class RegeditContactScreen extends StatefulWidget {
  const RegeditContactScreen({Key? key}) : super(key: key);

  @override
  State<RegeditContactScreen> createState() => _RegeditContactScreenState();
}

class _RegeditContactScreenState extends State<RegeditContactScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                RegeditContactHeader(),
                RegeditContactImage(),
                // RegeditContactBaseInfo(),
                // RegeditContactSex(),
                // RegeditContactRelation(),
              ]
            ),
            // RegeditContactSaveButton(),
          ],
        )
      )
    );
  }
}
