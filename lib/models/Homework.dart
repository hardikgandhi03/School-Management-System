class Homework {
  String subjectName;
  String title;
  String issueDate;
  String dueDate;
  String description;
  String attachment;
  String id;

  Homework({
    required this.description,
    required this.title,
    required this.attachment,
    required this.dueDate,
    required this.issueDate,
    required this.id,
    required this.subjectName,
  });

  factory Homework.fromJson(Map<String, dynamic> json) {
    return Homework(
      title: json['title'] ?? '',
      attachment: json['attachment'] ?? '',
      description: json['description'] ?? '',
      dueDate: json['dueDate'] ?? '',
      issueDate: json['dateAssigned'] ?? '',
      subjectName: json['subjectName'] ?? '',
      id: json['ID'] ?? '',
    );
  }
}
