import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/personal_taste/taste_provider.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';

class TravelStep04 extends StatefulWidget {
  const TravelStep04({super.key});

  @override
  State<TravelStep04> createState() => _TravelStep04State();
}

class _TravelStep04State extends State<TravelStep04> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 24.0.h),
      child: Column(
        children: [
          ContentDescription(presentPage: 4, totalPage: 6, description: '선호하는 여행 인원의\n정도를 선택해 주세요',),
          SizedBox(height: 24.0.h),
          Consumer<TasteProvider>(
              builder: (context, data, child) {

                List<bool> distanceState = data.peopleSelector;

                return Column(
                    children: [
                      peopleBox(0, distanceState[0], '1명', '혼자 여행', '', '', Colors.transparent),
                      SizedBox(height: 12.0.h),
                      peopleBox(1, distanceState[1], '2명', '친구, 연인과의 여행', '', '', Colors.transparent),
                      SizedBox(height: 12.0.h),
                      peopleBox(2, distanceState[2], '3명~5명', '가족, 마음 맞는 분들과 여행', '', '', Colors.transparent),
                      SizedBox(height: 12.0.h),
                      peopleBox(3, distanceState[3], '6명~10명', '작은 규모 단체 여행', '', '', Colors.transparent),
                      SizedBox(height: 12.0.h),
                      peopleBox(4, distanceState[4], '상관없음', '소수, 다수 인원과 여행', '', '', Colors.transparent),
                    ]
                );
              }
          )
        ],
      ),
    );
  }

  Widget peopleBox(int index, bool state, String step, String define, String example, String imageAsset, Color doneColor) {

    // List<Widget> image = [];
    // for(int i = 0; i < int.parse(step); i++) {
    //   image.add(Image.asset(imageAsset, width: 20.0.w, height: 20.0.h, color: state == false ? StaticColor.grey400BB : doneColor));
    // }

    return GestureDetector(
      onTap: () {
        context.read<TasteProvider>().peopleSelectorChange(index, !state);
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
