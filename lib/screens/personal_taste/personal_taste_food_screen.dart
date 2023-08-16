import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/personal_taste/personal_taste_food_view.dart';

class PersonalTasteFoodScreen extends StatefulWidget {
  const PersonalTasteFoodScreen({super.key});

  @override
  State<PersonalTasteFoodScreen> createState() => _PersonalTasteFoodScreenState();
}

class _PersonalTasteFoodScreenState extends State<PersonalTasteFoodScreen> {
  @override
  Widget build(BuildContext context) {

    /// safe area height
    final safeAreaTopPadding = MediaQuery.of(context).padding.top;
    final safeAreaBottomPadding = MediaQuery.of(context).padding.bottom;
    final deviceWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          bottom: false,
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - safeAreaTopPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      FoodHeader(),
                      FoodContent(deviceWidth: deviceWidth),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: FoodButton(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
