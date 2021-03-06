import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils.dart';
import '../widgets/bottom_navigation_bar.dart';

class MonthlyViewCalendar extends StatefulWidget {
  static const routeName = '/monthly-view';
  @override
  _MonthlyViewCalendarState createState() => _MonthlyViewCalendarState();
}

class _MonthlyViewCalendarState extends State<MonthlyViewCalendar> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  // RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
  //     .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;



  @override
  void initState() {
    super.initState();

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
        _calendarFormat = CalendarFormat.week;
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
    return  Column(
      children: [
        TableCalendar<Event>(
          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          rangeStartDay: _rangeStart,
          rangeEndDay: _rangeEnd,
          calendarFormat: _calendarFormat,
          eventLoader: _getEventsForDay,
          startingDayOfWeek: StartingDayOfWeek.monday,
          headerVisible: true,
          availableGestures: AvailableGestures.all,
          availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
              CalendarFormat.week: 'Week',
            },
          calendarStyle: CalendarStyle(
            // Use `CalendarStyle` to customize the UI
            outsideDaysVisible: true,
          ),
          onDaySelected: _onDaySelected,
          // onRangeSelected: _onRangeSelected,
          onFormatChanged: (format) {
            if (_calendarFormat != CalendarFormat.month) {
              setState(() {
                _calendarFormat = CalendarFormat.month;
              });
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
        ),
        const SizedBox(height: 100.0),
        // Expanded(
        //   child: ValueListenableBuilder<List<Event>>(
        //     valueListenable: _selectedEvents,
        //     builder: (context, value, _) {
        //       return ListView.builder(
        //         itemCount: value.length,
        //         itemBuilder: (context, index) {
        //           return Container(
        //             margin: const EdgeInsets.symmetric(
        //               horizontal: 12.0,
        //               vertical: 4.0,
        //             ),
        //             decoration: BoxDecoration(
        //               border: Border.all(),
        //               borderRadius: BorderRadius.circular(12.0),
        //             ),
        //             child: ListTile(
        //               onTap: () => print('${value[index]}'),
        //               title: Text('${value[index]}'),
        //             ),
        //           );
        //         },
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}