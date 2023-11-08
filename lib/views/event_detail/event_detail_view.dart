import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';
import 'package:sense_flutter_application/views/event_detail/event_detail_header.dart';
import 'package:sense_flutter_application/views/event_detail/event_detail_provider.dart';
import 'package:sense_flutter_application/views/event_detail/event_detail_tab_bar.dart';
import 'package:sense_flutter_application/views/event_detail/plan/event_plan_view.dart';

class EventDetailView extends StatefulWidget {
  final int eventId;
  const EventDetailView({super.key, required this.eventId});

  @override
  State<EventDetailView> createState() => _EventDetailViewState();
}

class _EventDetailViewState extends State<EventDetailView> {
  final GlobalKey<ScaffoldState> key = GlobalKey();
  late Future initEventData;

  @override
  void initState() {
    super.initState();
    context.read<EDProvider>().clear(false);
    initEventData = _initEventData();
  }

  Future<EventModel> _initEventData() async {
    EventModel result = await EventRequest().eventRequest(widget.eventId);
    return result;
  }

  @override
  Widget build(BuildContext context) {
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
                  SizedBox(
                    height: 32.0.h,
                  )
                ],
              );
            }
          }
          return const SizedBox.shrink();
        });
  }
}
