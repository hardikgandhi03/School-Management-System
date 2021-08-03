class Period {
  String number;
  String subjectName;
  String teacherName;
  String timing;
  bool isLunch;
  Period({
    this.number = '0',
    this.subjectName = '',
    this.teacherName = '',
    required this.timing,
    this.isLunch = false,
  });

  factory Period.fromJson(Map<String, dynamic> json) {
    return Period(
      subjectName: json['subjectName'],
      timing: json['timing'],
      teacherName: json['teacherName'],
      number: json['ID'],
    );
  }
}
