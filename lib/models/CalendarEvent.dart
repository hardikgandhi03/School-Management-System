class CalendarEvent {
  final String title;

  CalendarEvent({required this.title});

  String toString() => this.title;
}

List<List<CalendarEvent>> timetable = [
  // Mon
  [
    CalendarEvent(title: 'Maths'),
    CalendarEvent(title: 'Maths'),
    CalendarEvent(title: 'Science'),
    CalendarEvent(title: 'English'),
    CalendarEvent(title: 'Gujarati'),
    CalendarEvent(title: 'Social Science'),
  ],
  //Tue
  [
    CalendarEvent(title: 'English'),
    CalendarEvent(title: 'Gujarati'),
    CalendarEvent(title: 'Social Science'),
    CalendarEvent(title: 'Maths'),
    CalendarEvent(title: 'Maths'),
    CalendarEvent(title: 'Science'),
  ],
  // Wed
  [
    CalendarEvent(title: 'Maths'),
    CalendarEvent(title: 'Maths'),
    CalendarEvent(title: 'Social Science'),
    CalendarEvent(title: 'Science'),
    CalendarEvent(title: 'English'),
    CalendarEvent(title: 'Gujarati'),
  ],
  // Thu
  [
    CalendarEvent(title: 'Maths'),
    CalendarEvent(title: 'Gujarati'),
    CalendarEvent(title: 'Social Science'),
    CalendarEvent(title: 'Maths'),
    CalendarEvent(title: 'Science'),
    CalendarEvent(title: 'English'),
  ],
  // Fri
  [
    CalendarEvent(title: 'Social Science'),
    CalendarEvent(title: 'Maths'),
    CalendarEvent(title: 'English'),
    CalendarEvent(title: 'Gujarati'),
    CalendarEvent(title: 'Maths'),
    CalendarEvent(title: 'Science'),
  ],
  // Sat
  [
    CalendarEvent(title: 'Maths'),
    CalendarEvent(title: 'English'),
    CalendarEvent(title: 'Gujarati'),
    CalendarEvent(title: 'Maths'),
    CalendarEvent(title: 'Social Science'),
    CalendarEvent(title: 'Science'),
  ],
];
