import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ContactExplanationVeiw extends StatefulWidget {
  @override
  _ContactExplanationVeiw createState() => _ContactExplanationVeiw();
}

class _ContactExplanationVeiw extends State<ContactExplanationVeiw> {
  final certificationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Padding(
        padding:  EdgeInsets.fromLTRB(0, 8, 0, 0),
        child: Text(
          '연락처에서 친구를 가장 빠르게 추가할 수 있어요',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w400,
            color: const Color.fromRGBO(182, 182, 182, 1),

          ),
        ),
      ),
    );
  }


}

