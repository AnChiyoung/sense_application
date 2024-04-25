import 'package:flutter/material.dart';

class EventColor {
  final int id;

  const EventColor({required this.id});

  Color getColor() {
    switch (id) {
      case 1:
        return const Color(0xFFFA8836);
      case 2:
        return const Color(0xFFFF7B8B);
      case 3:
        return const Color(0xFF00CB9A);
      case 4:
        return const Color(0xFF3E97FF);
      case 7:
        return const Color(0xFFA479FF);
      default:
        return const Color(0xFF3E97FF);
    }
  }
}
