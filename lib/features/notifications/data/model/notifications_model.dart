class NotificationsModel {
  final String? id;
  final int? userId;
  final String title;
  final String message;
  final String date;
  final String? type;
  final int? typeId;
  final String? readAt;

  NotificationsModel({
    this.id,
    this.userId,
    required this.title,
    required this.message,
    required this.date,
    this.type,
    this.typeId,
    this.readAt,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
      id: json['id'] ?? "",
      userId: json['user_id'] != null
          ? int.tryParse(json['user_id'].toString())
          : null,
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      date: json['created_at'] ?? '',
      type: json['type']?.toString(),
      typeId: json['type_id'] != null
          ? int.tryParse(json['type_id'].toString())
          : null,
      readAt: json['read_at']?.toString(),
    );
  }

  static List<NotificationsModel> fromJsonList(List json) {
    return json.map((e) => NotificationsModel.fromJson(e)).toList();
  }
}
