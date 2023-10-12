// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:sense_flutter_application/models/event/region_model.dart';
// import 'package:sense_flutter_application/views/create_event/create_event_provider.dart';
// import 'package:sense_flutter_application/views/create_event/create_event_region.dart';
//
// /// 20230729
// class SubCityField extends StatefulWidget {
//   List<SubCity> subCityList;
//   String cityName;
//   SubCityField({super.key, required this.subCityList, required this.cityName});
//
//   @override
//   State<SubCityField> createState() => _SubCityFieldState();
// }
//
// class _SubCityFieldState extends State<SubCityField> {
//   List<SubCity> subCityList = [];
//   String cityName = '';
//   List<Widget> widgetList = [];
//
//   @override
//   void initState() {
//     subCityList = widget.subCityList;
//     cityName = widget.cityName;
//     // subCityList.forEach((element) {
//     //   widgetList.add(RegionBox(name: element.title!));
//     // });
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20.0.w),
//         child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Consumer<CreateEventProvider>(
//                   builder: (context, data, child) {
//
//                     bool aa = data.regionTotalSelector;
//
//                     return RegionTotalBox(name: cityName, state: aa);
//                   }
//               ),
//               Consumer<CreateEventProvider>(
//                   builder: (context, data, child) {
//                     widgetList.clear();
//                     subCityList.asMap().forEach((index, element) {
//                       widgetList.add(RegionBox(name: element.title!, state: data.subCityList.elementAt(index), index: index));
//                     });
//                     return Wrap(
//                         alignment: WrapAlignment.start,
//                         spacing: 6.0.w,
//                         runSpacing: 12.0.h,
//                         children: widgetList);
//                   }
//               )
//             ]
//         )
//     );
//   }
// }