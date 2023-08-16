import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/personal_taste/taste_provider.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';

class TravelStep02 extends StatefulWidget {
  const TravelStep02({super.key});

  @override
  State<TravelStep02> createState() => _TravelStep02State();
}

class _TravelStep02State extends State<TravelStep02> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 24.0.h),
      child: Column(
        children: [
          ContentDescription(presentPage: 2, totalPage: 6, description: '선호하는 여행지의\n거리 정도를 선택해 주세요',),
          SizedBox(height: 24.0.h),
          Consumer<TasteProvider>(
              builder: (context, data, child) {

                List<bool> distanceState = data.distanceSelector;

                return Column(
                    children: [
                      distanceBox(0, distanceState[0], '1시간 이내', '국내 여행지', '', '', Colors.transparent),
                      SizedBox(height: 12.0.h),
                      distanceBox(1, distanceState[1], '3시간 이내', '일본, 중국, 국내 지방', '', '', Colors.transparent),
                      SizedBox(height: 12.0.h),
                      distanceBox(2, distanceState[2], '5시간 이내', '동남아, 국내 지방 등', '', '', Colors.transparent),
                      SizedBox(height: 12.0.h),
                      distanceBox(3, distanceState[3], '12시간 이내', '동유럽', '', '', Colors.transparent),
                      SizedBox(height: 12.0.h),
                      distanceBox(4, distanceState[4], '비행기로 하루 이상', '모든 여행지', '', '', Colors.transparent),
                    ]
                );
              }
          )
        ],
      ),
    );
  }

  Widget distanceBox(int index, bool state, String step, String define, String example, String imageAsset, Color doneColor) {

    // List<Widget> image = [];
    // for(int i = 0; i < int.parse(step); i++) {
    //   image.add(Image.asset(imageAsset, width: 20.0.w, height: 20.0.h, color: state == false ? StaticColor.grey400BB : doneColor));
    // }

    return GestureDetector(
      onTap: () {
        context.read<TasteProvider>().distanceSelectorChange(index, !state);
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
                                child: Text(step, style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                              ),
                              SizedBox(width: 8.0.w),
                              Text(define, style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
                            ],
                          ),
                          // Row(
                          //     children: image
                          // ),
                        ],
                      ),
                      SizedBox(height: 5.0.h),
                      /// down line
                      Text(example, style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                    ]
                )
            ),
          )
        ],
      ),
    );
  }
}
