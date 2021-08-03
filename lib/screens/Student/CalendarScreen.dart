import 'package:flutter/material.dart';
import 'package:school_management_system/models/CalendarEvent.dart';
import 'package:school_management_system/utils/constants.dart';
import 'package:school_management_system/widgets/CustomScaffold.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  static final id = 'CalendarScreen';

  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  late List<CalendarEvent> _selectedEvents;

  bool _isAttendanceVisible = false;

  @override
  void initState() {
    _selectedEvents = _getEventsFromDay(_selectedDay);
    super.initState();
  }

  List<CalendarEvent> _getEventsFromDay(DateTime date) {
    if (!date.isAfter(DateTime.now()))
      return date.weekday == 7 ? [] : timetable[date.weekday - 1];
    else
      return [];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Calendar',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            startingDayOfWeek: StartingDayOfWeek.monday,
            eventLoader: _getEventsFromDay,

            //Style elements to format calendar
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            calendarStyle: CalendarStyle(
              holidayTextStyle: TextStyle(
                color: Colors.blue.shade500,
              ),
              markerDecoration: BoxDecoration(),
              holidayDecoration: BoxDecoration(),
              selectedDecoration: BoxDecoration(
                color: kPrimaryBlue,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: kSecondaryBlue,
                shape: BoxShape.circle,
              ),
              // markerDecoration: BoxDecoration(),
            ),

            holidayPredicate: (DateTime day) {
              if (day.weekday == 7)
                return true;
              else
                return false;
            },

            // Functions to change selected day
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
              _selectedEvents = _getEventsFromDay(_selectedDay);
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          SizedBox(
            height: 10.0,
          ),
          _selectedEvents.length > 0
              ? Container(
                  decoration: BoxDecoration(
                    color: kPrimaryBlue,
                    borderRadius: BorderRadius.circular(40.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: const Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ), //Bo
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                    // vertical: 8.0,
                    horizontal: 20.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Attendance',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _isAttendanceVisible = !_isAttendanceVisible;
                          });
                        },
                        icon: Icon(
                          Icons.arrow_drop_down_circle_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox(),
          _isAttendanceVisible
              ? Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    itemCount: _selectedEvents.length,
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade400,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () => print('${_selectedEvents[index].toString()}'),
                        title: Text(
                          '${_selectedEvents[index].toString()}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        trailing: CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Text('P'),
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
