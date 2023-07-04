import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';

class BottomButtonView extends StatefulWidget {
  const BottomButtonView({super.key});

  @override
  State<BottomButtonView> createState() => _BottomButtonViewState();
}

class _BottomButtonViewState extends State<BottomButtonView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: 76, color: StaticColor.grey100F6,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: Align(
                alignment: Alignment.center,
                child: Text('이벤트 만들기', style: TextStyle(fontSize: 16, color: StaticColor.grey70055, fontWeight: FontWeight.w700))),
            )
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
              height: 76, color: StaticColor.bottomButtonColor,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: Align(
                    alignment: Alignment.center,
                    child: Text('선물하기', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700))),
              )
          ),
        ),
      ],
    );
  }
}
