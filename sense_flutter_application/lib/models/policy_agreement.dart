import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class PolicyAgreement {
  final String title;
  final Widget ?content;
  bool isSelected;
  bool isRequired;
  final String id;

  PolicyAgreement({
    required this.title,
    this.content,
    this.isSelected = false,
    this.isRequired = false,
  }) : id = Uuid().v4();
}