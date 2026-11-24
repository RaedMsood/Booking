import '../../../../core/network/remote_request.dart';
import '../../../../core/network/urls.dart';
import '../model/chat_response_model.dart';

class ChatbotRemoteDataSource {
  Future<ChatResponseModel> sendMessage({
    required String message,
    String? sessionId,
  }) async {
    final Map<String, dynamic> body = {
      'message': message,
      if (sessionId != null && sessionId.isNotEmpty) 'session_id': sessionId,
    };

    final response = await RemoteRequest.postData(
      path: AppURL.aiChatMessage,
      data: body,
    );

    return ChatResponseModel.fromJson(response.data as Map<String, dynamic>);
  }
}
