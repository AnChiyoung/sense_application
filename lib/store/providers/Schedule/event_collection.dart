import 'package:flutter_riverpod/flutter_riverpod.dart';

final calendarSelectorProvider = StateProvider.autoDispose<DateTime>((ref) {
  return DateTime.now();
});
