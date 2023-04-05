import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/recommended_event/present_memo_view.dart';

class PresentMemoScreen extends StatefulWidget {
  const PresentMemoScreen({Key? key}) : super(key: key);

  @override
  State<PresentMemoScreen> createState() => _PresentMemoScreenState();
}

class _PresentMemoScreenState extends State<PresentMemoScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector( // will use for keyboard hide
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              // 버튼 제외 상단
              Column(
                children: const [
                  MemoHeaderMenu(),
                  MemoTitle(),
                  MemoDescription(),
                ],
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: MemoNextButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
