class LeaveApplication {
  String from;
  String to;
  String title;
  String description;
  int approved;
  String id;

  LeaveApplication({
    required this.from,
    required this.to,
    required this.title,
    required this.description,
    this.approved = 0,
    this.id = '',
  });

  factory LeaveApplication.fromJson(Map<String, dynamic> json) {
    return LeaveApplication(
      approved: int.parse(json['approved'] ?? 0),
      description: json['description'] ?? '',
      from: json['from'] ?? '',
      title: json['title'] ?? '',
      to: json['to'] ?? '',
      id: json['ID'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'from': this.from,
      'to': this.to,
      'title': this.title,
      'description': this.description,
      'approved': this.approved,
      'id': this.id,
    };
  }

  LeaveApplication update(LeaveApplication leaveApplication) {
    this.description = leaveApplication.description;
    this.from = leaveApplication.from;
    this.to = leaveApplication.to;
    this.title = leaveApplication.title;
    return this;
  }
}
