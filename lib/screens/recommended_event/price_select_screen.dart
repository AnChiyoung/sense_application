import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/recommended_event/price_select_view.dart';

class PriceSelectScreen extends StatefulWidget {
  const PriceSelectScreen({Key? key}) : super(key: key);

  @override
  State<PriceSelectScreen> createState() => _PriceSelectScreenState();
}

class _PriceSelectScreenState extends State<PriceSelectScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // 버튼 제외 상단
            Column(
              children: [
                PriceSelectHeaderMenu(),
                PriceSelectTitle(),
                PriceSelectCategory(),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: PriceSelectNextButton(),
            ),
          ],
        ),
      ),
    );
  }
}
