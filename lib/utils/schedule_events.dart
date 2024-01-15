import 'dart:collection';
import 'package:table_calendar/table_calendar.dart';

class Event {
  const Event(this.title, this.description, this.time);

  final String title;
  final String description;
  final String time;

  @override
  String toString() => '$title - $description - $time';
}

final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = {
  DateTime.utc(kToday.year, kToday.month, 14): [
    const Event(
        'Pengambilan Sampah Organik',
        'Staff Hejokeun akan mengambil sampah organik di perumahan Anda',
        '10:00'),
    const Event(
        'Pengambilan Sampah Organik',
        'Staff Hejokeun akan mengambil sampah organik di perumahan Anda',
        '11:00'),
  ]
};

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
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
