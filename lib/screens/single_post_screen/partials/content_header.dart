import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ContentHeader extends StatelessWidget {
  final String title;
  final String startDate;
  final String endDate;

  const ContentHeader(
      {super.key, required this.title, required this.startDate, required this.endDate});

  @override
  Widget build(BuildContext context) {
    var sDate = DateFormat('yyy-dd-mm').parse(startDate);
    var eDate = DateFormat('yyy-dd-mm').parse(endDate);

    return Container(
        padding: const EdgeInsets.only(bottom: 12),
        margin: const EdgeInsets.only(bottom: 12),
        width: double.infinity,
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: Color(0xFFEEEEEE)))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              textAlign: TextAlign.left,
              title,
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF333333)),
            ),
            // const SizedBox(height: 32),
            const Text(
              '이벤트 기간',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF555555)),
            ),
            const SizedBox(height: 4),
            Text(
                '${DateFormat('yyyy. MM. dd').format(sDate)} ~ ${DateFormat('MM. dd').format(eDate)}',
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF777777)))
          ],
        ));
  }
}
