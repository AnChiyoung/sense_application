import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';
import 'package:sense_flutter_application/models/event_feed/event_feed_recommend_model.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/public_widget/RecommendCommentDeleteDialog.dart';
import 'package:sense_flutter_application/public_widget/empty_user_profile.dart';
import 'package:sense_flutter_application/public_widget/report_dialog.dart';
import 'package:sense_flutter_application/screens/event_info/recommend_comment/recommend_comment_screen.dart';
import 'package:sense_flutter_application/views/create_event/create_event_improve_provider.dart';
import 'package:sense_flutter_application/views/create_event/create_event_provider.dart';
import 'package:sense_flutter_application/views/event_info/event_info_provider.dart';
import 'package:sense_flutter_application/views/event_info/event_info_content_plan.dart';

class EventRecommendFinish extends StatefulWidget {
  int visitCount;
  int recommendCount;
  EventModel eventModel;
  EventRecommendFinish({super.key, required this.eventModel, required this.visitCount, required this.recommendCount});

  @override
  State<EventRecommendFinish> createState() => _EventRecommendFinishState();
}

class _EventRecommendFinishState extends State<EventRecommendFinish> {

  late EventModel eventModel;
  late RecommendRequestModel model;

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
    model = eventModel.recommendModel ?? RecommendRequestModel.initModel;

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
      region = cityStringList.elementAt(eventModel.city!.id!);
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

    if(model.totalBudget == -1) {
      totalCost = '제한없음';
    } else {
      totalCost = model.totalBudget.toString();
    }

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
          // CountField(visitCount: widget.visitCount, recommendCount: widget.recommendCount),
          // SizedBox(height: 16.0.h),
          Container(
            width: double.infinity,
            height: 1.0.h,
            color: StaticColor.grey300E0,
          ),
          SizedBox(height: 16.0.h),
          RecommendAddButton(model),
          /// 피드 댓글
          RecommendField(),
        ],
      ),
    );
  }

  Widget RecommendAddButton(RecommendRequestModel model) {
    return Container(
      width: double.infinity,
      height: 50.0.h,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => RecommendCommentScreen(model: model))).then((value) {
            setState(() {
            });
          });
        },
        style: ElevatedButton.styleFrom(backgroundColor: StaticColor.mainSoft, elevation: 3.0),
        child: Text('추천 생성하기', style: TextStyle(fontSize: 14.0.sp, color: Colors.white, fontWeight: FontWeight.w400)),
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
    return Row(
      children: [
        Text('요청', style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
        SizedBox(width: 8.0.w),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 7.0.h),
              decoration: BoxDecoration(
                color: StaticColor.grey100F6,
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Center(child: Text(widget.requestCategory, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w500))),
            ),
          ),
        ),
      ],
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

class CountField extends StatefulWidget {
  int visitCount;
  int recommendCount;
  CountField({super.key, required this.visitCount, required this.recommendCount});

  @override
  State<CountField> createState() => _CountFieldState();
}

class _CountFieldState extends State<CountField> {
  @override
  Widget build(BuildContext context) {

    int visitCount = context.read<CreateEventImproveProvider>().visitCount;
    int recommendCount = context.read<CreateEventImproveProvider>().recommendCount;

    return Row(
      children: [
        Text('조회수', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
        SizedBox(width: 8.0.w),
        Text(visitCount.toString(), style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700, height: 1.0)),
        SizedBox(width: 16.0.w),
        Text('추천', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
        SizedBox(width: 8.0.w),
        Text(recommendCount.toString(), style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700, height: 1.0)),
      ],
    );
  }
}

class EventRecommendsList extends StatefulWidget {
  List<EventFeedRecommendModel> recommendModels;
  EventRecommendsList({super.key, required this.recommendModels});

  @override
  State<EventRecommendsList> createState() => _EventRecommendsListState();
}

class _EventRecommendsListState extends State<EventRecommendsList> {

  late List<EventFeedRecommendModel> recommendModels;

  @override
  void initState() {
    recommendModels = widget.recommendModels ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: recommendModels.length,
        itemBuilder: (context, index) {
          return EventRecommendRow(model: recommendModels.elementAt(index));
        }
      ),
    );
  }
}

class EventRecommendRow extends StatefulWidget {
  EventFeedRecommendModel model;
  EventRecommendRow({super.key, required this.model});

  @override
  State<EventRecommendRow> createState() => _EventRecommendRowState();
}

class _EventRecommendRowState extends State<EventRecommendRow> {

  late EventFeedRecommendModel model;
  String profileImage = '';
  String name = '';
  String createTime = '';
  String description = '메모가 없습니다.';

  @override
  void initState() {
    model = widget.model ?? EventFeedRecommendModel();
    profileImage = model.recommendUser!.profileImageUrl!;
    if(model.recommendUser!.username!.isEmpty) {
      if(model.recommendUser!.name!.isEmpty) {
        name = 'Unknown User';
      } else {
        name = model.recommendUser!.name!;
      }
    } else {
      name = model.recommendUser!.username!;
    }
    createTime = createdGap(model.created!);
    description = model.contentDescription!;
    super.initState();
  }

  String createdGap(String inputTime) {
    /// 추천 요청 시점
    DateTime nowTime = DateTime.now();
    DateTime compareTime = DateTime.parse(inputTime);
    final duration = nowTime.difference(compareTime);

    int baseInteger = 0;
    String commentGap = '';
    if(duration.inHours == 0) {
      if(duration.inMinutes == 0) {
        commentGap = '지금';
      } else if(duration.inMinutes <= 59 && duration.inMinutes > 0) {
        baseInteger = duration.inMinutes % 60;
        commentGap = '$baseInteger분 전';
      }

    } else if(duration.inHours <= 23 && duration.inHours > 0) {
      baseInteger = duration.inHours % 24;
      commentGap = '$baseInteger시간 전';
    } else {
      baseInteger = duration.inHours ~/ 24;
      commentGap = '$baseInteger일 전';
    }
    return commentGap;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.0.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Row(
                children: [
                  UserProfileImage(profileImageUrl: profileImage, size: 32),
                  SizedBox(width: 8.0.w),
                  Text(name, style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400, height: 1.7)),
                  SizedBox(width: 8.0.w),
                  Image.asset('assets/feed/comment_dot.png', width: 3.0, height: 3.0),
                  SizedBox(width: 8.0.w),
                  Text(createTime, style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey400BB, fontWeight: FontWeight.w400, height: 1.7)),
                ]
            ),
            Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    model.recommendUser!.id! == PresentUserInfo.id
                        ? showModalBottomSheet(context: context, backgroundColor: Colors.transparent, builder: (context) {
                            return Wrap(children: [myCommentBottomSheet(context, model.id!)]);
                          }
                        )
                        : showModalBottomSheet(context: context, backgroundColor: Colors.transparent, builder: (context) { return Wrap(children: [reportBottomSheet(context, model.id!)]);});
                  },
                  customBorder: const CircleBorder(),
                  child: Image.asset('assets/feed/comment_etc_icon.png', width: 24, height: 24),
                )
            )
          ],
        ),
        SizedBox(height: 12.0.h),
        Align(
          alignment: Alignment.centerLeft,
          child: descriptionWidget(description)),
        SizedBox(height: 16.0.h),
        Container(
          width: double.infinity,
          height: 1.0.h,
          color: StaticColor.grey300E0,
        )
      ],
    );
  }

  Widget descriptionWidget(String description) {
    return Text(description, style: TextStyle(fontSize: 14.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w400), overflow: TextOverflow.ellipsis, maxLines: 6);
  }

  Widget myCommentBottomSheet(BuildContext context, int commentId) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
      ),
      child: Column(
        children: [
          /// title section
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 26, top: 24, bottom: 32),
            child: Text('나의 추천', style: TextStyle(fontSize: 18, color: StaticColor.grey80033, fontWeight: FontWeight.w700)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 64),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showDialog(context: context, builder: (context) {
                        return RecommendCommentDeleteDialog(commentId: commentId);
                      });
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: StaticColor.errorBackgroundColor, elevation: 0.0),
                    child: Text('삭제하기', style: TextStyle(fontSize: 14, color: StaticColor.textErrorColor, fontWeight: FontWeight.w400)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget reportBottomSheet(BuildContext context, int index) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
      ),
      child: Column(
        children: [
          /// title section
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 26, top: 24, bottom: 32),
            child: Text('신고', style: TextStyle(fontSize: 18, color: StaticColor.grey80033, fontWeight: FontWeight.w700)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 64),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ReportDialog(index: index!);
                      });
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: StaticColor.errorBackgroundColor, elevation: 0.0),
                    child: Text('신고하기', style: TextStyle(fontSize: 14, color: StaticColor.textErrorColor, fontWeight: FontWeight.w400)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
