import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';
import 'package:sense_flutter_application/views/create_event/create_event_provider.dart';
import 'package:sense_flutter_application/views/event_info/event_info_provider.dart';
import 'package:sense_flutter_application/views/event_info/event_info_content_plan.dart';

class EventRecommendFinish extends StatefulWidget {
  EventModel eventModel;
  EventRecommendFinish({super.key, required this.eventModel});

  @override
  State<EventRecommendFinish> createState() => _EventRecommendFinishState();
}

class _EventRecommendFinishState extends State<EventRecommendFinish> {

  late EventModel eventModel;

  String category = '';
  String target = '';
  String date = '';
  String region = '';
  String totalCost = '';
  String memo = '';

  String recommendCategoryFullString = '';

  @override
  void initState() {
    eventModel = widget.eventModel;
    RecommendRequestModel model = eventModel.recommendModel ?? RecommendRequestModel.initModel;

    List<String> categoryStringList = ['생일', '데이트', '여행', '모임', '비즈니스'];
    List<String> targetStringList = ['가족', '연인', '친구', '직장'];
    List<String> cityStringList = ['서울', '경기도', '인천', '강원도', '경상도', '전라도', '충청도', '부산', '제주'];
    List<String> recommendCategoryStringList = [];
    recommendCategoryStringList.clear();

    if(eventModel.eventCategoryObject!.id == -1) {
      category = '-';
    } else {
      category = categoryStringList.elementAt(eventModel.eventCategoryObject!.id! - 1);
    }

    if(eventModel.targetCategoryObject!.id == -1) {
      target = '-';
    } else {
      target = targetStringList.elementAt(eventModel.targetCategoryObject!.id! - 1);
    }

    if(eventModel.eventDate!.isEmpty) {
      date = '-';
    } else {
      date = eventModel.eventDate!.substring(0, 10);
    }

    if(eventModel.city!.id! == -1) {
      region = '-';
    } else {
      region = cityStringList.elementAt(eventModel.city!.id! - 1);
    }

    if(model.isPresent == true) {
      recommendCategoryStringList.add('선물');
    }
    if(model.isHotel == true) {
      recommendCategoryStringList.add('호텔');
    }
    if(model.isLunch == true) {
      recommendCategoryStringList.add('점심');
    }
    if(model.isDinner == true) {
      recommendCategoryStringList.add('저녁');
    }
    if(model.isActivity == true) {
      recommendCategoryStringList.add('액티비티');
    }
    if(model.isPub == true) {
      recommendCategoryStringList.add('술집');
    }


    for(int i = 0; i < recommendCategoryStringList.length; i++) {
      if(i < recommendCategoryStringList.length - 1) {
        recommendCategoryFullString = recommendCategoryFullString + recommendCategoryStringList.elementAt(i) + ', ';
      } else {
        recommendCategoryFullString = recommendCategoryFullString + recommendCategoryStringList.elementAt(i);
      }
    }

    totalCost = model.totalBudget.toString();

    memo = (model.memo! == null || model.memo!.isEmpty) ? '-' : model.memo!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
      child: Column(
        children: [
          SizedBox(height: 16.0.h),
          Row(
            children: [
              Flexible(
                  flex: 1,
                  child: RecommendFinishCategory(categoryString: category)),
              SizedBox(width: 4.0.w),
              Flexible(
                  flex: 1,
                  child: RecommendFinishTarget(target: target)),
            ],
          ),
          SizedBox(height: 8.0.h),
          Row(
            children: [
              Flexible(
                  flex: 1,
                  child: RecommendFinishDate(date: date)),
              SizedBox(width: 4.0.w),
              Flexible(
                  flex: 1,
                  child: RecommendFinishRegion(city: region)),
            ],
          ),
          SizedBox(height: 8.0.h),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: RecommendFinishRequestCategory(requestCategory: recommendCategoryFullString)),
              SizedBox(width: 4.0.w),
              Expanded(
                  flex: 1,
                  child: RecommendFinishRequestCost(totalCost: totalCost)),
              SizedBox(width: 4.0.w),
            ],
          ),
          SizedBox(height: 16.0.h),
          RecommendFinishRequestMemo(memo: memo),
          SizedBox(height: 33.0.h),
          RecommendField(),
        ],
      ),
    );
  }
}

class EventInfoPlanRecommendCategory extends StatefulWidget {
  const EventInfoPlanRecommendCategory({super.key});

  @override
  State<EventInfoPlanRecommendCategory> createState() => _EventInfoPlanRecommendCategoryState();
}

class _EventInfoPlanRecommendCategoryState extends State<EventInfoPlanRecommendCategory> {
  String recommendCategoryTitle = '요청';
  String recommendCategoryString = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateEventProvider>(
        builder: (context, data, child) {

          List<int> categoryState = data.recommendCategoryNumber;

          if(data.recommendCategoryNumber.isEmpty) {
            recommendCategoryString = '-';
          } else {
            String temperatureString = '';
            for(int i = 0; i < categoryState.length; i++) {

              if(categoryState.elementAt(i) == 1) {
                temperatureString = '선물';
              } else if(categoryState.elementAt(i) == 2) {
                temperatureString = '호텔';
              } else if(categoryState.elementAt(i) == 3) {
                temperatureString = '점심';
              } else if(categoryState.elementAt(i) == 4) {
                temperatureString = '저녁';
              } else if(categoryState.elementAt(i) == 5) {
                temperatureString = '액티비티';
              } else if(categoryState.elementAt(i) == 6) {
                temperatureString = '술집';
              }

              if(i == categoryState.length - 1) {
                recommendCategoryString = recommendCategoryString + temperatureString;
              } else {
                recommendCategoryString = '$recommendCategoryString$temperatureString, ';
              }
            }
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Text(recommendCategoryTitle, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
                SizedBox(width: 8.0.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 7.0.h),
                  decoration: BoxDecoration(
                    color: StaticColor.grey100F6,
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Center(child: Text(recommendCategoryString, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w500))),
                )
              ],
            ),
          );
        }
    );
  }
}

class EventInfoPlanRecommendCost extends StatefulWidget {
  const EventInfoPlanRecommendCost({super.key});

  @override
  State<EventInfoPlanRecommendCost> createState() => _EventInfoPlanRecommendCostState();
}

class _EventInfoPlanRecommendCostState extends State<EventInfoPlanRecommendCost> {
  String recommendCostTitle = '예산';
  String recommendCostString = '-';

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateEventProvider>(
        builder: (context, data, child) {

          recommendCostString = '${(data.totalCost / 10000).toInt()}만원';

          /// 금액 일금으로 표시
          // var f = NumberFormat('###,###,###,###');
          // recommendCostString = f.format(data.totalCost);

          return Row(
            children: [
              Text(recommendCostTitle, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
              SizedBox(width: 8.0.w),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 7.0.h),
                  decoration: BoxDecoration(
                    color: StaticColor.grey100F6,
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Center(child: Text(recommendCostString, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w500))),
                ),
              )
            ],
          );
        }
    );
  }
}

/// 20230915

class RecommendFinishCategory extends StatefulWidget {
  String categoryString;
  RecommendFinishCategory({super.key, required this.categoryString});

  @override
  State<RecommendFinishCategory> createState() => _RecommendFinishCategoryState();
}

class _RecommendFinishCategoryState extends State<RecommendFinishCategory> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('유형', style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
        SizedBox(width: 8.0.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 7.0.h),
          decoration: BoxDecoration(
            color: StaticColor.grey100F6,
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Center(child: Text(widget.categoryString, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w500))),
        )
      ],
    );
  }
}

class RecommendFinishTarget extends StatefulWidget {
  String target;
  RecommendFinishTarget({super.key, required this.target});

  @override
  State<RecommendFinishTarget> createState() => _RecommendFinishTargetState();
}

class _RecommendFinishTargetState extends State<RecommendFinishTarget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('유형', style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
        SizedBox(width: 8.0.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 7.0.h),
          decoration: BoxDecoration(
            color: StaticColor.grey100F6,
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Center(child: Text(widget.target, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w500))),
        )
      ],
    );
  }
}

class RecommendFinishDate extends StatefulWidget {
  String date;
  RecommendFinishDate({super.key, required this.date});

  @override
  State<RecommendFinishDate> createState() => _RecommendFinishDateState();
}

class _RecommendFinishDateState extends State<RecommendFinishDate> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('날짜', style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
        SizedBox(width: 8.0.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 7.0.h),
          decoration: BoxDecoration(
            color: StaticColor.grey100F6,
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Center(child: Text(widget.date, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w500))),
        )
      ],
    );
  }
}

class RecommendFinishRegion extends StatefulWidget {
  String city;
  RecommendFinishRegion({super.key, required this.city});

  @override
  State<RecommendFinishRegion> createState() => _RecommendFinishRegionState();
}

class _RecommendFinishRegionState extends State<RecommendFinishRegion> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('위치', style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
        SizedBox(width: 8.0.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 7.0.h),
          decoration: BoxDecoration(
            color: StaticColor.grey100F6,
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Center(child: Text(widget.city, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w500))),
        )
      ],
    );
  }
}

class RecommendFinishRequestCategory extends StatefulWidget {
  String requestCategory;
  RecommendFinishRequestCategory({super.key, required this.requestCategory});

  @override
  State<RecommendFinishRequestCategory> createState() => _RecommendFinishRequestCategoryState();
}

class _RecommendFinishRequestCategoryState extends State<RecommendFinishRequestCategory> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Text('요청', style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
          SizedBox(width: 8.0.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 7.0.h),
            decoration: BoxDecoration(
              color: StaticColor.grey100F6,
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: Center(child: Text(widget.requestCategory, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w500))),
          )
        ],
      ),
    );
  }
}

class RecommendFinishRequestCost extends StatefulWidget {
  String totalCost;
  RecommendFinishRequestCost({super.key, required this.totalCost});

  @override
  State<RecommendFinishRequestCost> createState() => _RecommendFinishRequestCostState();
}

class _RecommendFinishRequestCostState extends State<RecommendFinishRequestCost> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('예산', style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
        SizedBox(width: 8.0.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 7.0.h),
          decoration: BoxDecoration(
            color: StaticColor.grey100F6,
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Center(child: Text(widget.totalCost, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w500))),
        )
      ],
    );
  }
}

class RecommendFinishRequestMemo extends StatefulWidget {
  String memo;
  RecommendFinishRequestMemo({super.key, required this.memo});

  @override
  State<RecommendFinishRequestMemo> createState() => _RecommendFinishRequestMemoState();
}

class _RecommendFinishRequestMemoState extends State<RecommendFinishRequestMemo> {

  late TextEditingController memoEditingController;

  @override
  void initState() {
    memoEditingController = TextEditingController(text: widget.memo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(top: 4.0.h),
            child: Text('메모', style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700))),
        SizedBox(width: 8.0.w),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 7.0.h),
            decoration: BoxDecoration(
              color: StaticColor.grey100F6,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: TextFormField(
                controller: memoEditingController,
                autofocus: false,
                readOnly: true,
                textInputAction: TextInputAction.next,
                maxLines: 6,
                maxLength: 300,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(color: Colors.black, fontSize: 14.sp),
                cursorHeight: 15.h,
                decoration: InputDecoration(
                    counterText: '',
                    filled: true,
                    fillColor: StaticColor.loginInputBoxColor,
                    // fillColor: Colors.black,
                    isDense: true,
                    // contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    contentPadding: EdgeInsets.symmetric(vertical: 3.0.h),
                    alignLabelWithHint: false,
                    labelStyle: TextStyle(fontSize: 14.sp, color: StaticColor.mainSoft, fontWeight: FontWeight.w500),
                    hintText: '변경할 메모 내용을 입력해주세요.',
                    hintStyle: TextStyle(fontSize: 14.sp, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderSide: BorderSide.none,
                    )
                ),
                onEditingComplete: () {
                }
            ),
            // child: Text(memoString, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w500)),
          ),
        )
      ],
    );
  }
}
