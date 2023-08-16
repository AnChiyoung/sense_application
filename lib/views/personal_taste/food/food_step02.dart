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

              return Column(
                children: [
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        foodBox(widget.deviceWidth, 0, null, '한식', selectorState[0]),
                        foodBox(widget.deviceWidth, 1, null, '양식', selectorState[1]),
                        foodBox(widget.deviceWidth, 2, null, '일식', selectorState[2]),
                      ]
                  ),
                  SizedBox(height: 24.0.h),
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        foodBox(widget.deviceWidth, 3, null, '중식', selectorState[3]),
                        foodBox(widget.deviceWidth, 4, null, '비건', selectorState[4]),
                        foodBox(widget.deviceWidth, 5, null, '패스트푸드', selectorState[5]),
                      ]
                  ),
                  SizedBox(height: 24.0.h),
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        foodBox(widget.deviceWidth, 6, null, '아시안', selectorState[6]),
                        foodBox(widget.deviceWidth, 7, null, '분식', selectorState[7]),
                        foodBox(widget.deviceWidth, 8, null, '퓨전', selectorState[8]),
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

  Widget foodBox(double width, int index, [String? image, String? title, bool? state]) {

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
          Container(
            width: profileWidth,
            height: profileWidth,
            decoration: BoxDecoration(
              color: StaticColor.grey300E0,
              borderRadius: BorderRadius.circular(8.0),
              border: profileState == false ? null : Border.all(color: StaticColor.mainSoft, width: 4), /// width 쪽에 삼항연산자 줬을 때는 미묘한 width가 있음
            )
          ),
          SizedBox(height: 8.0.h),
          profileTitle.isEmpty ? const SizedBox.shrink() : Text(profileTitle, style: TextStyle(fontSize: 14.0.sp, color: profileState == false ? StaticColor.black90015 : StaticColor.mainSoft, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}