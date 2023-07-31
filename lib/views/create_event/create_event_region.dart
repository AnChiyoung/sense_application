import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/event/region_model.dart';
import 'package:sense_flutter_application/views/create_event/create_event_provider.dart';
import 'package:sense_flutter_application/views/create_event/create_event_region_subcity.dart';

class CreateEventRegionView extends StatefulWidget {
  const CreateEventRegionView({super.key});

  @override
  State<CreateEventRegionView> createState() => _CreateEventRegionViewState();
}

class _CreateEventRegionViewState extends State<CreateEventRegionView> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RegionRequest().cityListRequest(),
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return const SizedBox.shrink();
        } else if(snapshot.hasData) {

          if(snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox.shrink();
          } else if(snapshot.connectionState == ConnectionState.done) {

            List<City>? cityModels = snapshot.data;

            return Column(
              children: [
                CityDropDownMenu(models: cityModels),
                SubCityMenu(),
              ],
            );

          } else {
            return const SizedBox.shrink();
          }

        } else {
          return const SizedBox.shrink();
        }
      }
    );
  }
}

class CityDropDownMenu extends StatefulWidget {
  List<City>? models;
  CityDropDownMenu({super.key, this.models});

  @override
  State<CityDropDownMenu> createState() => _CityDropDownMenuState();
}

class _CityDropDownMenuState extends State<CityDropDownMenu> {

  List<City>? models;
  List<DropdownMenuItem<String>> dropdownItem = [];
  String initItem = '';

  @override
  void initState() {
    models = widget.models;
    for(int i = 0; i < models!.length; i++) {
      dropdownItem.add(
        DropdownMenuItem(
          value: models!.elementAt(i).title.toString(),
          child: Text(models!.elementAt(i).title.toString(), style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w100)),
        )
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateEventProvider>(
      builder: (context, data, child) {

        int selectCityNumber = 0;

        if(data.saveCity == '0') {
          initItem = models!.elementAt(0).title.toString();
          selectCityNumber = 1;
        } else {
          initItem = models!.elementAt(int.parse(data.saveCity) - 1).title.toString();
        }

        return Column(
          children: [
            /// city dropdown menu
            Padding(
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
                    for(int i = 0; i < models!.length; i++) {
                      if(models!.elementAt(i).title == initItem) {
                        selectCityNumber = i + 1;
                      }
                    }
                    if (kDebugMode) {
                      print('선택한 지역 & 선택한 지역 번호 : $initItem , $selectCityNumber');
                    }
                    context.read<CreateEventProvider>().cityChange(initItem, selectCityNumber.toString());
                    // /// select city number => subcity display.
                    // print(initItem);
                    // context.read<CreateEventProvider>().cityChange(selectCityNumber.toString(), initItem);
                  },
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}

class SubCityMenu extends StatefulWidget {
  const SubCityMenu({super.key});

  @override
  State<SubCityMenu> createState() => _SubCityMenuState();
}

class _SubCityMenuState extends State<SubCityMenu> {

  List<SubCity> subCityList = [];
  List<bool> subCityCheckList = [];

  @override
  Widget build(BuildContext context) {

    // /// local 요소 없애야함 20230729
    // if(int.parse(cityNumber) == 1) {
    //   cityName = '서울';
    // } else if(int.parse(cityNumber) == 2) {
    //   cityName = '경기도';
    // } else if(int.parse(cityNumber) == 3) {
    //   cityName = '인천';
    // } else if(int.parse(cityNumber) == 4) {
    //   cityName = '강원도';
    // } else if(int.parse(cityNumber) == 5) {
    //   cityName = '전라도';
    // } else if(int.parse(cityNumber) == 6) {
    //   cityName = '경상도';
    // }

    // return Container();

    return Consumer<CreateEventProvider>(
      builder: (context, data, child) {

        String cityNumber = data.cityNumber;
        print('rebuild???');

        return FutureBuilder(
            future: RegionRequest().subCityListRequest(cityNumber),
            builder: (context, snapshot) {
              if(snapshot.hasError) {
                return const SizedBox.shrink();
              } else if(snapshot.hasData) {

                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox.shrink();
                } else if(snapshot.connectionState == ConnectionState.done) {

                  List<SubCity> subCityList = snapshot.data ?? [];
                  List<bool> subCityCheckList = [];
                  subCityList!.forEach((element) {
                    subCityCheckList.add(false);
                  });

                  if(subCityList!.isEmpty) {
                    return Center(child: Text('할당된 지역이 없습니다', style: TextStyle(color: StaticColor.grey70055)));
                  } else {
                    return Consumer<CreateEventProvider>(
                        builder: (context, data, child) {
                          return RegionTotalBox(name: '서울', state: data.regionTotalSelector);
                        }
                    );
                    // return SubCityField(subCityList: subCityList, cityName: cityName);
                    return Container();
                  }

                } else {
                  return const SizedBox.shrink();
                }

              } else {
                return const SizedBox.shrink();
              }
            }
        );
      }
    );
  }
}

// class SubCityMenu extends StatefulWidget {
//   const SubCityMenu({super.key});
//
//   @override
//   State<SubCityMenu> createState() => _SubCityMenuState();
// }
//
// class _SubCityMenuState extends State<SubCityMenu> {
//
//   String cityNumber = '';
//
//   @override
//   void initState() {
//     // context.read<CreateEventProvider>().cityChange('1');
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CreateEventProvider>(
//       builder: (context, data, child) {
//
//         if(data.city == '0') {
//           cityNumber = '1';
//         } else {
//           cityNumber = data.city;
//         }
//
//         return FutureBuilder(
//           future: RegionRequest().subCityListRequest(cityNumber),
//           builder: (context, snapshot) {
//
//             print('select city number : $cityNumber');
//
//             if(snapshot.hasError) {
//               return const SizedBox.shrink();
//             } else if(snapshot.hasData) {
//
//               if(snapshot.connectionState == ConnectionState.waiting) {
//                 return const SizedBox.shrink();
//               } else if(snapshot.connectionState == ConnectionState.done) {
//
//                 List<SubCity>? subCityModels = snapshot.data;
//                 /// subcity 선택용 bool list 생성
//                 List<bool> subCitySelector = [];
//                 subCityModels!.forEach((element) {
//                   subCitySelector.add(false);
//                 });
//                 context.read<CreateEventProvider>().subCityChange(subCitySelector);
//
//                 return SubCityField(models: subCityModels!);
//
//               } else {
//                 return const SizedBox.shrink();
//               }
//
//             } else {
//               return const SizedBox.shrink();
//             }
//           }
//         );
//       }
//     );
//   }
// }
//
// class SubCityField extends StatefulWidget {
//   List<SubCity> models;
//   SubCityField({super.key, required this.models});
//
//   @override
//   State<SubCityField> createState() => _SubCityFieldState();
// }
//
// class _SubCityFieldState extends State<SubCityField> {
//   List<SubCity> models = [];
//   List<Widget> subCityWidgetList = [];
//
//   @override
//   void initState() {
//     models = widget.models;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     List<bool> a = context.read<CreateEventProvider>().subCityList;
//     print(a);
//
//     for(int i = 0; i < models.length; i++) {
//       subCityWidgetList.add(
//         RegionBox(
//           state: a.elementAt(i),
//           name: models!.elementAt(i).title!,
//           index: i,
//         ),
//       );
//     }
//
//     bool isExistModel = false;
//     subCityWidgetList.isEmpty ? isExistModel = false : isExistModel = true;
//
//     if(isExistModel == true) {
//       return Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20.0.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               RegionTotalBox(),
//               Wrap(
//                 alignment: WrapAlignment.start,
//                 spacing: 6.0.w,
//                 runSpacing: 12.0.h,
//                 children: subCityWidgetList
//               ),
//             ],
//           )
//       );
//     } else if(isExistModel == false) {
//       return const Center(child: Text('지역이 등록되어 있지 않습니다', style: TextStyle(color: Colors.black)));
//     } else {
//       return const Center(child: Text('Unknown error'));
//     }
//   }
// }

class RegionTotalBox extends StatefulWidget {
  String name;
  bool state;
  RegionTotalBox({super.key, required this.name, required this.state});

  @override
  State<RegionTotalBox> createState() => _RegionTotalBoxState();
}

class _RegionTotalBoxState extends State<RegionTotalBox> {

  bool a = false;

  @override
  void initState() {
    a = widget.state;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.read<CreateEventProvider>().regionTotalSelectorChange(a);
          },
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 6.0.h),
              margin: EdgeInsets.only(bottom: 12.0.h),
              decoration: BoxDecoration(
                color: widget.state == true ? StaticColor.mainSoft : StaticColor.grey100F6,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text('${widget.name} 전체', style: TextStyle(fontSize: 14.sp, color: widget.state == true ? Colors.white : StaticColor.grey60077))),
        ),
      ),
    );
  }
}

class RegionBox extends StatefulWidget {
  bool state;
  String name;
  int index;
  RegionBox({super.key, required this.state, required this.name, required this.index});

  @override
  State<RegionBox> createState() => _RegionBoxState();
}

class _RegionBoxState extends State<RegionBox> {
  late bool state;
  String name = '';
  int index = 0;

  @override
  void initState() {
    state = widget.state;
    // state = false;
    name = widget.name;
    index = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
        child: Text(name, style: TextStyle(fontSize: 14, color: state == true ? Colors.white : StaticColor.grey60077)),
      ),
    );
  }
}

