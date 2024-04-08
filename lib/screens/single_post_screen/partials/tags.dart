import 'package:flutter/material.dart';

class Tags extends StatelessWidget {
  final List<String> tags;

  const Tags({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      // runSpacing: 8.0,
      children: tags.map((tag) {
        return Chip(
          backgroundColor: const Color(0xFFF6F6F6),
          label: Text(tag),
          labelStyle: const TextStyle(
              color: Color(0xFF777777), fontSize: 12.0, fontWeight: FontWeight.w500),
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        );
      }).toList(),
    );
  }
}
