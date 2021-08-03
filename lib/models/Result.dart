class Result {
  final String subjectName;
  final String standard;
  final String score;
  final String grade;
  final String total;

  Result({
    required this.subjectName,
    required this.standard,
    required this.grade,
    required this.score,
    required this.total,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      subjectName: json['subjectName'] ?? '',
      standard: json['standard'] ?? '',
      grade: json['grade'] ?? '',
      score: json['score'] ?? '',
      total: json['total'] ?? '',
    );
  }
}
