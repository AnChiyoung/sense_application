import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/taste/taste_model.dart';
import 'package:sense_flutter_application/screens/personal_taste/personal_taste_food_screen.dart';
import 'package:sense_flutter_application/views/personal_taste/personal_taste_food_result_view.dart';

class FoodResultScreen extends StatefulWidget {
  FoodTasteModel resultModel;
  FoodResultScreen({super.key, required this.resultModel});

  @override
  State<FoodResultScreen> createState() => _FoodResultScreenState();
}

class _FoodResultScreenState extends State<FoodResultScreen> {
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
          child: SizedBox(
            height: MediaQuery.of(context).size.height - safeAreaTopPadding,
            child: Stack(
              children: [
                Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FoodResultHeader(),
                    Container(
                      color: StaticColor.grey300E0,
                      height: 1.0.h,
                    ),
                    SingleChildScrollView(
                      child: Container(
                        width: double.infinity,
                        child: Image.asset('assets/taste/result_example.png'),
                      )
                    )
                    // Expanded(
                    //   child: Container(
                    //     width: double.infinity,
                    //     height: double.infinity,
                    //     child: Center(
                    //       child: Text('준비 중입니다'),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: SizedBox(
                          height: 56 + safeAreaBottomPadding,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => PersonalTasteFoodScreen()));
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: StaticColor.grey100F6, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
                              child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                                SizedBox(
                                    height: 56,
                                    child: Center(
                                        child: Text('다시하기',
                                            style: TextStyle(
                                                fontSize: 16.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)))),
                              ])),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: SizedBox(
                          height: 56 + safeAreaBottomPadding,
                          child: ElevatedButton(
                              onPressed: () {
                              },
                              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
                              child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                                SizedBox(
                                    height: 56,
                                    child: Center(
                                        child: Text('공유하기',
                                            style: TextStyle(
                                                fontSize: 16.0.sp, color: Colors.white, fontWeight: FontWeight.w700)))),
                              ])),
                        ),
                      )
                    ]
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
