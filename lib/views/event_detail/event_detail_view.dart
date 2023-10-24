import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';
import 'package:sense_flutter_application/views/event_detail/event_detail_header.dart';
import 'package:sense_flutter_application/views/event_detail/event_detail_provider.dart';
import 'package:sense_flutter_application/views/event_detail/event_detail_tab_bar.dart';
import 'package:sense_flutter_application/views/event_detail/plan/event_plan_view.dart';

class EventDetailView extends StatefulWidget {
  int eventId;
  EventDetailView({super.key, required this.eventId});

  @override
  State<EventDetailView> createState() => _EventDetailViewState();
}

class _EventDetailViewState extends State<EventDetailView> {

  final GlobalKey<ScaffoldState> key = GlobalKey();
  late Future initEventData;

  @override
  void initState() {
    initEventData = _initEventData();
    super.initState();
  }

  Future<EventModel> _initEventData() async {
    EventModel result = await EventRequest().eventRequest(widget.eventId);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    /// safe area height
    // final safeAreaTopPadding = MediaQuery.of(context).padding.top;
    // final safeAreaBottomPadding = MediaQuery.of(context).padding.bottom;

    // return Consumer<EDProvider>(
    //   builder: (context, provider, child) {
    //     return FutureBuilder(
    //       future: initEventData, 
    //       builder: (context, snapshot) {
    //         if (snapshot.connectionState == ConnectionState.waiting) {
    //           return const SizedBox.shrink();
    //         } else if (snapshot.connectionState == ConnectionState.done) {
    //           if (snapshot.hasError) {
    //             return const SizedBox.shrink();
    //           } else if (snapshot.hasData) {
    //             EventModel loadEventModel = snapshot.data;
    //             context.read<EDProvider>().setEventModel(eventModel: loadEventModel, test: 2222);

    //             return Column(
    //               children: [
    //                 /// 이벤트 타이틀 변경이 일어나면 헤더도 변화
    //                 // Consumer<CreateEventImproveProvider>(
    //                 //   builder: (context, data, child) {
    //                 //     String title = data.title;
    //                 //     return EventInfoHeader(eventModel: loadEventModel, title: title);
    //                 //   }
    //                 // ),
    //                 // EventInfoTabBar(),
    //                 // Expanded(child: ScrollConfiguration(
    //                 //   behavior: const ScrollBehavior().copyWith(overscroll: false),
    //                 //   child: SingleChildScrollView(child: EventContent(visitCount: widget.visitCount, recommendCount: widget.recommendCount)))),
    //               ],
    //             );
    //           }
    //         }
    //         return const SizedBox.shrink();
    //       }
    //     );
    //   },
    // );

    return FutureBuilder(
      future: initEventData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const SizedBox.shrink();
          } else if (snapshot.hasData) {
            EventModel loadEventModel = snapshot.data;
            context.read<EDProvider>().initState(loadEventModel, false);
            // EnumEventDetailTab tabState = context.read<EDProvider>().eventDetailTabState;
            // EventModel eventModel = context.read<EDProvider>().eventModel ?? EventModel();

            return Column(
              children: [
                const EventDetailHeader(),
                const EventDetailTabBar(),
                SizedBox(
                  height: 16.0.h,
                ),
                Consumer<EDProvider>(
                  builder: (context, data, child) {
                    if (data.eventDetailTabState == EnumEventDetailTab.plan) {
                      return const EventPlanView();
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                /// 이벤트 타이틀 변경이 일어나면 헤더도 변화
                // Consumer<CreateEventImproveProvider>(
                //   builder: (context, data, child) {
                //     String title = data.title;
                //     return EventInfoHeader(eventModel: loadEventModel, title: title);
                //   }
                // ),
                // EventInfoTabBar(),
                // Expanded(child: ScrollConfiguration(
                //   behavior: const ScrollBehavior().copyWith(overscroll: false),
                //   child: SingleChildScrollView(child: EventContent(visitCount: widget.visitCount, recommendCount: widget.recommendCount)))),
              ],
            );
          }
        }
        return const SizedBox.shrink();
        // if(snapshot.hasError) {
        //   return const SizedBox.shrink();
        // } else if(snapshot.hasData) {
        //   if(snapshot.connectionState == ConnectionState.waiting) {
        //     return const SizedBox.shrink();
        //   } else if(snapshot.connectionState == ConnectionState.done) {

        //     EventModel loadEventModel = snapshot.data ?? EventModel();
        //     context.read<CreateEventImproveProvider>().eventModelChange(loadEventModel);

        //     String title = loadEventModel.eventTitle ?? '';
        //     context.read<CreateEventImproveProvider>().eventDataLoad(
        //       loadEventModel.eventTitle ?? '',
        //       loadEventModel.eventCategoryObject!.id ?? -1,
        //       loadEventModel.targetCategoryObject!.id ?? -1,
        //       loadEventModel.eventDate ?? '',
        //       loadEventModel.description ?? '',
        //     );
        //     context.read<CreateEventProvider>().cityInitLoad(loadEventModel.city!.id!);

        //     SenseLogger().debug(
        //       '${context.read<CreateEventImproveProvider>().title}\n' +
        //       '${context.read<CreateEventImproveProvider>().category}\n' +
        //           '${context.read<CreateEventImproveProvider>().target}\n' +
        //           '${context.read<CreateEventImproveProvider>().date}\n' +
        //           '${context.read<CreateEventImproveProvider>().memo}\n'
        //     );

        //     return Column(
        //       children: [
        //         /// 이벤트 타이틀 변경이 일어나면 헤더도 변화
        //         Consumer<CreateEventImproveProvider>(
        //           builder: (context, data, child) {
        //             String title = data.title;
        //             return EventInfoHeader(eventModel: loadEventModel, title: title);
        //           }
        //         ),
        //         EventInfoTabBar(),
        //         Expanded(child: ScrollConfiguration(
        //           behavior: const ScrollBehavior().copyWith(overscroll: false),
        //           child: SingleChildScrollView(child: EventContent(visitCount: widget.visitCount, recommendCount: widget.recommendCount)))),
        //       ],
        //     );

        //   } else {
        //     return const SizedBox.shrink();
        //   }
        // } else {
        //   return const SizedBox.shrink();
        // }
      }
    );
  }
}