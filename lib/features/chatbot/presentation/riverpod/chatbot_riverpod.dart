import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/state/state.dart';
import '../../data/model/chat_message_model.dart';
import '../../data/repos/chatbot_repo.dart';

class ChatbotState {
  final States state;
  final List<ChatMessageModel> messages;
  final String? sessionId;
  final bool isSending;
  final DioException? exception;
  final String? errorMessage;

  const ChatbotState({
    required this.state,
    required this.messages,
    this.sessionId,
    this.isSending = false,
    this.exception,
    this.errorMessage,
  });

  factory ChatbotState.initial() {
    return const ChatbotState(
      state: States.initial,
      messages: [],
      sessionId: null,
      isSending: false,
      exception: null,
      errorMessage: null,
    );
  }

  ChatbotState copyWith({
    States? state,
    List<ChatMessageModel>? messages,
    String? sessionId,
    bool? isSending,
    DioException? exception,
    String? errorMessage,
  }) {
    return ChatbotState(
      state: state ?? this.state,
      messages: messages ?? this.messages,
      sessionId: sessionId ?? this.sessionId,
      isSending: isSending ?? this.isSending,
      exception: exception,
      errorMessage: errorMessage,
    );
  }
}

final chatbotProvider =
    StateNotifierProvider<ChatbotNotifier, ChatbotState>((ref) {
  return ChatbotNotifier();
});

class ChatbotNotifier extends StateNotifier<ChatbotState> {
  final ChatbotRepository _repository = ChatbotRepository();

  ChatbotNotifier() : super(ChatbotState.initial());

  Future<void> sendMessage(String text) async {
    final cleanText = text.trim();
    if (cleanText.isEmpty || state.isSending) return;

    final userMessage = ChatMessageModel.user(cleanText);
    final updatedMessages = [...state.messages, userMessage];

    state = state.copyWith(
      state: States.loading,
      messages: updatedMessages,
      isSending: true,
      errorMessage: null,
      exception: null,
    );

    final result = await _repository.sendMessage(
      message: cleanText,
      sessionId: state.sessionId,
    );

    result.fold(
      (exception) {
        const errorMsg =
            'تعذر الاتصال بالمساعد، يرجى التأكد من تشغيل السيرفر والمحاولة مجدداً.';
        final assistantError = ChatMessageModel(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          text: errorMsg,
          isUser: false,
          timestamp: DateTime.now(),
          hasError: true,
        );

        state = state.copyWith(
          state: States.error,
          messages: [...state.messages, assistantError],
          isSending: false,
          exception: exception,
          errorMessage: errorMsg,
        );
      },
      (response) {
        final assistantMessage = ChatMessageModel.assistant(
          text: response.reply,
          suggestedHotels: response.suggestedHotels,
        );

        state = state.copyWith(
          state: States.loaded,
          messages: [...state.messages, assistantMessage],
          sessionId: response.sessionId,
          isSending: false,
        );
      },
    );
  }

  void clearConversation() {
    state = ChatbotState.initial();
  }
}
