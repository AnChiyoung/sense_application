import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sense_flutter_application/screens/widgets/common/event_tile.dart';
import 'package:sense_flutter_application/store/providers/Schedule/event_collection.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';

class EventList extends ConsumerWidget {
  final ScrollController controller;
  const EventList({super.key, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue fetch = ref.watch(futureFetchEventsProvider);
    List<dynamic> events = ref.watch(eventCollectionProvider)['data'] ?? [];
    DateTime calendar = ref.watch(calendarSelectorProvider);
    if (fetch.isLoading) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(primaryColor[50] ?? Colors.white),
        ),
      );
    }

    if (events.isEmpty) {
      return CustomScrollView(
          // animation: controller,
          controller: controller,
          slivers: [
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'lib/assets/images/icons/svg/warning_circle.svg',
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      '아직 이벤트가 없습니다.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF999999),
                      ),
                    )
                  ],
                ),
              ),
            )
          ]);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 8, right: 20, left: 20),
      physics: const NeverScrollableScrollPhysics(),
      controller: controller,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current Month
          Text(
            '${calendar.month}월 전체',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          // List of Events,

          ...events.map((item) {
            DateTime date = DateTime.parse(item['date']);
            List<Widget> eventWidgets = item['events'].map<Widget>((event) {
              print(event['event_category']['id']);
              return Column(
                children: [
                  EventTile(
                      eventType: event['event_category']['id'] as int,
                      isPublic: event['public_type'] == 'PUBLIC',
                      date: DateTime.parse(event['date']),
                      title: event['title'],
                      withSomeone: event['contact_category']['title'],
                      location: event['sub_city']?['title'] ?? '',
                      eventName: event['event_category']['title']),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            }).toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('MM.dd').format(date),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF555555),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                ...eventWidgets,
              ],
            );
          }),
        ],
      ),
    );
  }
}
