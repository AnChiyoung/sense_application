import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/personal_taste/taste_provider.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';

class TravelStep03 extends StatefulWidget {
  double deviceWidth;
  TravelStep03({super.key, required this.deviceWidth});

  @override
  State<TravelStep03> createState() => _TravelStep03State();
}

class _TravelStep03State extends State<TravelStep03> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 24.0.h),
      child: Column(
        children: [
          ContentDescription(presentPage: 3, totalPage: 6, description: '선호하는 여행지의\n유형을 순서대로 선택해 주세요',),
          SizedBox(height: 24.0.h),
          Consumer<TasteProvider>(
              builder: (context, data, child) {

                List<bool> selectorState = data.themeSelector;

                return Column(
                  children: [
                    Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          themeBox(widget.deviceWidth, 0, null, '번화가 근처', selectorState[0]),
                          themeBox(widget.deviceWidth, 1, null, '관광지 근처', selectorState[1]),
                          themeBox(widget.deviceWidth, 2, null, '독채', selectorState[2]),
                        ]
                    ),
                    SizedBox(height: 24.0.h),
                    Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          themeBox(widget.deviceWidth, 3, null, '자연친화적', selectorState[3]),
                          themeBox(widget.deviceWidth, 4, null, '교통/역세권', selectorState[4]),
                          themeBox(widget.deviceWidth, 5, null, '도심', selectorState[5]),
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

  Widget themeBox(double width, int index, [String? image, String? title, bool? state]) {

    String profileImage = image ?? '';
    String profileTitle = title ?? '';
    bool profileState = state ?? false;
    double profileWidth = (width - 64.0) / 3;

    return GestureDetector(
      onTap: () {
        context.read<TasteProvider>().themeSelectorChange(index, !profileState);
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
