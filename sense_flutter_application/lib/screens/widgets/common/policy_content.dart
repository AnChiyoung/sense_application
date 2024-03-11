import 'package:flutter/material.dart';

class PolicyContent extends StatelessWidget {

  final String title;
  final String content;

  const PolicyContent({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    Widget _widget = Container( 
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(bottom: 8),
            child: Text(
                title,
              textAlign: TextAlign.start,
            ),
          ),
          Text(
            content,
          ),
        ],
      ),
  );

    return _widget;
  }
}