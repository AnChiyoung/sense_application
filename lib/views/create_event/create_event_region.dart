import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/event/region_model.dart';
import 'package:sense_flutter_application/views/create_event/create_event_provider.dart';
import 'package:sense_flutter_application/views/create_event/create_event_region_subcity.dart';
import 'package:sense_flutter_application/views/recommended_event/region_select_view.dart';

class CreateEventRegionView extends StatefulWidget {
  const CreateEventRegionView({super.key});

  @override
  State<CreateEventRegionView> createState() => _CreateEventRegionViewState();
}

class _CreateEventRegionViewState extends State<CreateEventRegionView> {

  List<LocalRegionModel>? localRegionModel;
  /// to city dropdown
  List<String> cityName = [];

  @override
  void initState() {
    localRegionModel = regionDummyModel.map((e) => LocalRegionModel.fromJson(e)).toList();
    for (var element in localRegionModel!) {
      cityName!.add(element.cityName.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        CityDropdown(cityName: cityName!),
        SubCityField(localRegionModel: localRegionModel!),
      ],
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder(
  //     future: RegionRequest().cityListRequest(),
  //     builder: (context, snapshot) {
  //       if(snapshot.hasError) {
  //         return const SizedBox.shrink();
  //       } else if(snapshot.hasData) {
  //
  //         if(snapshot.connectionState == ConnectionState.waiting) {
  //           return const SizedBox.shrink();
  //         } else if(snapshot.connectionState == ConnectionState.done) {
  //
  //           List<City>? cityModels = snapshot.data;
  //
  //           return Column(
  //             children: [
  //               // CityDropDownMenu(models: cityModels),
  //               SubCityMenu(),
  //             ],
  //           );
  //
  //         } else {
  //           return const SizedBox.shrink();
  //         }
  //
  //       } else {
  //         return const SizedBox.shrink();
  //       }
  //     }
  //   );
  // }
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
    for(int i = 0; i < cityName!.length; i++) {
      dropdownItem.add(
        DropdownMenuItem(
          value: cityName!.elementAt(i).toString(),
          child: Text(cityName!.elementAt(i).toString(), style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w100)),
        )
      );
    }

    /// at first bottom sheet, city index 0
    /// 그 다음은 tempcity index에 따라
    if(context.read<CreateEventProvider>().tempCity == -1) {
      initItem = cityName!.elementAt(0).toString();
    } else {
      initItem = cityName!.elementAt(context.read<CreateEventProvider>().tempCity).toString();
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
            context.read<CreateEventProvider>().tempCityChange(cityName.indexOf(initItem));
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
        Consumer<CreateEventProvider>(
            builder: (context, data, child) {
              if(data.tempCity == 0 || data.tempCity == -1) {
                return RegionTotalBox(state: data.totalBoxState, name: localRegionModel.elementAt(cityIndex).cityName.toString(), enabled: true);
              } else {
                return RegionTotalBox(state: data.totalBoxState, name: localRegionModel.elementAt(cityIndex).cityName.toString(), enabled: false,);
              }
            }
        ),
        Consumer<CreateEventProvider>(
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

      if(cityIndex == 0) {
        if(i > 1) {
          subCityWidgetList.add(
            // Text(subCityList.elementAt(i), style: TextStyle(color: Colors.black)),
            RegionBox(
              state: false,
              enabled: false,
              name: subCityList!.elementAt(i),
              cityIndex: cityIndex,
              index: i,
            ),
          );
        } else {
          subCityWidgetList.add(
            // Text(subCityList.elementAt(i), style: TextStyle(color: Colors.black)),
            RegionBox(
              state: fieldState.elementAt(i),
              enabled: true,
              name: subCityList!.elementAt(i),
              cityIndex: cityIndex,
              index: i,
            ),
          );
        }
      } else {
        subCityWidgetList.add(
          // Text(subCityList.elementAt(i), style: TextStyle(color: Colors.black)),
          RegionBox(
            state: false,
            enabled: false,
            name: subCityList!.elementAt(i),
            cityIndex: cityIndex,
            index: i,
          ),
        );
      }
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
              context.read<CreateEventProvider>().totalBoxStateChange(!state, context.read<CreateEventProvider>().tempCity);
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
        context.read<CreateEventProvider>().boxStateChange(!state, cityIndex, index);
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