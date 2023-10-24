import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/event_detail/event_detail_provider.dart';
import 'package:sense_flutter_application/views/event_detail/bottom_sheet/event_bottom_sheet_submit_button.dart';

class EventRegionBottomSheet extends StatefulWidget {
  const EventRegionBottomSheet({super.key});

  @override
  State<EventRegionBottomSheet> createState() => _EventRegionBottomSheetState();
}

class _EventRegionBottomSheetState extends State<EventRegionBottomSheet> {

  void onPressSubmit() {
    int eventId = context.read<EDProvider>().eventModel.id ?? -1;
    EnumEventCity? city = context.read<EDProvider>().city;
    EnumEventSubCity? subCity = context.read<EDProvider>().subCity;
    if (city == null) return;

    context.read<EDProvider>().changeEventRegion(eventId, city, subCity, true);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: const Column(
              children: [
                CityDropdown(),
                SubCityField(),
              ],
            ),
          ),
          Align(alignment: Alignment.bottomCenter, child: EventBottomSheetSubmitButton(onPressed: onPressSubmit))
        ],
      ),
    );
  }
}

class CityDropdown extends StatefulWidget {
  const CityDropdown({super.key});

  @override
  State<CityDropdown> createState() => _CityDropdownState();
}

class _CityDropdownState extends State<CityDropdown> {
  List<EnumEventCity> cityList = EnumEventCity.values.map((e) => e).toList();
  List<DropdownMenuItem<EnumEventCity>> dropdownItem = [];

  @override
  void initState() {
    for(int i = 0; i < cityList.length; i++) {
      EnumEventCity city = cityList.elementAt(i);
      dropdownItem.add(
        DropdownMenuItem(
          value: city,
          child: Text(city.title, style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w100)),
        )
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.0.h),
      child: Container(
        padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w, top: 14.0.h, bottom: 14.0.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: StaticColor.grey100F6,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Consumer<EDProvider>(
          builder: (context, data, child) {
            EnumEventCity? city = data.city ?? EnumEventCity.values.first;

            return DropdownButtonFormField(
              dropdownColor: Colors.white,
              value: city,
              decoration: const InputDecoration.collapsed(hintText: ''),
              isExpanded: true,
              iconEnabledColor: Colors.black,
              items: dropdownItem,
              onChanged: (EnumEventCity? value) {
                data.setDropdownCity(value!, true);
              },
            );
          }
        ),
      ),
    );
  }
}

class SubCityField extends StatefulWidget {
  const SubCityField({super.key});

  @override
  State<SubCityField> createState() => _SubCityFieldState();
}

class _SubCityFieldState extends State<SubCityField> {
  List<EnumEventCity> cityList = EnumEventCity.values.map((e) => e).toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Consumer<EDProvider>(
          builder: (context, data, child) {
            String title = '${data.dropdownCity?.title ?? ''} 전체';
            bool isActive = data.dropdownCity == data.city && data.subCity == null;
            void onTap () {
              data.selectTotalCity(data.dropdownCity, true);
            }
            return RegionTotalBox(title: title, isActive: isActive, onTap: onTap);
          }
        ),
        SizedBox(height: 12.0.h,),
        Consumer<EDProvider>(
          builder: (context, data, child) {
            return Wrap(
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.end,
              spacing: 6.0.w,
              runSpacing: 12.0.h,
              children: data.subCityList.map((subCity) => RegionBox(subCity: subCity)).toList(),
            );
          }
        )
      ],
    );
  }
}

class RegionTotalBox extends StatelessWidget {
  final String title;
  final bool isActive;
  final void Function() onTap;
  const RegionTotalBox({super.key, required this.title, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Material(
        color: isActive ? StaticColor.mainSoft : StaticColor.grey100F6,
        borderRadius: BorderRadius.circular(4.0),
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 9.0.h),
            child: Text(title, style: TextStyle(fontSize: 14.0.sp, color: isActive ? Colors.white : StaticColor.grey60077, height: 1))),
        ),
      ),
    );
  }
}

class RegionBox extends StatelessWidget {
  final EnumEventSubCity subCity;
  const RegionBox({super.key, required this.subCity});


  @override
  Widget build(BuildContext context) {
    return Consumer<EDProvider>(
      builder: (context, data, child) {
        String title = subCity.title;
        bool isActive = data.subCity == subCity;

        return Material(
          color: isActive ? StaticColor.mainSoft : StaticColor.grey100F6,
          borderRadius: BorderRadius.circular(4.0),
          child: InkWell(
            onTap: () {
              data.selectSubCity(subCity, true);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 9.0.h),
              child: Text(title, style: TextStyle(fontSize: 14.0.sp, color: isActive ? Colors.white : StaticColor.grey60077, height: 1))),
          ),
        );
      }
    );
    
  }
}