import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/screens/event_info/event_info_provider.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';

class EventRecommendStepCost extends StatefulWidget {
  const EventRecommendStepCost({super.key});

  @override
  State<EventRecommendStepCost> createState() => _EventRecommendStepCostState();
}

class _EventRecommendStepCostState extends State<EventRecommendStepCost> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EventInfoProvider>(
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
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                height: 70.h,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<EventInfoProvider>().eventRecommendStepChange(3);
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
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('전체 예산', style: TextStyle(fontSize: 16.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
        Consumer<EventInfoProvider>(
          builder: (context, data, child) {

            int totalCost = data.totalCost;
            var f = NumberFormat('###,###,###,###');
            String totalCostString = f.format(totalCost);

            return Align(
              alignment: Alignment.centerLeft,
              child: Text(totalCostString, style: TextStyle(fontSize: 20.0.sp, color: StaticColor.mainSoft, fontWeight: FontWeight.w700)));
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
  Widget build(BuildContext context) {
    return Consumer<EventInfoProvider>(
      builder: (context, data, child) {

        // if(data.recommendCategory.isEmpty) {
        //   return Container();
        // } else {
        //   List<Widget> selectCategoryCostWidgetList =
        // }

        return Container();
      }
    );
  }
}
