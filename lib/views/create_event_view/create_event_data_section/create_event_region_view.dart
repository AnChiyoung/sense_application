import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/event/region_model.dart';
import 'package:sense_flutter_application/views/create_event_view/create_event_data_bottom_sheet_view/create_event_region_bottom_sheet_view.dart';
import 'package:sense_flutter_application/views/create_event_view/create_event_provider.dart';

class CreateEventRegionView extends StatefulWidget {
  const CreateEventRegionView({super.key});

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
        Expanded(
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  isDismissible: false,
                  useSafeArea: true,
                  enableDrag: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return const RegionBottomSheet();
                  }
              );
            },
            child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                  color: StaticColor.grey100F6,
                  // color: Colors.black,
                  borderRadius: BorderRadius.circular(4.0),
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
          ),
        )
      ],
    );
  }
}

class CityDropdown extends StatefulWidget {
  List<String> cityName;
  CityDropdown({super.key, required this.cityName});

  @override
  State<CityDropdown> createState() => _CityDropdownState();
}

class _CityDropdownState extends State<CityDropdown> {

  List<String> cityName = [];
  List<DropdownMenuItem<String>> dropdownItem = [];
  String initItem = '';

  @override
  void initState() {
    cityName = widget.cityName;
    for(int i = 0; i < cityName.length; i++) {
      dropdownItem.add(
          DropdownMenuItem(
            value: cityName.elementAt(i).toString(),
            child: Text(cityName.elementAt(i).toString(), style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w100)),
          )
      );
    }

    /// at first bottom sheet, city index 0
    /// 그 다음은 tempcity index에 따라
    if(context.read<CEProvider>().tempCity == -1) {
      context.read<CEProvider>().tempCityChange(0, false);
      initItem = cityName.elementAt(0).toString();
    } else {
      initItem = cityName.elementAt(context.read<CEProvider>().tempCity).toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, bottom: 24.0.h),
      child: Container(
        padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w, top: 14.0.h, bottom: 14.0.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: StaticColor.grey100F6,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: DropdownButtonFormField(
          dropdownColor: Colors.white,
          value: initItem,
          decoration: const InputDecoration.collapsed(hintText: ''),
          isExpanded: true,
          iconEnabledColor: Colors.black,
          items: dropdownItem,
          onChanged: (Object? value) {
            initItem = value.toString();
            context.read<CEProvider>().tempCityChange(cityName.indexOf(initItem), true);
          },
        ),
      ),
    );
  }
}

class SubCityField extends StatefulWidget {
  List<LocalRegionModel> localRegionModel;
  SubCityField({super.key, required this.localRegionModel});

  @override
  State<SubCityField> createState() => _SubCityFieldState();
}

class _SubCityFieldState extends State<SubCityField> {

  List<LocalRegionModel> localRegionModel = [];
  /// select city's subcity
  List<String> subCityList = [];
  int cityIndex = 0;

  @override
  void initState() {
    localRegionModel = widget.localRegionModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<CEProvider>(
            builder: (context, data, child) {

              int city = data.tempCity;
              return RegionTotalBox(state: data.totalBoxState, name: localRegionModel.elementAt(city).cityName.toString(), enabled: true);
            }
        ),
        Consumer<CEProvider>(
            builder: (context, data, child) {

              subCityList.clear();

              if(data.tempCity == -1) {
                cityIndex = 0;
              } else {
                cityIndex = data.tempCity;
              }

              for (var element in localRegionModel.elementAt(cityIndex).subCityList!) {
                subCityList.add(element);
              }

              List<bool> fieldState = data.subCityState.elementAt(cityIndex);

              return SubCityListField(subCityList, cityIndex, fieldState);
            }
        )
      ],
    );
  }

  /// 추후, 클래스형 위젯으로 전환
  Widget SubCityListField(List<String> subCityList, int cityIndex, List<bool> fieldState) {

    /// cityIndex는 enabled = false 용도

    List<Widget> subCityWidgetList = [];

    for(int i = 0; i < subCityList.length; i++) {

      subCityWidgetList.add(
        // Text(subCityList.elementAt(i), style: TextStyle(color: Colors.black)),
        RegionBox(
          state: fieldState.elementAt(i),
          enabled: true,
          name: subCityList.elementAt(i),
          cityIndex: cityIndex,
          index: i,
        ),
      );

      // if(cityIndex == 0) {
      //   if(i > 1) {
      //     subCityWidgetList.add(
      //       // Text(subCityList.elementAt(i), style: TextStyle(color: Colors.black)),
      //       RegionBox(
      //         state: false,
      //         enabled: false,
      //         name: subCityList!.elementAt(i),
      //         cityIndex: cityIndex,
      //         index: i,
      //       ),
      //     );
      //   } else {
      //     subCityWidgetList.add(
      //       // Text(subCityList.elementAt(i), style: TextStyle(color: Colors.black)),
      //       RegionBox(
      //         state: fieldState.elementAt(i),
      //         enabled: true,
      //         name: subCityList!.elementAt(i),
      //         cityIndex: cityIndex,
      //         index: i,
      //       ),
      //     );
      //   }
      // } else {
      //   subCityWidgetList.add(
      //     // Text(subCityList.elementAt(i), style: TextStyle(color: Colors.black)),
      //     RegionBox(
      //       state: false,
      //       enabled: false,
      //       name: subCityList!.elementAt(i),
      //       cityIndex: cityIndex,
      //       index: i,
      //     ),
      //   );
      // }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 6.0.w,
          runSpacing: 12.0.h,
          children: subCityWidgetList,
        ),
      ),
    );
  }
}

class SubCityAllSelector extends StatelessWidget {
  const SubCityAllSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class RegionTotalBox extends StatelessWidget {
  String name;
  bool state;
  bool enabled;
  RegionTotalBox({super.key, required this.name, required this.state, required this.enabled});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              context.read<CEProvider>().totalBoxStateChange(!state, context.read<CEProvider>().tempCity);
              // context.read<CreateEventProvider>().regionTotalSelectorChange(a);
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 6.0.h),
                margin: EdgeInsets.only(bottom: 12.0.h),
                decoration: BoxDecoration(
                  color: state == true ? StaticColor.mainSoft : StaticColor.grey100F6,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text('$name 전체', style: TextStyle(fontSize: 14.0.sp, color: enabled == false ? StaticColor.grey300E0 : (state == true ? Colors.white : StaticColor.grey60077)))),
          ),
        ),
      ),
    );
  }
}

class RegionBox extends StatelessWidget {
  bool state;
  bool enabled;
  String name;
  int cityIndex;
  int index;
  RegionBox({super.key, required this.state, required this.enabled, required this.name, required this.cityIndex, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<CEProvider>().boxStateChange(!state, cityIndex, index);
        // setState(() {
        //   state = !state;
        // });
        // context.read<CreateEventProvider>().subCityElementChange(!state, index);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 6.0.h),
        decoration: BoxDecoration(
          color: state == true ? StaticColor.mainSoft : StaticColor.grey100F6,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(name, style: TextStyle(fontSize: 14.0.sp, color: enabled == false ? StaticColor.grey300E0 : (state == true ? Colors.white : StaticColor.grey60077))),
      ),
    );
  }
}