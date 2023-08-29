import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/personal_taste/taste_provider.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';

class FoodStep03 extends StatefulWidget {
  const FoodStep03({super.key});

  @override
  State<FoodStep03> createState() => _FoodStep03State();
}

class _FoodStep03State extends State<FoodStep03> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 24.0.h),
      child: Column(
        children: [
          ContentDescription(presentPage: 3, totalPage: 7, description: '선호하는 매운맛의\n수준을 선택해 주세요',),
          SizedBox(height: 24.0.h),
          Consumer<TasteProvider>(
            builder: (context, data, child) {

              List<bool> spicyState = data.spicySelector;

              return Column(
                children: [
                  spicyBox(0, spicyState[0], '1', '순한맛', '피망', 'assets/taste/food/spicy/spicy.png', 'assets/taste/food/spicy/spicy01.png', StaticColor.errorColor),
                  SizedBox(height: 12.0.h),
                  spicyBox(1, spicyState[1], '2', '약간 매운맛', '순한맛 떡볶이, 라면', 'assets/taste/food/spicy/spicy.png', 'assets/taste/food/spicy/spicy02.png', StaticColor.errorColor),
                  SizedBox(height: 12.0.h),
                  spicyBox(2, spicyState[2], '3', '보통 매운맛', '매운라면', 'assets/taste/food/spicy/spicy.png', 'assets/taste/food/spicy/spicy03.png', StaticColor.errorColor),
                  SizedBox(height: 12.0.h),
                  spicyBox(3, spicyState[3], '4', '얼얼한 매운맛', '핫소스', 'assets/taste/food/spicy/spicy.png', 'assets/taste/food/spicy/spicy04.png', StaticColor.errorColor),
                  SizedBox(height: 12.0.h),
                  spicyBox(4, spicyState[4], '5', '정말 매운맛', '핵불닭볶음면, 실비김치', 'assets/taste/food/spicy/spicy.png', 'assets/taste/food/spicy/spicy05.png', StaticColor.errorColor),
                ]
              );
            }
          )
        ],
      ),
    );
  }

  Widget spicyBox(int index, bool state, String step, String define, String example, String imageAsset, String backgroundImageAsset, Color doneColor) {

    List<Widget> image = [];
    for(int i = 0; i < int.parse(step); i++) {
      image.add(Image.asset(imageAsset, width: 20.0.w, height: 20.0.h, color: state == false ? StaticColor.grey400BB : doneColor));
    }

    return GestureDetector(
      onTap: () {
        context.read<TasteProvider>().spicySelectorChange(index, !state);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 15.0.h),
            child: state == false ? Image.asset('assets/signin/policy_check_empty.png', width: 24.0.w, height: 24.0.h) : Image.asset('assets/signin/policy_check_done.png', width: 24.0.w, height: 24.0.h)),
          SizedBox(width: 8.0.w),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w, top: 16.0.h, bottom: 12.0.h),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(backgroundImageAsset),
                ),
                // color: StaticColor.grey100F6,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  /// up line
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 4.0.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Text('$step단계', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                          ),
                          SizedBox(width: 8.0.w),
                          Text(define, style: TextStyle(fontSize: 12.0.sp, color: Colors.white, fontWeight: FontWeight.w700)),
                        ],
                      ),
                      Row(
                        children: image
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0.h),
                  /// down line
                  Text(example, style: TextStyle(fontSize: 12.0.sp, color: Colors.white, fontWeight: FontWeight.w400)),
                ]
              )
            ),
          )
        ],
      ),
    );
  }
}
