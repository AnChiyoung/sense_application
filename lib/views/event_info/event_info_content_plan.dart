import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';
import 'package:sense_flutter_application/public_widget/actions.dart';
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
      future: EventRequest().eventRequest(context.read<CreateEventProvider>().eventUniqueId),
      builder: (context, snapshot) {
        if(snapshot.hasData) {

          if(snapshot.connectionState == ConnectionState.waiting) {
            return Text('waiting');
          } else if(snapshot.connectionState == ConnectionState.done) {

            /// get personal event model
            EventModel eventPersonalModel = snapshot.data ?? EventModel();
            modelParse(eventPersonalModel);

            String title = eventPersonalModel.eventTitle!;
            int category = eventPersonalModel.eventCategoryObject!.id! - 1;
            int target = eventPersonalModel.targetCategoryObject!.id! - 1;
            String date = eventPersonalModel.eventDate!;
            int city = eventPersonalModel.city!.id!;
            int subCity = eventPersonalModel.subCity!.id!;
            String memo = eventPersonalModel.description!;

            // context.read<EventInfoProvider>().titleChange(eventPersonalModel.eventTitle!);
            // context.read<CreateEventProvider>().titleChange(eventPersonalModel.eventTitle!);
            context.read<CreateEventProvider>().titleChange(eventPersonalModel.eventTitle!);
            context.read<CreateEventProvider>().categoryChange(category);
            context.read<CreateEventProvider>().targetChange(target);
            context.read<CreateEventProvider>().dateChange(date);
            context.read<CreateEventProvider>().cityChange(city);
            context.read<CreateEventProvider>().memoChange(memo);
            context.read<CreateEventProvider>().isAlarmChagne(eventPersonalModel.isAlarm!);
            context.read<CreateEventProvider>().publicTypeChange(eventPersonalModel.publicType!);

            return Padding(
              padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 16.0.w),
              child: Column(
                children: [
                  EventInfoPlanTitle(),
                  SizedBox(height: 16.0.h),
                  const Row(
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
                  const Row(
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
            return Text('done');
          }

        } else if(snapshot.hasError) {
          return Text('has error');
        } else {
          return Text('else');
        }
      }
    );
  }

  void modelParse(EventModel model) {
    // context.read<CreateEventProvider>().titleChange(model.eventTitle!);
  }
}

class EventInfoPlanTitle extends StatefulWidget {
  const EventInfoPlanTitle({super.key});

  @override
  State<EventInfoPlanTitle> createState() => _EventInfoPlanTitleState();
}

class _EventInfoPlanTitleState extends State<EventInfoPlanTitle> {

  String title = '-';
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateEventProvider>(
      builder: (context, data, child) {

        if(data.title.isEmpty) {
          editingController.text = '-';
        } else {
          editingController.text = data.title;
        }

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
              onChanged: (v) {
                // context.read<CreateEventProvider>().titleChange(v);
              }
          ),
          // child: Text(title, style: TextStyle(fontSize: 14.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w500)),
        );
      }
    );

  }
}

class EventInfoPlanCategory extends StatefulWidget {
  const EventInfoPlanCategory({super.key});

  @override
  State<EventInfoPlanCategory> createState() => _EventInfoPlanCategoryState();
}

class _EventInfoPlanCategoryState extends State<EventInfoPlanCategory> {

  String categoryTitle = '유형';
  String categoryString = '-';

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateEventProvider>(
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
            if(context.read<CreateEventProvider>().eventInfoTabState.elementAt(0) == true) {
              context.read<CreateEventProvider>().eventStepState(0);
              TriggerActions().showCreateEventView(context);
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
  const EventInfoPlanTarget({super.key});

  @override
  State<EventInfoPlanTarget> createState() => _EventInfoPlanTargetState();
}

class _EventInfoPlanTargetState extends State<EventInfoPlanTarget> {
  String tartgetTitle = '대상';
  String tartgetString = '-';

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateEventProvider>(
        builder: (context, data, child) {

          int targetState = data.target;
          if(targetState == 0) {
            tartgetString = '가족';
          } else if(targetState == 1) {
            tartgetString = '연인';
          } else if(targetState == 2) {
            tartgetString = '가족';
          } else if(targetState == 3) {
            tartgetString = '직장';
          } else {
            tartgetString = '-';
          }

          return GestureDetector(
            onTap: () {
              if(context.read<CreateEventProvider>().eventInfoTabState.elementAt(0) == true) {
                context.read<CreateEventProvider>().eventStepState(1);
                TriggerActions().showCreateEventView(context);
              } else {

              }
            },
            child: Row(
              children: [
                Text(tartgetTitle, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
                SizedBox(width: 8.0.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 7.0.h),
                  decoration: BoxDecoration(
                    color: StaticColor.grey100F6,
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Center(child: Text(tartgetString, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w500))),
                )
              ],
            ),
          );
        }
    );
  }
}

class EventInfoPlanDate extends StatefulWidget {
  const EventInfoPlanDate({super.key});

  @override
  State<EventInfoPlanDate> createState() => _EventInfoPlanDateState();
}

class _EventInfoPlanDateState extends State<EventInfoPlanDate> {
  String dateTitle = '날짜';
  String dateString = '-';

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateEventProvider>(
        builder: (context, data, child) {

          if(data.date.isEmpty) {
            dateString = '-';
          } else {
            dateString = data.date;
          }

          return GestureDetector(
            onTap: () {
              if(context.read<CreateEventProvider>().eventInfoTabState.elementAt(0) == true) {
                context.read<CreateEventProvider>().eventStepState(2);
                TriggerActions().showCreateEventView(context);
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
  const EventInfoPlanRegion({super.key});

  @override
  State<EventInfoPlanRegion> createState() => _EventInfoPlanRegionState();
}

class _EventInfoPlanRegionState extends State<EventInfoPlanRegion> {
  String locationTitle = '위치';
  String locationString = '-';

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateEventProvider>(
        builder: (context, data, child) {

          locationString = '서울 전체';

          return GestureDetector(
            onTap: () {
              // if(context.read<EventInfoProvider>().eventInfoTabState.elementAt(0) == true) {
              //   // context.read<CreateEventProvider>().eventStepState(3);
              //   // TriggerActions().showCreateEventView(context);
              // } else {
              //
              // }

              if(context.read<CreateEventProvider>().eventInfoTabState.elementAt(0) == true) {
                context.read<CreateEventProvider>().eventStepState(3);
                TriggerActions().showCreateEventView(context);
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
  const EventInfoPlanMemo({super.key});

  @override
  State<EventInfoPlanMemo> createState() => _EventInfoPlanMemoState();
}

class _EventInfoPlanMemoState extends State<EventInfoPlanMemo> {
  String memoTitle = '메모';
  String memoString = '-';
  TextEditingController memoEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateEventProvider>(
        builder: (context, data, child) {

          if(data.memo.isEmpty) {
            memoEditingController.text = '-';
          } else {
            memoEditingController.text = data.memo;
          }

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
                      onChanged: (v) {
                        context.read<CreateEventProvider>().memoChange(v);
                      }
                  ),
                  // child: Text(memoString, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w500)),
                ),
              )
            ],
          );
        }
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
                          context.read<CreateEventProvider>().eventInfoTabStateChange([false, true]);
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
