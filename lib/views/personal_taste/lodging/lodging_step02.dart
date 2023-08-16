import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/personal_taste/taste_provider.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';

class LodgingStep02 extends StatefulWidget {
  double deviceWidth;
  LodgingStep02({super.key, required this.deviceWidth});

  @override
  State<LodgingStep02> createState() => _LodgingStep02State();
}

class _LodgingStep02State extends State<LodgingStep02> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 24.0.h),
      child: Column(
        children: [
          ContentDescription(presentPage: 2, totalPage: 6, description: '선호하는 숙소의 종류를\n순서대로 선택해 주세요',),
          SizedBox(height: 24.0.h),
          Consumer<TasteProvider>(
              builder: (context, data, child) {

                List<bool> selectorState = data.lodgingSelector;

                return Column(
                  children: [
                    Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          lodgingBox(widget.deviceWidth, 0, null, '호텔', selectorState[0]),
                          lodgingBox(widget.deviceWidth, 1, null, '모텔', selectorState[1]),
                          lodgingBox(widget.deviceWidth, 2, null, '게스트하우스', selectorState[2]),
                        ]
                    ),
                    SizedBox(height: 24.0.h),
                    Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          lodgingBox(widget.deviceWidth, 3, null, '도미토리', selectorState[3]),
                          lodgingBox(widget.deviceWidth, 4, null, '에어비앤비', selectorState[4]),
                          lodgingBox(widget.deviceWidth, 5, null, '민박', selectorState[5]),
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

  Widget lodgingBox(double width, int index, [String? image, String? title, bool? state]) {

    String profileImage = image ?? '';
    String profileTitle = title ?? '';
    bool profileState = state ?? false;
    double profileWidth = (width - 64.0) / 3;

    return GestureDetector(
      onTap: () {
        context.read<TasteProvider>().lodgingSelectorChange(index, !profileState);
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
