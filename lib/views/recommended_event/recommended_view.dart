import 'package:flutter/material.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';

class RecommendedTitle extends StatefulWidget {
  const RecommendedTitle({Key? key}) : super(key: key);

  @override
  State<RecommendedTitle> createState() => _RecommendedTitleState();
}

class _RecommendedTitleState extends State<RecommendedTitle> {
  @override
  Widget build(BuildContext context) {
    return HeaderMenu(backCallback: backCallback, title: '추천');
  }

  void backCallback() {
    Navigator.of(context).pop();
  }
}
