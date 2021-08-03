class ExamSchedule {
  String from;
  String to;
  String date;
  String subjectName;

  ExamSchedule({
    required this.from,
    required this.to,
    required this.subjectName,
    required this.date,
  });

  factory ExamSchedule.fromJson(Map<String, dynamic> json) {
    return ExamSchedule(
      from: json['from'] ?? '',
      to: json['to'] ?? '',
      date: json['date'] ?? '',
      subjectName: json['subjectName'] ?? '',
    );
  }
}
