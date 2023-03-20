import 'package:flutter/material.dart';

class RegeditContactHeader extends StatefulWidget {
  const RegeditContactHeader({Key? key}) : super(key: key);

  @override
  State<RegeditContactHeader> createState() => _RegeditContactHeaderState();
}

class _RegeditContactHeaderState extends State<RegeditContactHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 26.43),
              child: GestureDetector(
                onTap: () {},
                  child: Image.asset('assets/add_event/button_back.png', width: 24, height: 24)),
            ),
          )
        ]
      )
    );
  }
}
