import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/recommended_event/region_select_view.dart';

class RegionSelectScreen extends StatefulWidget {
  const RegionSelectScreen({Key? key}) : super(key: key);

  @override
  State<RegionSelectScreen> createState() => _RegionSelectScreenState();
}

class _RegionSelectScreenState extends State<RegionSelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // 버튼 제외 상단
            Column(
              children: [
                RegionSelectHeaderMenu(),
                RegionSelectTitle(),
                RegionSelectCategory(),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: StaticColor.regionSectionDivideColor,
                ),
                RegionSelectSubCategory(),
              ],
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: RegionSelectNextButton(),
            ),
          ],
        ),
      ),
    );
  }
}
