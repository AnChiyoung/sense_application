import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/personal_taste/taste_provider.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';

class LodgingStep04 extends StatefulWidget {
  double deviceWidth;
  LodgingStep04({super.key, required this.deviceWidth});

  @override
  State<LodgingStep04> createState() => _LodgingStep04State();
}

class _LodgingStep04State extends State<LodgingStep04> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 24.0.h),
      child: Column(
        children: [
          ContentDescription(presentPage: 4, totalPage: 6, description: '숙소에서 꼭 필요한 비품을\n순서대로 선택해 주세요',),
          SizedBox(height: 24.0.h),
          Consumer<TasteProvider>(
              builder: (context, data, child) {

                List<bool> selectorState = data.lodgingToolSelector;

                return Column(
                  children: [
                    Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          lodgingToolBox(widget.deviceWidth, 0, null, '와이파이', selectorState[0]),
                          lodgingToolBox(widget.deviceWidth, 1, null, '주차장', selectorState[1]),
                          lodgingToolBox(widget.deviceWidth, 2, null, '헬스장', selectorState[2]),
                        ]
                    ),
                    SizedBox(height: 24.0.h),
                    Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          lodgingToolBox(widget.deviceWidth, 3, null, '컴퓨터', selectorState[3]),
                          lodgingToolBox(widget.deviceWidth, 4, null, '레스토랑', selectorState[4]),
                          lodgingToolBox(widget.deviceWidth, 5, null, '주방', selectorState[5]),
                        ]
                    ),
                    SizedBox(height: 24.0.h),
                    Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          lodgingToolBox(widget.deviceWidth, 6, null, '세탁 서비스', selectorState[6]),
                          lodgingToolBox(widget.deviceWidth, 7, null, '바', selectorState[7]),
                          lodgingToolBox(widget.deviceWidth, 8, null, '개인금고', selectorState[8]),
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

  Widget lodgingToolBox(double width, int index, [String? image, String? title, bool? state]) {

    String profileImage = image ?? '';
    String profileTitle = title ?? '';
    bool profileState = state ?? false;
    double profileWidth = (width - 64.0) / 3;

    return GestureDetector(
      onTap: () {
        context.read<TasteProvider>().lodgingToolSelectorChange(index, !profileState);
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
