// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

/// Example event class.
class Event {
  final String title;
  final String location;
  final String time;
  const Event(this.title, this.location, this.time);
  @override
  String toString() => title;
}

String eventKey = DateFormat('yyyy-MM-dd').format(DateTime.utc(2023,2,18)).toString();
Map<DateTime, List<Event>> sampleEvent = {
  DateTime.utc(2023,3,1) : [
    Event('SENSE LAUNCHING', '경기도 성남시 분당구 판교', '하루종일'),
    Event('SENSE 회의', '경기도 성남시 분당구 판교', '10am - 11am'),
    Event('퇴근', '경기도 성남시 분당구 판교', '8pm')],
  DateTime.utc(2023,3,12) : [
    Event('생일', '스타벅스 강남점', '3pm - 6pm')],
  DateTime.utc(2023,3,18) : [
    Event('탄천 걷기', '서현역 - 죽전역', '6am - 8am'),
    Event('광장시장 빈대떡', '을지로 3가 광장시장', '12pm - 2pm'),
    Event('이건희 일대기', '서울 현대미술관', '4pm - 5pm')],
};

final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = {
  for (var item in List.generate(50, (index) => index)) DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5) : List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}', '', '')) }
  ..addAll({
    kToday: [
      const Event('Today\'s Event 1', '', ''),
      const Event('Today\'s Event 2', '', ''),
    ],
  });

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
final kFirstDay = DateTime(kToday.year, 1, 1);
final kLastDay = DateTime(kToday.year + 3, 12, 31);
