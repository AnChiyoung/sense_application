// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';

/// Example event class.
class Event {
  final String title;
  final String time;
  final String location;
  const Event(this.title, this.time, this.location);
  @override
  String toString() => title;
}

String aa = DateTime.utc(2023,2,18).toString();
Map<String, List<Event>> sampleEvent = {
  aa : [
    Event('SENSE LAUNCHING', '경기도 성남시 분당구 판교', '하루종일'),
    Event('SENSE 매출 10억', '경기도 성남시 분당구 판교', '하루종일'),
    Event('SENSE 매출 100억', '경기도 성남시 분당구 판교', '하루종일'),
    Event('SENSE 매출 로또 1등 10회 분', '경기도 성남시 분당구 판교', '하루종일')],
};

// final kEvents = LinkedHashMap<DateTime, List<Event>>(
//   equals: isSameDay,
//   hashCode: getHashCode,
// )..addAll(_kEventSource);

// final _kEventSource = {
//   for (var item in List.generate(50, (index) => index)) DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5) : List.generate(
//         item % 4 + 1, (index) => Event('Event $item | ${index + 1}')) }
//   ..addAll({
//     kToday: [
//       const Event('Today\'s Event 1'),
//       const Event('Today\'s Event 2'),
//     ],
//   });

// final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
//     key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
//     value: (item) => List.generate(
//         item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
//   ..addAll({
//     kToday: [
//       const Event('Today\'s Event 1'),
//       const Event('Today\'s Event 2'),
//     ],
//   });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
        (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);