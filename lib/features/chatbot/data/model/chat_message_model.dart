import 'package:booking/features/properties/home/data/model/property_data_model.dart';

class ChatMessageModel {
  final String id;
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final List<PropertyDataModel> suggestedHotels;
  final bool isLoading;
  final bool hasError;

  ChatMessageModel({
    required this.id,
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.suggestedHotels = const [],
    this.isLoading = false,
    this.hasError = false,
  });

  ChatMessageModel copyWith({
    String? id,
    String? text,
    bool? isUser,
    DateTime? timestamp,
    List<PropertyDataModel>? suggestedHotels,
    bool? isLoading,
    bool? hasError,
  }) {
    return ChatMessageModel(
      id: id ?? this.id,
      text: text ?? this.text,
      isUser: isUser ?? this.isUser,
      timestamp: timestamp ?? this.timestamp,
      suggestedHotels: suggestedHotels ?? this.suggestedHotels,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }

  factory ChatMessageModel.user(String message) {
    return ChatMessageModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      text: message,
      isUser: true,
      timestamp: DateTime.now(),
    );
  }

  factory ChatMessageModel.assistant({
    required String text,
    List<PropertyDataModel> suggestedHotels = const [],
  }) {
    return ChatMessageModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      text: text,
      isUser: false,
      timestamp: DateTime.now(),
      suggestedHotels: suggestedHotels,
    );
  }
}
