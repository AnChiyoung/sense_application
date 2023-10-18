import 'package:flutter/material.dart';
import 'package:sense_flutter_application/screens/test_screen/page_test.dart';
import 'package:sense_flutter_application/views/store/store_view.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            StoreHeader(),
            PageTest(),
          ],
        ),
      ),
    );
  }
}
