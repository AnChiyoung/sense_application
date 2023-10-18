import 'package:flutter/material.dart';

class PageTest extends StatefulWidget {
  const PageTest({super.key});

  @override
  State<PageTest> createState() => _PageTestState();
}

class _PageTestState extends State<PageTest> {

  PageController c = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: c,
      scrollDirection: Axis.horizontal,
      children: [
        Expanded(child: Container(width: double.infinity, height: double.infinity, color: Colors.green)),
        Expanded(child: Container(width: double.infinity, height: double.infinity, color: Colors.red))
      ],
    );
  }
}
