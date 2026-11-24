import 'package:booking/features/properties/home/data/model/property_data_model.dart';

class ChatResponseModel {
  final String sessionId;
  final String reply;
  final List<PropertyDataModel> suggestedHotels;

  ChatResponseModel({
    required this.sessionId,
    required this.reply,
    required this.suggestedHotels,
  });

  factory ChatResponseModel.fromJson(Map<String, dynamic> json) {
    List<PropertyDataModel> hotels = [];
    if (json['suggested_hotels'] is List) {
      hotels = (json['suggested_hotels'] as List)
          .map((item) => PropertyDataModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return ChatResponseModel(
      sessionId: json['session_id']?.toString() ?? '',
      reply: json['reply']?.toString() ?? '',
      suggestedHotels: hotels,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'session_id': sessionId,
      'reply': reply,
      'suggested_hotels': suggestedHotels,
    };
  }
}
