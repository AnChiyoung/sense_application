import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/event/region_model.dart';
import 'package:sense_flutter_application/views/create_event_view/create_event_data_section/create_event_region_view.dart';
import 'package:sense_flutter_application/views/create_event_view/create_event_provider.dart';

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
