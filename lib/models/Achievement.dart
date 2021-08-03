class Achievement {
  String title;
  String description;
  String rank;

  Achievement({
    required this.description,
    required this.title,
    required this.rank,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      rank: json['rank'] ?? '',
    );
  }
}
