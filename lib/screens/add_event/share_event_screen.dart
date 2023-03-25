import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/add_event/share_event_view.dart';

class ShareEventScreen extends StatefulWidget {
  const ShareEventScreen({Key? key}) : super(key: key);

  @override
  State<ShareEventScreen> createState() => _ShareEventScreenState();
}

class _ShareEventScreenState extends State<ShareEventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            ShareEventHeader(),
            ShareEventContent(),
          ],
        ),
      ),
    );
  }
}
