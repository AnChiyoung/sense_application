import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/personal_taste/taste_provider.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';

class FoodStep02 extends StatefulWidget {
  double deviceWidth;
  FoodStep02({super.key, required this.deviceWidth});

  @override
  State<FoodStep02> createState() => _FoodStep02State();
}

class _FoodStep02State extends State<FoodStep02> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 24.0.h),
      child: Column(
        children: [
          ContentDescription(presentPage: 2, totalPage: 7, description: '선호하는 음식의 종류를\n순서대로 선택해 주세요',),
          SizedBox(height: 24.0.h),
          Consumer<TasteProvider>(
            builder: (context, data, child) {

              List<bool> selectorState = data.foodSelector;
              List<int> selectorNumber = [];
              int guideNumeric = 0;
              for(var element in selectorState) {
                if(element == true) {
                  selectorNumber.add(guideNumeric);
                  guideNumeric++;
                } else {
                  selectorNumber.add(0);
                }
              }

              return Column(
                children: [
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        foodBox(widget.deviceWidth, 0, 'assets/taste/food/food01.png', '한식', selectorState[0]),
                        foodBox(widget.deviceWidth, 1, 'assets/taste/food/food02.png', '양식', selectorState[1]),
                        foodBox(widget.deviceWidth, 2, 'assets/taste/food/food03.png', '일식', selectorState[2]),
                      ]
                  ),
                  SizedBox(height: 24.0.h),
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        foodBox(widget.deviceWidth, 3, 'assets/taste/food/food04.png', '중식', selectorState[3]),
                        foodBox(widget.deviceWidth, 4, 'assets/taste/food/food05.png', '비건', selectorState[4]),
                        foodBox(widget.deviceWidth, 5, 'assets/taste/food/food06.png', '패스트푸드', selectorState[5]),
                      ]
                  ),
                  SizedBox(height: 24.0.h),
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        foodBox(widget.deviceWidth, 6, 'assets/taste/food/food07.png', '아시안', selectorState[6]),
                        foodBox(widget.deviceWidth, 7, 'assets/taste/food/food08.png', '분식', selectorState[7]),
                        foodBox(widget.deviceWidth, 8, 'assets/taste/food/food09.png', '퓨전', selectorState[8]),
                      ]
                  ),
                ],
              );
            }
          )
        ],
      ),
    );
  }

  Widget foodBox(double width, int index, int selectorNumber, [String? image, String? title, bool? state]) {

    String profileImage = image ?? '';
    String profileTitle = title ?? '';
    bool profileState = state ?? false;
    double profileWidth = (width - 64.0) / 3;

    return GestureDetector(
      onTap: () {
        context.read<TasteProvider>().foodSelectorChange(index, !profileState);
      },
      child: Column(
        children: [
          Stack(
            children: [
              /// image
              Container(
                  width: profileWidth,
                  height: profileWidth,
                  child: image == null ? const SizedBox.shrink() : FittedBox(
                    fit: BoxFit.fill,
                    child: Image.asset(image!),
                  )
              ),
              /// border
              Container(
                  width: profileWidth,
                  height: profileWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: profileState == false ? null : Border.all(color: StaticColor.mainSoft, width: 4), /// width 쪽에 삼항연산자 줬을 때는 미묘한 width가 있음
                  ),
              ),
              /// number
              profileState == true ? Container(
                width: 32.0.w,
                height: 32.0.h,
                padding: EdgeInsets.only(left: 8.0.w, top: 8.0.h),
                child: Container(
                  decoration: BoxDecoration(
                    color: StaticColor.mainSoft,
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: Text(selector.toString(), style: TextStyle(fontSize: 14.0.sp, color: Colors.white, fontWeight: FontWeight.w500)))
                )
              ) : const SizedBox.shrink(),
            ],
          ),
          SizedBox(height: 8.0.h),
          profileTitle.isEmpty ? const SizedBox.shrink() : Text(profileTitle, style: TextStyle(fontSize: 14.0.sp, color: profileState == false ? StaticColor.black90015 : StaticColor.mainSoft, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}