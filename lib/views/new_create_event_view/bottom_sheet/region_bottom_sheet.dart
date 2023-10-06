import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/event/region_model.dart';
import 'package:sense_flutter_application/views/new_create_event_view/new_create_event_provider.dart';

class RegionBottomSheet extends StatefulWidget {
  const RegionBottomSheet({super.key});

  @override
  State<RegionBottomSheet> createState() => _RegionBottomSheetState();
}

class _RegionBottomSheetState extends State<RegionBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final safeAreaTopPadding = context.read<CEProvider>().safeAreaTopPadding;
    final safeAreaBottomPadding = context.read<CEProvider>().safeAreaBottomPadding;

    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height - safeAreaTopPadding - 60, /// 마지막 60은 header widget height
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        child: Stack(
            children: [
              Column(
                children: [
                  RegionHeaderBar(),
                  RegionTitle(),
                  SizedBox(height: 24.0.h),
                  TargetSelect(),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: RegionSubmitButton(),
              )
            ]
        )
    );
  }
}

class RegionHeaderBar extends StatelessWidget {
  const RegionHeaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
        child: Image.asset('assets/feed/comment_header_bar.png', width: 75, height: 4));
  }
}

class RegionTitle extends StatelessWidget {
  const RegionTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("이벤트 대상", style: TextStyle(fontSize: 16.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w500));
  }
}

class TargetSelect extends StatefulWidget {
  const TargetSelect({super.key});

  @override
  State<TargetSelect> createState() => _TargetSelectState();
}

class _TargetSelectState extends State<TargetSelect> {
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
}

class RegionSubmitButton extends StatefulWidget {
  const RegionSubmitButton({super.key});

  @override
  State<RegionSubmitButton> createState() => _RegionSubmitButtonState();
}

class _RegionSubmitButtonState extends State<RegionSubmitButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70.h,
      child: ElevatedButton(
          onPressed: () {
            regionListener();
          },
          style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categorySelectedColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 56, child: Center(child: Text('저장', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700)))),
              ]
          )
      ),
    );
  }

  void regionListener() async {
    context.read<CEProvider>().cityChange();
    Navigator.pop(context);
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
    if(context.read<CEProvider>().tempCity == -1) {
      context.read<CEProvider>().tempCityChange(0, false);
      initItem = cityName!.elementAt(0).toString();
    } else {
      initItem = cityName!.elementAt(context.read<CEProvider>().tempCity).toString();
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
        RegionBox(
          state: fieldState.elementAt(i),
          enabled: true,
          name: subCityList!.elementAt(i),
          cityIndex: cityIndex,
          index: i,
        ),
      );
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