import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/new_create_event_view/bottom_sheet/region_bottom_sheet.dart';
import 'package:sense_flutter_application/views/new_create_event_view/new_create_event_provider.dart';

class CreateEventRegionView extends StatefulWidget {
  bool? edit;
  CreateEventRegionView({super.key, this.edit = false});

  @override
  State<CreateEventRegionView> createState() => _CreateEventRegionViewState();
}

class _CreateEventRegionViewState extends State<CreateEventRegionView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('위치', style: TextStyle(fontSize: 16.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
        SizedBox(width: 14.0.w),
        widget.edit == true ? RegionContainer(edit: widget.edit!) :
        Expanded(
          child: RegionContainer(edit: widget.edit!),
        )
      ],
    );
  }
}

class RegionContainer extends StatefulWidget {
  bool edit;
  RegionContainer({super.key, required this.edit});

  @override
  State<RegionContainer> createState() => _RegionContainerState();
}

class _RegionContainerState extends State<RegionContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            isDismissible: false,
            useSafeArea: true,
            enableDrag: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return RegionBottomSheet();
            }
        );
      },
      child: Container(
          padding: widget.edit == true ? EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 8.0.h) : EdgeInsets.symmetric(vertical: 18.0.h),
          decoration: BoxDecoration(
            color: StaticColor.grey100F6,
            // color: Colors.black,
            borderRadius: widget.edit == true ? BorderRadius.circular(18.0) : BorderRadius.circular(4.0),
          ),
          child: Consumer<CEProvider>(
              builder: (context, data, child) {

                List<String> cityNameList = ['서울', '경기도', '인천', '강원도', '경상도', '전라도', '충청도', '부산', '제주'];

                String cityName;
                int cityState = data.city;
                if(cityState == -1) {
                  cityName = '선택하기';
                } else {
                  cityName = cityNameList.elementAt(cityState);
                }

                return Center(child: Text(cityName, style: TextStyle(fontSize: 14.sp, color: data.city == -1 ? StaticColor.grey400BB : StaticColor.black90015, fontWeight: FontWeight.w400)));
              }
          )
      ),
    );
  }
}
