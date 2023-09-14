import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/create_event/create_event_provider.dart';
import 'package:sense_flutter_application/views/event_info/event_info_provider.dart';
import 'package:sense_flutter_application/views/create_event/create_event_bottom_sheet.dart';
import 'package:sense_flutter_application/views/event_info/recommend_request/recommend_request_provider.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';

class EventRecommendStepCost extends StatefulWidget {
  const EventRecommendStepCost({super.key});

  @override
  State<EventRecommendStepCost> createState() => _EventRecommendStepCostState();
}

class _EventRecommendStepCostState extends State<EventRecommendStepCost> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecommendRequestProvider>(
      builder: (context, data, child) {
        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 32.0.h, left: 20.0.w, right: 20.0.w),
              child: Column(
                children: [
                  ContentDescription(presentPage: 2, totalPage: 3, description: '각 항목에 대한 예산을 선택해 주세요'),
                  SizedBox(height: 29.0.h),
                  TotalCost(),
                  Container(margin: EdgeInsets.only(top: 13.0.h, bottom: 8.0.h), width: double.infinity, height: 1.0.h, color: StaticColor.grey300E0),
                  CostField(),
                ],
              ),
            ),
          ],
        );
      }
    );
  }
}

class TotalCost extends StatefulWidget {
  const TotalCost({super.key});

  @override
  State<TotalCost> createState() => _TotalCostState();
}

class _TotalCostState extends State<TotalCost> {

  @override
  void initState() {
    /// 비용 초기화
    context.read<RecommendRequestProvider>().recommendCostListInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('전체 예산', style: TextStyle(fontSize: 16.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
        Consumer<RecommendRequestProvider>(
          builder: (context, data, child) {

            int totalCost = data.totalCost;
            var f = NumberFormat('###,###,###,###');
            String totalCostString = f.format(totalCost);

            print(totalCost);

            bool addSomeCost = data.costs.contains(-1);

            return Align(
              alignment: Alignment.centerLeft,
              child: Text(addSomeCost == true ? '$totalCostString + @' : totalCostString, style: TextStyle(fontSize: 20.0.sp, color: StaticColor.mainSoft, fontWeight: FontWeight.w700)));
          }
        )
      ],
    );
  }
}

class CostField extends StatefulWidget {
  const CostField({super.key});

  @override
  State<CostField> createState() => _CostFieldState();
}

class _CostFieldState extends State<CostField> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<RecommendRequestProvider>(
      builder: (context, data, child) {

        List<int> costs = data.costs;
        List<int> temperatureList = data.recommendCategoryNumber;
        List<Widget> selectCategoryCostWidgetList = [];

        temperatureList.asMap().forEach((index, element) {
          selectCategoryCostWidgetList.add(SelectCategoryCostWidget(
              name: enumStringChange(RecommendCategory.values.elementAt(index).name.toString()),
              index: index));
        });

        return Column(
          children: selectCategoryCostWidgetList,
        );
      }
    );
  }

  String enumStringChange(String token) {
    String returnString = '';
    if(token == 'GIFT') {
      returnString = '선물';
    } else if(token == 'HOTEL') {
      returnString = '호텔';
    } else if(token == 'LUNCH') {
      returnString = '점심';
    } else if(token == 'DINNER') {
      returnString = '저녁';
    } else if(token == 'ACTIVITY') {
      returnString = '액티비티';
    } else if(token == 'PUB') {
      returnString = '술집';
    } else {
      returnString = '';
    }
    return returnString;
  }
}

class SelectCategoryCostWidget extends StatefulWidget {
  String name;
  int index;
  SelectCategoryCostWidget({super.key, required this.name, required this.index});

  @override
  State<SelectCategoryCostWidget> createState() => _SelectCategoryCostWidgetState();
}

class _SelectCategoryCostWidgetState extends State<SelectCategoryCostWidget> {

  String name = '';
  int index = -1;
  int price = 0;

  @override
  void initState() {
    name = widget.name;
    index = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecommendRequestProvider>(
      builder: (context, data, child) {

        String costString = '';
        var f = NumberFormat('###,###,###,###');
        if(data.costs.elementAt(index) == -1) {
          costString = 'infinity';
        } else {
          costString = f.format(data.costs.elementAt(index));
        }

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
                  return CostBottomSheet(index: index);
                }
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(name, style: TextStyle(fontSize: 16.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w500)),
                Container(
                  width: 200.w,
                  padding: EdgeInsets.symmetric(horizontal: 56.0.w, vertical: 6.0.h),
                  decoration: BoxDecoration(
                    color: StaticColor.grey100F6,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Align(alignment: Alignment.center, child: costString == 'infinity'
                      ? Image.asset('assets/create_event/infinity.png', width: 24, height: 24)
                      : Text(costString, style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700))),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}

class CostBottomSheet extends StatefulWidget {
  int index;
  CostBottomSheet({super.key, required this.index});

  @override
  State<CostBottomSheet> createState() => _CostBottomSheetState();
}

class _CostBottomSheetState extends State<CostBottomSheet> {

  int index = 0;

  @override
  void initState() {
    index = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    List<bool> selectCostState = context.watch<RecommendRequestProvider>().costBool.elementAt(index);

    List<Widget> costWidgetList = [];
    List<int> costList = [50000, 100000, 200000, 300000, 400000, 500000, 600000, 700000, 800000, 900000, 1000000, -1];

    /// cost selector widget list
    for(int i = 0; i < 12; i++) {
      costWidgetList.add(CostSelector(selectCostState[i], costList[i], index, i));
    }

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 8.0.h, bottom: 16.0.h),
                child: Center(child: Image.asset('assets/feed/comment_header_bar.png', width: 75.0.w, height: 4.0.h, color: StaticColor.dividerColor)),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 24.0.h),
                child: Center(child: Text('예산 선택', style: TextStyle(fontSize: 16.sp, color: StaticColor.black90015, fontWeight: FontWeight.w500))),
              ),
              Expanded(
                child: Column(
                  children: costWidgetList,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              height: 70.h,
              child: ElevatedButton(
                onPressed: () {
                  context.read<RecommendRequestProvider>().sumCostChange(getSelectCost(index), index);
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categorySelectedColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
                child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 56, child: Center(child: Text('저장', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700)))),
                    ]
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int getSelectCost(int index) {
    List<int> costList = [50000, 100000, 200000, 300000, 400000, 500000, 600000, 700000, 800000, 900000, 1000000, -1];
    List<bool> boolList = context.read<RecommendRequestProvider>().costBool[index];
    return costList[boolList.indexOf(true)];
  }

  Widget CostSelector(bool state, int costString, int index, int costIndex) {

    String costValue = '';

    if(costString == -1) {
      costValue = '-1';
    } else {
      costValue = (costString ~/ 10000).toString();
    }

    return GestureDetector(
      onTap: () {
        // context.read<EventInfoProvider>().sumCostChange(costString, index, costIndex);
        context.read<RecommendRequestProvider>().costSelectorChange(index, costIndex);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.0.h),
        margin: EdgeInsets.symmetric(horizontal: 20.0.w),
        width: double.infinity,
        decoration: BoxDecoration(
          color: state == true ? StaticColor.grey100F6 : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              state == true ? Image.asset('assets/create_event/check.png', width: 24, height: 24) : const SizedBox(width: 24.0, height: 24.0),
              if (costValue == '-1') Image.asset('assets/create_event/infinity.png', width: 24, height: 24) else Text('$costValue만원', style: TextStyle(fontSize: 16.0.sp, color: state == true ? StaticColor.mainSoft : StaticColor.grey70055)),
              const SizedBox(width: 24.0, height: 24.0),
            ],
          ),
        ),
      ),
    );
  }
}

// class CostSelector extends StatefulWidget {
//   bool state;
//   int costString;
//   int index;
//   int costIndex;
//   CostSelector({super.key, required this.state, required this.costString, required this.index, required this.costIndex});
//
//   @override
//   State<CostSelector> createState() => _CostSelectorState();
// }
//
// class _CostSelectorState extends State<CostSelector> {
//
//   bool state = false;
//   String costString = '';
//   int index = -1;
//   int costIndex = -1;
//
//   @override
//   void initState() {
//     state = widget.state;
//     if(widget.costString == -1) {
//       costString = '-1';
//     } else {
//       costString = (widget.costString ~/ 10000).toString();
//     }
//     index = widget.index;
//     costIndex = widget.costIndex;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         context.read<EventInfoProvider>().sumCostChange(widget.costString, index, costIndex);
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 12.0.h),
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: state == true ? StaticColor.grey100F6 : Colors.transparent,
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         child: Center(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               state == true ? Image.asset('assets/create_event/check.png', width: 24, height: 24) : const SizedBox(width: 24.0, height: 24.0),
//               if (costString == '-1') Image.asset('assets/create_event/infinity.png', width: 24, height: 24) else Text('$costString만원', style: TextStyle(fontSize: 16.0.sp, color: state == true ? StaticColor.mainSoft : StaticColor.grey70055)),
//               const SizedBox(width: 24.0, height: 24.0),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }