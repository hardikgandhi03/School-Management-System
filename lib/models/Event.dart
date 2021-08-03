class Event {
  String title;
  String description;
  String time;
  String date;
  String img;

  Event({
    required this.description,
    required this.title,
    this.time = '',
    required this.date,
    this.img = '',
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      img: json['img'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
    );
  }
}
