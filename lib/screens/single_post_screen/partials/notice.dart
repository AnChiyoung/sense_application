import 'package:flutter/material.dart';

class Notice extends StatelessWidget {
  final List<String> bulletList;

  const Notice({super.key, this.bulletList = const []});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('유의사항',
            style: TextStyle(
                color: Color(0xFF555555),
                fontWeight: FontWeight.w700,
                fontSize: 16.0,
                fontFamily: 'Pretendard')),
        const SizedBox(height: 10),
        ...bulletList.map((e) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('•', style: TextStyle(fontSize: 16.0)),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    e,
                    style: const TextStyle(
                        color: Color(0xFF777777),
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                        fontFamily: 'Pretendard'),
                  ),
                ),
              ],
            ) as Widget),
      ],
    );
  }
}
