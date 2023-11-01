import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';
import 'package:sense_flutter_application/public_widget/empty_user_profile.dart';
import 'package:sense_flutter_application/views/event_feed/event_feed_provider.dart';

class EventFeedList extends StatefulWidget {
  List<EventModel> eventModelList;
  int type;
  EventFeedList({super.key, required this.eventModelList, required this.type});

  @override
  State<EventFeedList> createState() => _EventFeedListState();
}

class _EventFeedListState extends State<EventFeedList> {

  late List<EventModel> modelList;

  @override
  void initState() {
    modelList = widget.eventModelList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: Column(
        children: [
          Consumer<EventFeedProvider>(
            builder: (context, data, child) {

              String state = '-created';
              if(widget.type == 0) {
                state = data.totalButton;
              } else if(widget.type == 1) {
                state = data.recommendButton;
              }

              return Padding(
                padding: EdgeInsets.only(top: 16.0.h, bottom: 16.0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // data.sortState[0] == false ? const SizedBox.shrink() : Image.asset('assets/feed/comment_sort_check_icon.png', width: 16, height: 16),
                    const SizedBox(width: 4),
                    GestureDetector(
                        onTap: () {
                          if(widget.type == 0) {
                            context.read<EventFeedProvider>().totalButtonChange('-visit_count');
                          } else if(widget.type == 1) {
                            context.read<EventFeedProvider>().recommendButtonChange('-visit_count');
                          }

                        },
                        child: Text('인기순',
                            style: TextStyle(
                                fontSize: 12,
                                color: state == '-visit_count' ? StaticColor.mainSoft : StaticColor.grey400BB,
                                fontWeight: state == '-visit_count' ? FontWeight.w700 : FontWeight.w400))),
                    const SizedBox(width: 8),
                    Image.asset('assets/feed/bar.png', height: 10),
                    const SizedBox(width: 8),
                    GestureDetector(
                        onTap: () {
                          if(widget.type == 0) {
                            context.read<EventFeedProvider>().totalButtonChange('-created');
                          } else if(widget.type == 1) {
                            context.read<EventFeedProvider>().recommendButtonChange('-created');
                          }
                        },
                        child: Text('최신순',
                            style: TextStyle(
                                fontSize: 12,
                                color: state == '-created' ? StaticColor.mainSoft : StaticColor.grey400BB,
                                fontWeight: state == '-created' ? FontWeight.w700 : FontWeight.w400))),
                  ],
                ),
              );
            }
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: modelList.length,
                itemBuilder: (context, index) {
                  // return Container();
                  return Column(
                    children: [
                      EventFeedRow(eventModel: modelList.elementAt(index)),
                      // index == modelList.length - 1 ? const SizedBox.shrink() : dividerWidget(),
                      dividerWidget()
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dividerWidget() {
    return Container(
      width: double.infinity,
      height: 1.0.h,
      color: StaticColor.grey300E0,
    );
  }
}

class EventFeedRow extends StatefulWidget {
  EventModel eventModel;
  EventFeedRow({super.key, required this.eventModel});

  @override
  State<EventFeedRow> createState() => _EventFeedRowState();
}

class _EventFeedRowState extends State<EventFeedRow> {

  late EventModel eventModel;
  String profileImage = '';
  String name = '';
  String eventCreateTime = '';
  bool isRequest = false;
  String createTime = '';
  String title = '';
  String description = '메모가 없습니다.';
  int visitCount = 0;
  int recommendCount = 0;
  String remainDayCount = '';

  @override
  void initState() {
    eventModel = widget.eventModel;
    description = eventModel.recommendModel!.memo!;
    profileImage = eventModel.eventHost!.profileImage ?? '';
    title = eventModel.eventTitle ?? '';
    if(eventModel.eventHost!.username!.isEmpty) {
      if(eventModel.eventHost!.name!.isEmpty) {
        name = 'Unknown User';
      } else if(eventModel.eventHost!.name!.length < 3) {
        name = eventModel.eventHost!.name!;
      } else {
        name = nameObscureFunction(eventModel.eventHost!.name!);
      }
    } else if(eventModel.eventHost!.username!.length < 3) {
      name = eventModel.eventHost!.username!;
    } else {
      name = nameObscureFunction(eventModel.eventHost!.username!);
    }
    createTime = createdGap(eventModel.recommendModel!.created!);
    eventCreateTime = eventModel.created!;
    isRequest = eventCreateGap(eventCreateTime);
    visitCount = eventModel.visitCount!;
    recommendCount = eventModel.recommendCount!;
    if(eventModel.eventDate!.isEmpty) {
      remainDayCount = '이벤트 일자 미정';
    } else {
      if(makeRemainDayCountView(eventModel.eventDate!) > 0) {
        remainDayCount = 'D-${makeRemainDayCountView(eventModel.eventDate!).toString()}';
      } else if(makeRemainDayCountView(eventModel.eventDate!) == 0) {
        remainDayCount = 'D-DAY';
      } else {
        remainDayCount = '이벤트 일자 경과';
      }
    }

    super.initState();
  }

  String nameObscureFunction(String name) {
    String temperatureObscureName = '';
    int nameMiddleLength = name.length - 2;
    for(int i = 0; i < nameMiddleLength; i++) {
      temperatureObscureName = '$temperatureObscureName*';
    }
    return name.replaceRange(1, name.length - 1, temperatureObscureName);
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

  bool eventCreateGap(String inputTime) {
    DateTime nowTime = DateTime.now();
    return DateTime.parse(inputTime).isBefore(nowTime);
  }

  int makeRemainDayCountView(String inputTime) {
    DateTime nowTime = DateTime.now();
    DateTime inputTimeConvert = DateTime.parse(inputTime);
    int remainDay = int.parse(inputTimeConvert.difference(nowTime).inDays.toString());
    return remainDay;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('visit count: $visitCount');
        // context.read<CreateEventImproveProvider>().countInfoChange(visitCount, recommendCount);
        // context.read<CreateEventImproveProvider>().createEventUniqueId(eventModel.id!);
        // Navigator.push(context, MaterialPageRoute(builder: (_) => EventInfoScreen(visitCount: visitCount, recommendCount: recommendCount)));
      },
      child: Container(
        width: double.infinity,
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 24.0.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    UserProfileImage(profileImageUrl: profileImage, size: 32),
                    SizedBox(width: 8.0.w),
                    Text(name, style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                    SizedBox(width: 8.0.w),
                    Image.asset('assets/feed/comment_dot.png', width: 3.0, height: 3.0),
                    SizedBox(width: 8.0.w),
                    Text(createTime, style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                  ]
                ),
                isRequest == true ? requestWidget() : reviewWidget(),

              ],
            ),
            SizedBox(height: 16.0.h),
            Row(
              children: [
                isRequest == false ? eventImageWidget() : const SizedBox.shrink(), // 후기에만 사진
                isRequest == true ? const SizedBox.shrink() : SizedBox(width: 12.0.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleWidget(title),
                      SizedBox(height: 8.0.h),
                      descriptionWidget(description),
                    ],
                  ),
                ),
              ],
            ),
            isRequest == false ? const SizedBox.shrink() : SizedBox(height: 8.0.w),
            SizedBox(height: 8.0.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('조회', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400, height: 1.0)),
                    SizedBox(width: 8.0.w),
                    Text(visitCount.toString(), style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700, height: 1.1)),
                    SizedBox(width: 16.0.w),
                    Text('추천', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400, height: 1.0)),
                    SizedBox(width: 8.0.w),
                    Text(recommendCount.toString(), style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700, height: 1.1)),
                  ],
                ),
                Text(remainDayCount, style: TextStyle(fontSize: 12.0.sp, color: StaticColor.errorColor, fontWeight: FontWeight.w400)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget titleWidget(String title) {
    return Text(title, style: TextStyle(fontSize: 16.0.sp, color: StaticColor.grey80033, fontWeight: FontWeight.w700), softWrap: false, overflow: TextOverflow.ellipsis, maxLines: 1);
  }

  Widget descriptionWidget(String description) {
    return Text(description, style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey60077, fontWeight: FontWeight.w400), overflow: TextOverflow.ellipsis, maxLines: 2);
  }

  Widget eventImageWidget() {
    return Container(
      width: 86.0.w,
      height: 86.0.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: StaticColor.grey200EE,
        // image: DecorationImage(
        //   image: AssetImage('assets/my_page/food_background.png'),
        // ),
      ),
      child: Center(child: Image.asset('assets/public/loading_logo_image.png', width: 50)),
    );
  }

  Widget reviewWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 5.0.h),
      decoration: BoxDecoration(
        color: StaticColor.grey100F6,
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Text('후기', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400, height: 1.5)),
    );
  }

  Widget requestWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 5.0.h),
      decoration: BoxDecoration(
        color: StaticColor.grey70055,
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Text('요청', style: TextStyle(fontSize: 12.0.sp, color: Colors.white, fontWeight: FontWeight.w400, height: 1.2)),
    );
  }
}
