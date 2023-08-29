import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/personal_taste/taste_provider.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';

class FoodStep04 extends StatefulWidget {
  const FoodStep04({super.key});

  @override
  State<FoodStep04> createState() => _FoodStep04State();
}

class _FoodStep04State extends State<FoodStep04> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 24.0.h),
      child: Column(
        children: [
          ContentDescription(presentPage: 4, totalPage: 7, description: '선호하는 단맛의\n영역을 선택해 주세요',),
          SizedBox(height: 24.0.h),
          Consumer<TasteProvider>(
              builder: (context, data, child) {

                List<bool> candyState = data.candySelector;

                return Column(
                    children: [
                      candyBox(0, candyState[0], '1', '달지 않은 맛', '무가당 스낵', 'assets/taste/food/candy/candy.png', 'assets/taste/food/candy/candy01.png', StaticColor.candyColor),
                      SizedBox(height: 12.0.h),
                      candyBox(1, candyState[1], '2', '약간 단맛', '수박, 복숭아', 'assets/taste/food/candy/candy.png', 'assets/taste/food/candy/candy02.png', StaticColor.candyColor),
                      SizedBox(height: 12.0.h),
                      candyBox(2, candyState[2], '3', '보통 단맛', '아이스크림, 쿠키', 'assets/taste/food/candy/candy.png', 'assets/taste/food/candy/candy03.png', StaticColor.candyColor),
                      SizedBox(height: 12.0.h),
                      candyBox(3, candyState[3], '4', '단맛', '초콜릿, 사탕', 'assets/taste/food/candy/candy.png', 'assets/taste/food/candy/candy04.png', StaticColor.candyColor),
                      SizedBox(height: 12.0.h),
                      candyBox(4, candyState[4], '5', '정말 단맛', '설탕시럽, 꿀', 'assets/taste/food/candy/candy.png', 'assets/taste/food/candy/candy05.png', StaticColor.candyColor),
                    ]
                );
              }
          )
        ],
      ),
    );
  }

  Widget candyBox(int index, bool state, String step, String define, String example, String imageAsset, String backgroundImageAsset, Color doneColor) {

    List<Widget> image = [];
    for(int i = 0; i < int.parse(step); i++) {
      image.add(Image.asset(imageAsset, width: 20.0.w, height: 20.0.h, color: state == false ? StaticColor.grey400BB : doneColor));
    }

    return GestureDetector(
      onTap: () {
        context.read<TasteProvider>().candySelectorChange(index, !state);
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
                  color: StaticColor.grey100F6,
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
