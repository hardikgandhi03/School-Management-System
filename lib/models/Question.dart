class Question {
  String teacherID;
  String subjectID;
  String title;
  String description;
  int status;
  String id;

  Question({
    required this.teacherID,
    required this.subjectID,
    required this.title,
    required this.description,
    this.status = 0,
    this.id = '',
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      status: int.parse(json['status'] ?? 0),
      description: json['description'] ?? '',
      teacherID: json['teacherID'] ?? '',
      title: json['title'] ?? '',
      subjectID: json['subjectID'] ?? '',
      id: json['ID'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'teacherID': this.teacherID,
      'subjectID': this.subjectID,
      'title': this.title,
      'description': this.description,
      'status': this.status,
      'id': this.id,
    };
  }

  Question update(Question ptm) {
    this.description = ptm.description;
    this.teacherID = ptm.teacherID;
    this.subjectID = ptm.subjectID;
    this.title = ptm.title;
    return this;
  }
}
