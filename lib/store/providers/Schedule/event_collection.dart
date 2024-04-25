import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sense_flutter_application/apis/events/events_api.dart';

final calendarSelectorProvider = StateProvider.autoDispose<DateTime>((ref) {
  return DateTime.now();
});

final futureFetchEventsProvider = FutureProvider.autoDispose<void>((ref) async {
  return ref
      .read(eventCollectionProvider.notifier)
      .fetchEvents(ref.watch(calendarSelectorProvider));
});

final eventCollectionProvider =
    StateNotifierProvider.autoDispose<EventCollection, Map<String, dynamic>>((ref) {
  ref.onDispose(() {
    print('disposed eventCollectionProvider');
  });
  return EventCollection();
});

class EventCollection extends StateNotifier<Map<String, dynamic>> {
  EventCollection() : super({});

  get events => state['data'] ?? [];

  Future<void> fetchEvents(DateTime calendar) async {
    DateTime finishDate = DateTime(calendar.year, calendar.month + 1, 0);
    var dateFormat = DateFormat('yyyy-MM-dd');
    String formattedFinishDate = dateFormat.format(finishDate);
    String formattedStartDate = dateFormat.format(calendar);
    return EventsApi()
        .getEvents(
            'start_date=$formattedStartDate&&finish_date=$formattedFinishDate&&ordering=date')
        .then((value) {
      state = {...value};
    });
  }
}
