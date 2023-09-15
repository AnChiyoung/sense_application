import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';
import 'package:sense_flutter_application/public_widget/actions.dart';
import 'package:sense_flutter_application/views/create_event/create_event_improve_provider.dart';
import 'package:sense_flutter_application/views/event_info/event_info_provider.dart';
import 'package:sense_flutter_application/views/create_event/create_event_provider.dart';

class EventInfoView extends StatefulWidget {
  const EventInfoView({super.key});

  @override
  State<EventInfoView> createState() => _EventInfoViewState();
}

class _EventInfoViewState extends State<EventInfoView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: EventRequest().eventRequest(context.read<CreateEventImproveProvider>().eventUniqueId),
      builder: (context, snapshot) {
        if(snapshot.hasData) {

          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
          } else if(snapshot.connectionState == ConnectionState.done) {

            /// get personal event model
            EventModel eventPersonalModel = snapshot.data ?? EventModel();
            modelParse(eventPersonalModel);

            String title = eventPersonalModel.eventTitle! ?? '';
            int category;
            if(eventPersonalModel.eventCategoryObject!.id == -1) {
              category = -1;
            } else {
              category = eventPersonalModel.eventCategoryObject!.id! - 1;
            }
            int target;
            if(eventPersonalModel.targetCategoryObject!.id == -1) {
              target = -1;
            } else {
              target = eventPersonalModel.targetCategoryObject!.id! - 1;
            }
            String date = eventPersonalModel.eventDate!;
            String memo = eventPersonalModel.description!;
            bool alarm = eventPersonalModel.isAlarm!;
            String publicType = eventPersonalModel.publicType!;

            print(title);
            print(category);
            print(target);
            print(date);
            print(memo);
            print(alarm);
            print(publicType);

            context.read<CreateEventImproveProvider>().titleChange(title, true);
            // context.read<CreateEventImproveProvider>().saveCategoryChange(category, false);
            // context.read<CreateEventImproveProvider>().saveTargetChange(target, false);
            // context.read<CreateEventImproveProvider>().dateChange(date);
            // // context.read<CreateEventProvider>().cityChange(city);
            // context.read<CreateEventProvider>().memoChange(memo);
            // context.read<CreateEventProvider>().isAlarmChange(alarm);
            // context.read<CreateEventProvider>().publicTypeChange(publicType);

            return Padding(
              padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 16.0.w),
              child: Column(
                children: [
                  EventInfoPlanTitle(),
                  SizedBox(height: 16.0.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          flex: 1,
                          child: EventInfoPlanCategory()),
                      Flexible(
                          flex: 1,
                          child: EventInfoPlanTarget()),
                    ],
                  ),
                  SizedBox(height: 8.0.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          flex: 1,
                          child: EventInfoPlanDate()),
                      Flexible(
                          flex: 1,
                          child: EventInfoPlanRegion()),
                    ],
                  ),
                  SizedBox(height: 16.0.h),
                  EventInfoPlanMemo(),
                  SizedBox(height: 33.0.h),
                  RecommendField(),
                ],
              ),
            );

          } else {
            return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
          }

        } else if(snapshot.hasError) {
          return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
        } else {
          return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
        }
      }
    );
  }

  void modelParse(EventModel model) {
    // context.read<CreateEventProvider>().titleChange(model.eventTitle!);
  }
}

class EventInfoPlanTitle extends StatefulWidget {
  String? title;
  EventInfoPlanTitle({super.key, this.title});

  @override
  State<EventInfoPlanTitle> createState() => _EventInfoPlanTitleState();
}

class _EventInfoPlanTitleState extends State<EventInfoPlanTitle> {

  String title = '-';
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    title = widget.title ?? '-';
    editingController.text = title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 10.0.h),
      width: double.infinity,
      // height: 50,
      decoration: BoxDecoration(
        color: StaticColor.grey100F6,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: TextFormField(
          controller: editingController,
          autofocus: false,
          textInputAction: TextInputAction.next,
          maxLines: 1,
          maxLength: 20,
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(color: Colors.black, fontSize: 14.sp),
          cursorHeight: 15.h,
          decoration: InputDecoration(
              counterText: '',
              filled: true,
              fillColor: StaticColor.loginInputBoxColor,
              // fillColor: Colors.black,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: -3.0.h),
              alignLabelWithHint: false,
              labelStyle: TextStyle(fontSize: 14.sp, color: StaticColor.mainSoft, fontWeight: FontWeight.w500),
              hintText: '변경할 이벤트 이름을 입력해주세요.',
              hintStyle: TextStyle(fontSize: 14.sp, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                borderSide: BorderSide.none,
              )
          ),
          onEditingComplete: () async {
            bool titleChangeResult = await EventRequest().personalFieldUpdateEvent(
              context,
              context.read<CreateEventImproveProvider>().eventUniqueId,
              0
            );
            /// 이벤트 업데이트 성공하면 화면 제목 단 변경
            if(titleChangeResult == true) {
              print('view header title change : ${editingController.text}');
              context.read<CreateEventImproveProvider>().titleChange(editingController.text, true);
            }
          }
      ),
      // child: Text(title, style: TextStyle(fontSize: 14.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w500)),
    );
  }
}

class EventInfoPlanCategory extends StatefulWidget {
  int? category;
  EventInfoPlanCategory({super.key, this.category});

  @override
  State<EventInfoPlanCategory> createState() => _EventInfoPlanCategoryState();
}

class _EventInfoPlanCategoryState extends State<EventInfoPlanCategory> {

  String categoryTitle = '유형';
  String categoryString = '-';

  @override
  void initState() {
    context.read<CreateEventImproveProvider>().saveCategoryChange(null, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateEventImproveProvider>(
      builder: (context, data, child) {

        int categoryState = data.category;

        if(categoryState == 0) {
          categoryString = '생일';
        } else if(categoryState == 1) {
          categoryString = '데이트';
        } else if(categoryState == 2) {
          categoryString = '여행';
        } else if(categoryState == 3) {
          categoryString = '모임';
        } else if(categoryState == 4) {
          categoryString = '비즈니스';
        } else {
          categoryString = '-';
        }

        return GestureDetector(
          onTap: () {
            if(context.read<CreateEventImproveProvider>().eventInfoTabState.elementAt(0) == true) {
              context.read<CreateEventImproveProvider>().eventStepState(0);
              TriggerActions().showCreateEventView(context, true);
            } else {

            }
          },
          child: Row(
            children: [
              Text(categoryTitle, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
              SizedBox(width: 8.0.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 7.0.h),
                decoration: BoxDecoration(
                  color: StaticColor.grey100F6,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Center(child: Text(categoryString, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w500))),
              )
            ],
          ),
        );
      }
    );
  }
}

class EventInfoPlanTarget extends StatefulWidget {
  int? target;
  EventInfoPlanTarget({super.key, this.target});

  @override
  State<EventInfoPlanTarget> createState() => _EventInfoPlanTargetState();
}

class _EventInfoPlanTargetState extends State<EventInfoPlanTarget> {
  String targetTitle = '대상';
  String targetString = '-';

  @override
  void initState() {
    context.read<CreateEventImproveProvider>().saveTargetChange(null, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateEventImproveProvider>(
      builder: (context, data, child) {

        int targetState = data.target;
        if(targetState == 0) {
          targetString = '가족';
        } else if(targetState == 1) {
          targetString = '연인';
        } else if(targetState == 2) {
          targetString = '친구';
        } else if(targetState == 3) {
          targetString = '직장';
        } else {
          targetString = '-';
        }

        return GestureDetector(
          onTap: () {
            if(context.read<CreateEventImproveProvider>().eventInfoTabState.elementAt(0) == true) {
              context.read<CreateEventImproveProvider>().eventStepState(1);
              TriggerActions().showCreateEventView(context, true);
            } else {

            }
          },
          child: Row(
            children: [
              Text(targetTitle, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
              SizedBox(width: 8.0.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 7.0.h),
                decoration: BoxDecoration(
                  color: StaticColor.grey100F6,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Center(child: Text(targetString, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w500))),
              )
            ],
          ),
        );
      }
    );
  }
}

class EventInfoPlanDate extends StatefulWidget {
  String? date;
  EventInfoPlanDate({super.key, this.date});

  @override
  State<EventInfoPlanDate> createState() => _EventInfoPlanDateState();
}

class _EventInfoPlanDateState extends State<EventInfoPlanDate> {
  String dateTitle = '날짜';
  String dateString = '-';

  @override
  void initState() {
    context.read<CreateEventImproveProvider>().dateChange(widget.date ?? '', false);


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateEventImproveProvider>(
      builder: (context, data, child) {

        if(data.date!.isEmpty) {
          dateString = '-';
        } else {
          dateString = data.date;
        }

        return GestureDetector(
          onTap: () {
            if(context.read<CreateEventImproveProvider>().eventInfoTabState.elementAt(0) == true) {
              context.read<CreateEventImproveProvider>().eventStepState(2);
              TriggerActions().showCreateEventView(context, true);
            } else {

            }
          },
          child: Row(
            children: [
              Text(dateTitle, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
              SizedBox(width: 8.0.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 7.0.h),
                decoration: BoxDecoration(
                  color: StaticColor.grey100F6,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Center(child: Text(dateString, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w500))),
              )
            ],
          ),
        );
      }
    );
  }
}

class EventInfoPlanRegion extends StatefulWidget {
  String? city;
  EventInfoPlanRegion({super.key, this.city});

  @override
  State<EventInfoPlanRegion> createState() => _EventInfoPlanRegionState();
}

class _EventInfoPlanRegionState extends State<EventInfoPlanRegion> {
  String locationTitle = '위치';
  String locationString = '-';
  List<String> cityNameList = ['서울', '경기도', '인천', '강원도', '경상도', '전라도', '충청도', '부산', '제주'];

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateEventProvider>(
        builder: (context, data, child) {

          int city = data.city;
          if(city == -1) {
            locationString = '-';
          } else {
            locationString = cityNameList.elementAt(city);
          }

          return GestureDetector(
            onTap: () {
              // if(context.read<EventInfoProvider>().eventInfoTabState.elementAt(0) == true) {
              //   // context.read<CreateEventProvider>().eventStepState(3);
              //   // TriggerActions().showCreateEventView(context);
              // } else {
              //
              // }

              if(context.read<CreateEventImproveProvider>().eventInfoTabState.elementAt(0) == true) {
                context.read<CreateEventImproveProvider>().eventStepState(3);
                TriggerActions().showCreateEventView(context, true);
              } else {

              }
            },
            child: Row(
              children: [
                Text(locationTitle, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
                SizedBox(width: 8.0.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 7.0.h),
                  decoration: BoxDecoration(
                    color: StaticColor.grey100F6,
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Center(child: Text(locationString, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w500))),
                )
              ],
            ),
          );
        }
    );
  }
}

class EventInfoPlanMemo extends StatefulWidget {
  String? memo;
  EventInfoPlanMemo({super.key, this.memo});

  @override
  State<EventInfoPlanMemo> createState() => _EventInfoPlanMemoState();
}

class _EventInfoPlanMemoState extends State<EventInfoPlanMemo> {
  String memoTitle = '메모';
  String memoString = '-';
  TextEditingController memoEditingController = TextEditingController();

  @override
  void initState() {
    if(widget.memo == null) {
      memoString = '-';
    } else {
      memoString = widget.memo ?? '';
      memoEditingController.text = memoString;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(top: 4.0.h),
            child: Text(memoTitle, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700))),
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
                onEditingComplete: () async {
                  bool memoChangeResult = await EventRequest().personalFieldUpdateEvent(
                    context,
                    context.read<CreateEventImproveProvider>().eventUniqueId,
                    4
                  );
                  if(memoChangeResult == true) {
                    print('view memo update : ${memoEditingController.text}');
                    context.read<CreateEventImproveProvider>().memoChange(memoEditingController.text, false);
                  }
                }
            ),
            // child: Text(memoString, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w500)),
          ),
        )
      ],
    );
  }
}

class RecommendField extends StatefulWidget {
  const RecommendField({super.key});

  @override
  State<RecommendField> createState() => _RecommendFieldState();
}

class _RecommendFieldState extends State<RecommendField> {

  String recommendTitle = '추천';
  bool recommendRequestState = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateEventProvider>(
      builder: (context, data, child) {

        recommendRequestState = data.recommendRequestState;

        if(recommendRequestState == true) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(recommendTitle, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
              SizedBox(height: 8.0.h),
              Container(
                padding: EdgeInsets.symmetric(vertical: 30.0.h),
                decoration: BoxDecoration(
                  color: StaticColor.grey100F6,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text('플래너들이 추천을 준비 중이예요!', style: TextStyle(fontSize: 14.sp, color: StaticColor.grey400BB, fontWeight: FontWeight.w400)),
                ),
              ),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(recommendTitle, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
              SizedBox(height: 8.0.h),
              Container(
                padding: EdgeInsets.symmetric(vertical: 32.0.h),
                decoration: BoxDecoration(
                  color: StaticColor.grey100F6,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text('아직 선택한 이벤트가 없어요', style: TextStyle(fontSize: 14.sp, color: StaticColor.grey400BB, fontWeight: FontWeight.w400)),
                      SizedBox(height: 16.0.h),
                      ElevatedButton(
                        onPressed: () {
                          context.read<CreateEventImproveProvider>().eventInfoTabStateChange([false, true]);
                        },
                        child: Text('추천보기', style: TextStyle(fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.w400)),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      }
    );
  }
}
