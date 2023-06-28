import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/add_event/add_event_view.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({Key? key}) : super(key: key);

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // 버튼 제외 상단
            Column(
              children: const [
                CategoryHeaderMenu(),
                CategorySelectTitle(),
                CategorySelect(),
              ],
            ),
            const Align(
                alignment: Alignment.bottomCenter,
                child: NextButton()
            ),
          ],
        ),
      ),
    );
  }
}
