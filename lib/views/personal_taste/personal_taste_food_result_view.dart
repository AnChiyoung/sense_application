import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/taste/taste_model.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';
import 'package:sense_flutter_application/screens/my_page/my_page_screen.dart';
import 'package:sense_flutter_application/views/personal_taste/taste_provider.dart';

class FoodResultHeader extends StatefulWidget {
  const FoodResultHeader({super.key});

  @override
  State<FoodResultHeader> createState() => _FoodResultHeaderState();
}

class _FoodResultHeaderState extends State<FoodResultHeader> {
  @override
  Widget build(BuildContext context) {
    return HeaderMenu(backCallback: backCallback, title: '음식 취향', rightMenu: complete());
  }

  void backCallback() {
    Navigator.of(context).pop();
  }

  Widget complete() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          Navigator.of(context).pop();
          // if(foodTasteInputResult == true) {
          //
          // } else {
          //
          // }
        },
        borderRadius: BorderRadius.circular(25.0),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6.0.h),
          child: Text('완료', style: TextStyle(fontSize: 16.0.sp, color: StaticColor.mainSoft, fontWeight: FontWeight.w700))),
      )
    );
  }
}
