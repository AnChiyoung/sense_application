import 'package:flutter/material.dart';

class ContentBody extends StatelessWidget {
  final List<dynamic> body;
  const ContentBody({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = body
        .map((e) {
          if (e?['type'] == 'paragraph') {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(e?['data']['text'].replaceAll('&nbsp;', '\n'),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, wordSpacing: -0.5)),
            );
          } else if (e?['type'] == 'header') {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16, top: 40),
              child: Text(
                e?['data']['text'],
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else if (e?['type'] == 'image') {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Image.network(e?['data']['file']['url']),
            );
          }
          return Text('${e?['type']} is not supported.');
        })
        .where((element) => element != null)
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}
