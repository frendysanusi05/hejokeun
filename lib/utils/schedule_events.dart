import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:table_calendar/table_calendar.dart';

class Event {
  const Event(this.title, this.description, this.time);

  final String title;
  final String description;
  final String time;

  @override
  String toString() => '$title - $description - $time';
}

late LinkedHashMap<DateTime, List<Event>> kEvents;

late Query scheduleQuery;

late List<QueryDocumentSnapshot>? scheduleDocuments;

Future<void> initializePickupScheduleData() async {
  scheduleQuery = FirebaseFirestore.instance
      .collection('pickup_schedule')
      .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid);

  scheduleDocuments = await getScheduleDocuments();

  var eventtMap = <DateTime, List<Event>>{};
  for (var event in _kEventSource) {
    var key = event.keys.first;
    var value = event.values.first;

    if (eventtMap.containsKey(key)) {
      eventtMap[key]!.addAll(value);
    } else {
      eventtMap[key] = value;
    }
  }

  kEvents = LinkedHashMap<DateTime, List<Event>>(
    equals: isSameDay,
    hashCode: getHashCode,
  )..addAll(eventtMap);
}

Future<List<QueryDocumentSnapshot>?> getScheduleDocuments() async {
  try {
    QuerySnapshot scheduleSnapshot = await scheduleQuery.get();
    List<QueryDocumentSnapshot> scheduleDocuments = scheduleSnapshot.docs;
    if (scheduleDocuments.isNotEmpty) {
      return scheduleDocuments;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

final _kEventSource = {
  for (QueryDocumentSnapshot document in scheduleDocuments!)
    {
      DateTime.utc(
          getYearFromTimeStamp(
              (document.data() as Map<String, dynamic>)['time']),
          getMonthFromTimeStamp(
              (document.data() as Map<String, dynamic>)['time']),
          getDayFromTimeStamp(
              (document.data() as Map<String, dynamic>)['time'])): [
        Event(
          'Pengambilan Sampah ${capitalize((document.data() as Map<String, dynamic>)['type'])}',
          'Staff Hejokeun akan mengambil sampah ${(document.data() as Map<String, dynamic>)['type']} di perumahan Anda',
          getTimeFromTimestamp(
              (document.data() as Map<String, dynamic>)['time']),
        ),
      ]
    }
};

String getTimeFromTimestamp(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  return '${dateTime.hour}:${dateTime.minute}';
}

int getYearFromTimeStamp(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  return dateTime.year;
}

int getMonthFromTimeStamp(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  return dateTime.month;
}

int getDayFromTimeStamp(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  return dateTime.day;
}

String capitalize(String input) {
  if (input.isEmpty) {
    return input;
  }
  return input[0].toUpperCase() + input.substring(1);
}

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
