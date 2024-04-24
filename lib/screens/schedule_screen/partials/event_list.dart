import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sense_flutter_application/screens/widgets/common/event_tile.dart';
import 'package:sense_flutter_application/store/providers/Schedule/event_collection.dart';

class EventList extends ConsumerWidget {
  const EventList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime calendar = ref.watch(calendarSelectorProvider);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
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
          // List of Events
          const Text(
            '03.01',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF555555),
            ),
          ),
          const SizedBox(
            height: 8,
          ),

          ...List.generate(
              10,
              (index) => const Column(
                    children: [
                      EventTile(),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
        ],
      ),
    );
  }
}
