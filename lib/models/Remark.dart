class Remark {
  final String subjectName;
  final String description;
  bool status;

  Remark({
    required this.subjectName,
    required this.description,
    required this.status,
  });

  factory Remark.fromJson(Map<String, dynamic> json) {
    return Remark(
      subjectName: json['subjectName'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] == '0' ? false : true,
    );
  }
}
