// import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:editorjs_flutter/editorjs_flutter.dart';

class ContentBody extends StatelessWidget {
  final List<dynamic> body;
  ContentBody({super.key, required this.body});

  final Map? style = {
    "cssTags": [
      {"tag": "code", "backgroundColor": "#33ff0000", "color": "#ffff0000", "padding": 5.0},
      {"tag": "mark", "backgroundColor": "#ffffff00", "padding": 5.0}
    ],
    "defaultFont": "Roboto"
  };

  // @override
  // Widget build(BuildContext context) {
  //   return EditorJSView(
  //     editorJSData: jsonEncode(body),
  //     styles: jsonEncode(style),
  //   );
  // }

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
