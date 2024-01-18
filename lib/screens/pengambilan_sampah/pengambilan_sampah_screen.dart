import 'package:flutter/material.dart';
import 'package:hejokeun/components/navbar.dart';
import 'package:hejokeun/screens/pengambilan_sampah/request_pengambilan_sampah_screen.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:hejokeun/components/components.dart';
import 'package:hejokeun/utils/schedule_events.dart';
import 'package:hejokeun/utils/constants.dart';

class PengambilanSampahScreen extends StatefulWidget {
  const PengambilanSampahScreen({super.key});
  static String id = 'pengambilan_sampah_screen';

  @override
  State<PengambilanSampahScreen> createState() =>
      _PengambilanSampahScreenState();
}

class _PengambilanSampahScreenState extends State<PengambilanSampahScreen> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await initializePickupScheduleData();
    });
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });
      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60.0),
          TableCalendar<Event>(
            headerStyle: const HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
            ),
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            weekendDays: const [DateTime.sunday],
            calendarStyle: CalendarStyle(
              todayTextStyle: kBS5.copyWith(color: Colors.white),
              todayDecoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: kAG0,
              ),
              selectedTextStyle: _selectedDay!.weekday == DateTime.sunday
                  ? kBS5.copyWith(color: const Color(0xFFEE0004))
                  : _selectedDay!.day == DateTime.now().day
                      ? kBS5.copyWith(color: Colors.white)
                      : kBS5.copyWith(color: kDarkBrown),
              selectedDecoration: _selectedDay!.day != DateTime.now().day
                  ? BoxDecoration(
                      border: Border.all(
                          color: const Color(0xFF3C3C43).withOpacity(0.3)),
                      // borderRadius: BorderRadius.all(Radius.circular(4)),
                      color: Colors.transparent,
                    )
                  : const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      color: kAG0,
                    ),
              defaultTextStyle: kBS5.copyWith(color: kDarkBrown),
              weekendTextStyle: kBS5.copyWith(color: const Color(0xFFEE0004)),
              outsideDaysVisible: false,
              markerDecoration:
                  const BoxDecoration(color: kCamel, shape: BoxShape.circle),
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 16.0),
          Divider(
            height: 0,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.only(
              left: 18.0,
            ),
            child: Text(
              DateFormat('MMM d, y').format(_selectedDay!),
              style: kBS5.copyWith(color: kAG1),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return value.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 154, vertical: 124),
                        child: Column(
                          children: [
                            Icon(
                              const IconData(0xe5d8,
                                  fontFamily: 'MaterialIcons'),
                              size: 24,
                              color: const Color(0xFF3C3C43).withOpacity(0.6),
                            ),
                            const SizedBox(height: 12.0),
                            Text(
                              'Belum ada jadwal',
                              style: kBS4.copyWith(
                                  color:
                                      const Color(0xFF3C3C43).withOpacity(0.6)),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Text(value[index].time),
                            title: Text(value[index].title),
                            subtitle: Text(value[index].description),
                            leadingAndTrailingTextStyle:
                                kBS4.copyWith(color: kDarkBrown),
                            titleTextStyle: kBR4.copyWith(color: kDarkBrown),
                            subtitleTextStyle: kBR5.copyWith(color: kBrown),
                          );
                        },
                      );
              },
            ),
          ),
          Center(
            child: CustomButton(
                buttonText: 'Request Pengambilan di Luar Jadwal',
                isOutlined: true,
                textColor: kAG1,
                onPressed: () {
                  Navigator.pushNamed(
                      context, RequestPengambilanSampahScreen.id);
                }),
          ),
          const SizedBox(height: 30.0),
        ],
      ),
      bottomNavigationBar: const Navbar(
        currentIndex: 1,
      ),
    );
  }
}
