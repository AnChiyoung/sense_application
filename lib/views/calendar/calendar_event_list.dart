import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/calendar/calendar_home_model.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';
import 'package:sense_flutter_application/public_widget/empty_user_profile.dart';
import 'package:sense_flutter_application/public_widget/event_category_label.dart';
import 'package:sense_flutter_application/screens/event_detail/event_detail_screen.dart';
import 'package:sense_flutter_application/views/calendar/calendar_provider.dart';

class EventList extends StatefulWidget {
  const EventList({super.key});

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  final eventListController = ScrollController();
  List<Map<String, List<EventModel>>> monthEventMap = [];

  @override
  void initState() {
    // WidgetsBinding.instance!.addPostFrameCallback((_) => context.read<CalendarBodyProvider>().eventModelCollectionChange(monthEventMap, true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CalendarProvider>(builder: (context, data, child) {
      int selectYear = data.selectYear;
      int selectMonth = data.selectMonth;
      int selectDay = data.selectDay;

      // print('select year : $selectYear');
      // print('select month : $selectMonth');

      return Expanded(
          child: FutureBuilder(
              future: EventRequest().eventListRequest(selectMonth, selectYear),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const SizedBox.shrink();
                } else if (snapshot.hasData) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text('이벤트가 없습니다', style: TextStyle(color: Colors.black)));
                    } else {
                      /// month total data variable
                      monthEventMap = [];

                      // print('event models? : ${snapshot.data!}');

                      /// data binding
                      List<EventModel>? models;

                      if (snapshot.data == null) {
                      } else if (snapshot.data != null) {
                        if (snapshot.data!.isEmpty) {
                        } else if (snapshot.data!.isNotEmpty) {
                          models = snapshot.data;
                        }
                      }

                      /// calendar event source insert
                      for (int i = 0; i < models!.length; i++) {
                        EventSource.eventSource[
                            DateTime.parse(models.elementAt(i).eventDate.toString())] = [
                          const Event('event source!!')
                        ];
                      }

                      /// data sort (빠른 날짜 순)
                      models.sort((a, b) =>
                          DateTime.parse(a.eventDate!).compareTo(DateTime.parse(b.eventDate!)));

                      /// data sort (날짜별로 묶)
                      List<int> eventDayIsolate = [];
                      for (int i = 0; i < models.length; i++) {
                        int day = DateTime.parse(models.elementAt(i).eventDate!).day;
                        eventDayIsolate.add(day);
                      }

                      /// data 중복 제거
                      eventDayIsolate = eventDayIsolate.toSet().toList();

                      /// map 생성
                      for (int i = 0; i < eventDayIsolate.length; i++) {
                        List<EventModel> temperatureModel = [];
                        Map<String, List<EventModel>> temperatureMap = {};
                        for (int j = 0; j < models.length; j++) {
                          if (DateTime.parse(models.elementAt(j).eventDate!).day ==
                              eventDayIsolate.elementAt(i)) {
                            temperatureModel.add(models.elementAt(j));
                          }
                        }
                        temperatureMap[eventDayIsolate.elementAt(i).toString()] = temperatureModel;

                        /// 여기가 문제
                        monthEventMap.add(temperatureMap); // List<Map>> attach!!
                        // temperatureModel.clear();
                        // temperatureMap.clear();
                        context
                            .read<CalendarBodyProvider>()
                            .eventModelCollectionChange(monthEventMap, false);
                      }

                      /// event load result
                      if (kDebugMode) {
                        // print('event load result : $monthEventMap');
                        // print(monthEventMap.elementAt(0)['24']);
                      }

                      // return Container(height: 30, width: 30, color: Colors.red);
                      return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                              // EventHeader(),
                              // EventHeaderMenu(),
                              CalendarEventList(monthListModels: monthEventMap),
                            ],
                          ));
                    }
                  } else {
                    // return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
                    return const Center(child: CircularProgressIndicator());
                  }
                } else {
                  // return Center(child: Lottie.asset('assets/lottie/loading.json', width: 150, height: 150));
                  // return const SizedBox.shrink();
                  return const Center(child: CircularProgressIndicator());
                }
              }));
    });
  }

  // Widget EventHeaderMenu() {
  //   return Consumer<CalendarProvider>(
  //       builder: (context, data, child) {
  //
  //         String selectMonth = data.selectMonth.toString();
  //
  //         return Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text('$selectMonth월', style: TextStyle(fontSize: 20, color: StaticColor.black90015, fontWeight: FontWeight.w700)),
  //               /// disabled. kind of event filter. 20230813
  //               // Material(
  //               //   color: Colors.transparent,
  //               //   child: SizedBox(
  //               //     width: 40,
  //               //     height: 40,
  //               //     child: InkWell(
  //               //       borderRadius: BorderRadius.circular(25.0),
  //               //       onTap: () {
  //               //         showModalBottomSheet(context: context, backgroundColor: Colors.transparent, builder: (context) { return Wrap(children: [EventListSettingBottomSheet()]);});
  //               //       },
  //               //       child: Center(child: Image.asset('assets/calendar/calendar_eventlist_setting.png', width: 24, height: 24)),
  //               //     ),
  //               //   ),
  //               // ),
  //             ]
  //         );
  //       }
  //   );
  // }

  Widget EventHeader() {
    return const Padding(
      padding: EdgeInsets.only(top: 10, bottom: 26),
      child: SizedBox(
        width: double.infinity,
        // child: Image.asset('assets/calendar/event_header_bar.png', width: 81, height: 4),
      ),
    );
  }
}

class CalendarEventList extends StatefulWidget {
  // List<EventModel>? monthListModels;
  List<Map<String, List<EventModel>>>? monthListModels;
  CalendarEventList({super.key, this.monthListModels});

  @override
  State<CalendarEventList> createState() => _CalendarEventListState();
}

class _CalendarEventListState extends State<CalendarEventList> {
  List<Map<String, List<EventModel>>>? models;
  int modelLength = 0;
  ScrollController monthEventListController = ScrollController();

  @override
  void initState() {
    models = widget.monthListModels ?? [];
    modelLength = models!.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (modelLength == 0) {
      return const Center(child: Text('no data..'));
    } else {
      /// 월 전체 이벤트 리스트
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: ListView.builder(
                shrinkWrap: true,
                controller: monthEventListController,
                physics: const ClampingScrollPhysics(),
                itemCount: modelLength,
                itemBuilder: (context, index) {
                  // return Container();
                  /// 일자별 이벤트 리스트
                  // return Container(height: 30);
                  return DayEventList(
                      model: models!.elementAt(index), controller: monthEventListController);
                  // return Container(child: Text(models!.elementAt(index).eventDate!, style: TextStyle(color: Colors.black)));
                }),
          ),
        ),
      );
    }
  }
}

// class CalendarEventListRow extends StatefulWidget {
//   const CalendarEventListRow({super.key});
//
//   @override
//   State<CalendarEventListRow> createState() => _CalendarEventListRowState();
// }
//
// class _CalendarEventListRowState extends State<CalendarEventListRow> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

class DayEventList extends StatefulWidget {
  Map<String, List<EventModel>>? model;
  ScrollController controller;
  DayEventList({super.key, this.model, required this.controller});

  @override
  State<DayEventList> createState() => _DayEventListState();
}

class _DayEventListState extends State<DayEventList> {
  Map<String, List<EventModel>>? model;

  @override
  void initState() {
    if (widget.model == null) {
      model!['0'] = [];
    } else {
      model = widget.model;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DayEventsInfo(model: widget.model!),
        const SizedBox(height: 8.0),
        DayEventsList(model: widget.model!, controller: widget.controller),
        const SizedBox(height: 20.0),
      ],
    );
  }
}

class DayEventsInfo extends StatefulWidget {
  Map<String, List<EventModel>> model;

  DayEventsInfo({super.key, required this.model});

  @override
  State<DayEventsInfo> createState() => _DayEventsInfoState();
}

class _DayEventsInfoState extends State<DayEventsInfo> {
  late Map<String, List<EventModel>> modelMap;
  late List<EventModel> model;
  String day = '';
  String eventCount = '';
  String weekString = '';

  @override
  void initState() {
    modelMap = widget.model;

    /// value로 key값 받아오기로 변경해야 함
    day = modelMap.keys.first;
    model = modelMap[day]!;
    eventCount = model.length.toString();

    /// 요일 catch!!
    int weekDay = DateTime.parse(model.elementAt(0).eventDate!).weekday;
    if (weekDay == 7) {
      weekString = '일';
    } else if (weekDay == 1) {
      weekString = '월';
    } else if (weekDay == 2) {
      weekString = '화';
    } else if (weekDay == 3) {
      weekString = '수';
    } else if (weekDay == 4) {
      weekString = '목';
    } else if (weekDay == 5) {
      weekString = '금';
    } else if (weekDay == 6) {
      weekString = '토';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$day일 $weekString요일',
            style: TextStyle(
                fontSize: 16, color: StaticColor.eventDayColor, fontWeight: FontWeight.w700)),
        const SizedBox(width: 6.0),
        Image.asset('assets/calendar/event_list_dot.png', width: 4.0, height: 4.0),
        const SizedBox(width: 6.0),
        Text('일정 $eventCount건',
            style:
                TextStyle(fontSize: 16, color: StaticColor.grey50099, fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class DayEventsList extends StatefulWidget {
  Map<String, List<EventModel>> model;
  ScrollController controller;
  DayEventsList({super.key, required this.model, required this.controller});

  @override
  State<DayEventsList> createState() => _DayEventsListState();
}

class _DayEventsListState extends State<DayEventsList> {
  late Map<String, List<EventModel>> modelMap;
  late List<EventModel> model;
  String day = '';
  String eventCount = '';
  String weekString = '';

  @override
  void initState() {
    modelMap = widget.model;

    /// value로 key값 받아오기로 변경해야 함
    day = modelMap.keys.first;
    model = modelMap[day]!;
    eventCount = model.length.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          controller: widget.controller,
          itemCount: int.parse(eventCount),
          itemBuilder: (context, index) {
            // return Container();
            return Column(
              children: [
                GestureDetector(
                    onTap: () {
                      // // Preferences.recentlyEventSave(model.elementAt(index));
                      // // widget.controller.jumpTo(100);
                      // context.read<EDProvider>().setId(id: model.elementAt(index).id!);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EventDetailScreen(eventId: model.elementAt(index).id!)),
                          (route) => false);
                      // // Navigator.push(context, MaterialPageRoute(builder: (_) => EventInfoScreen(visitCount: 0, recommendCount: 0)));
                    },
                    child: EventRow(model: model.elementAt(index) ?? EventModel())),
                const Divider(height: 12.0, color: Color.fromARGB(0, 21, 21, 21)),
              ],
            );
          }),
    );
  }
}

class EventRow extends StatefulWidget {
  EventModel model;
  EventRow({super.key, required this.model});

  @override
  State<EventRow> createState() => _EventRowState();
}

class _EventRowState extends State<EventRow> {
  late EventModel model;
  Widget categoryWidget = const SizedBox.shrink();
  String city = '';
  String subCity = '';

  @override
  void initState() {
    model = widget.model;

    List<String> cityNameList = ['서울', '경기도', '인천', '강원도', '경상도', '전라도', '충청도', '부산', '제주'];
    if (model.city == null) {
      city = '지역 미설정';
    } else {
      city = cityNameList.elementAt(model.city!.id!);
    }

    // null
    if (model.eventCategoryObject == null) {
      categoryWidget = const SizedBox.shrink();
    } else {
      if (model.eventCategoryObject!.id == 1) {
        categoryWidget = birthdayLabel;
      } else if (model.eventCategoryObject!.id == 2) {
        categoryWidget = dateLabel;
      } else if (model.eventCategoryObject!.id == 3) {
        categoryWidget = travelLabel;
      } else if (model.eventCategoryObject!.id == 4) {
        categoryWidget = meetLabel;
      } else if (model.eventCategoryObject!.id == 5) {
        categoryWidget = businessLabel;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      width: double.infinity,
      // height: 100,
      decoration: BoxDecoration(
        color: StaticColor.eventBoxColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// title + category
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(model.eventTitle! ?? '',
                style: TextStyle(
                    fontSize: 16, color: StaticColor.black90015, fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis),
            categoryWidget
          ]),
          const SizedBox(height: 2.0),

          /// location + time range
          Row(
            children: [
              Text(city,
                  style: TextStyle(
                      fontSize: 12, color: StaticColor.grey60077, fontWeight: FontWeight.w400)),
              // Text('${model.city!.title!} ${model.subCity!.title!}', style: TextStyle(fontSize: 12, color: StaticColor.grey60077, fontWeight: FontWeight.w400)),
              /// 시간 없음. 백 수정
            ],
          ),
          const SizedBox(height: 8.0),

          /// with users
          // EventUsers(userModelList: model.eventUser! ?? []),
        ],
      ),
    );
  }
}

class EventUsers extends StatefulWidget {
  List<EventUser> userModelList;
  EventUsers({super.key, required this.userModelList});

  @override
  State<EventUsers> createState() => _EventUsersState();
}

class _EventUsersState extends State<EventUsers> {
  late List<EventUser> userModelList;
  Widget userProfiles = const SizedBox.shrink();

  @override
  void initState() {
    userModelList = widget.userModelList;
    makeEventUserWidgets(userModelList);
    super.initState();
  }

  void makeEventUserWidgets(List<EventUser> model) {
    List<Widget> profiles = [];
    int nonViewUserCount = 0;

    for (int i = 0; i < model.length; i++) {
      if (i == 0) {
        profiles.add(
          Container(
            width: 25.0,
            height: 25.0,
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: Colors.white),
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(300),
              child: UserProfileImage(profileImageUrl: model.elementAt(i).userData!.profileImage),
            ),
          ),
        );
      } else if (i == 1) {
        profiles.add(
          Positioned(
            left: 16.0,
            child: Container(
              width: 25.0,
              height: 25.0,
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.white),
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(300),
                child: UserProfileImage(profileImageUrl: model.elementAt(i).userData!.profileImage),
              ),
            ),
          ),
        );
      } else {
        nonViewUserCount++;
      }

      if (nonViewUserCount != 0) {
        profiles.add(
          Positioned(
            left: 32.0,
            child: Container(
              width: 25.0,
              height: 25.0,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white),
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(300),
                  child: Container(
                      width: 24,
                      height: 24,
                      color: StaticColor.grey400BB,
                      child: Center(
                          child: Text('+${nonViewUserCount.toString()}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400))))),
            ),
          ),
        );
      }

      print(profiles);

      userProfiles = Stack(children: profiles);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: userProfiles,
    );
  }
}

class EventListSettingBottomSheet extends StatefulWidget {
  const EventListSettingBottomSheet({super.key});

  @override
  State<EventListSettingBottomSheet> createState() => _EventListSettingBottomSheetState();
}

class _EventListSettingBottomSheetState extends State<EventListSettingBottomSheet> {
  bool check01 = false, check02 = false, check03 = false, check04 = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
      ),
      child: Column(
        children: [
          /// title section
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 26, top: 24, bottom: 32),
            child: Text('대상',
                style: TextStyle(
                    fontSize: 18, color: StaticColor.grey80033, fontWeight: FontWeight.w700)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 64),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      check01 = !check01;
                    });
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                      decoration: BoxDecoration(
                        color: StaticColor.grey100F6,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(children: [
                        check01 == true
                            ? Image.asset('assets/signin/policy_check_done.png',
                                width: 20, height: 20)
                            : Image.asset('assets/signin/policy_check_empty.png',
                                width: 20, height: 20),
                        const SizedBox(width: 8.0),
                        Text('친구',
                            style: TextStyle(
                                fontSize: 14,
                                color: StaticColor.grey70055,
                                fontWeight: FontWeight.w400)),
                      ])),
                ),
                const SizedBox(height: 8.0),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      check02 = !check02;
                    });
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                      decoration: BoxDecoration(
                        color: StaticColor.grey100F6,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(children: [
                        check02 == true
                            ? Image.asset('assets/signin/policy_check_done.png',
                                width: 20, height: 20)
                            : Image.asset('assets/signin/policy_check_empty.png',
                                width: 20, height: 20),
                        const SizedBox(width: 8.0),
                        Text('가족',
                            style: TextStyle(
                                fontSize: 14,
                                color: StaticColor.grey70055,
                                fontWeight: FontWeight.w400)),
                      ])),
                ),
                const SizedBox(height: 8.0),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      check03 = !check03;
                    });
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                      decoration: BoxDecoration(
                        color: StaticColor.grey100F6,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(children: [
                        check03 == true
                            ? Image.asset('assets/signin/policy_check_done.png',
                                width: 20, height: 20)
                            : Image.asset('assets/signin/policy_check_empty.png',
                                width: 20, height: 20),
                        const SizedBox(width: 8.0),
                        Text('연인',
                            style: TextStyle(
                                fontSize: 14,
                                color: StaticColor.grey70055,
                                fontWeight: FontWeight.w400)),
                      ])),
                ),
                const SizedBox(height: 8.0),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      check04 = !check04;
                    });
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                      decoration: BoxDecoration(
                        color: StaticColor.grey100F6,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(children: [
                        check04 == true
                            ? Image.asset('assets/signin/policy_check_done.png',
                                width: 20, height: 20)
                            : Image.asset('assets/signin/policy_check_empty.png',
                                width: 20, height: 20),
                        const SizedBox(width: 8.0),
                        Text('직장',
                            style: TextStyle(
                                fontSize: 14,
                                color: StaticColor.grey70055,
                                fontWeight: FontWeight.w400)),
                      ])),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
