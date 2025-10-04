class NotificationsModel {
  int? id;

  int? userId;
  final String title;
  final String message;
  final String date;

  NotificationsModel({
    this.id,
    this.userId,
    required this.title,
    required this.message,
    required this.date,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      message: json['message'],
      date: json['created_at'],
    );
  }
  static List<NotificationsModel> fromJsonList(List json) {
    return json.map((e) => NotificationsModel.fromJson(e)).toList();
  }
}
